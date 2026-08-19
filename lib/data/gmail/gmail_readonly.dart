import 'dart:convert';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

import 'package:missnothing/config/app_config.dart';
import 'package:missnothing/data/parser/html_normalize.dart';
import 'package:missnothing/data/parser/packs/school_in.dart';
import 'package:missnothing/data/parser/proposal.dart';

class AllowlistedCircular {
  const AllowlistedCircular({
    required this.id,
    required this.from,
    required this.subject,
    required this.messageDate,
    required this.body,
    required this.proposal,
  });

  final String id;
  final String from;
  final String subject;
  final DateTime messageDate;
  final String body;
  final Proposal proposal;
}

GmailApi gmailApiForToken(String accessToken) {
  final credentials = AccessCredentials(
    AccessToken(
      'Bearer',
      accessToken,
      DateTime.now().toUtc().add(const Duration(minutes: 50)),
    ),
    null,
    const [AppConfig.gmailReadonlyScope],
  );
  return GmailApi(authenticatedClient(http.Client(), credentials));
}

/// Fetch allowlisted mail (including Spam/Trash) and return the first
/// `school_in` dated circular. Prefers a Bagless/gold-01 hit when present.
Future<AllowlistedCircular?> fetchDatedCircular(GmailApi gmail) async {
  final listed = await gmail.users.messages.list(
    'me',
    q: 'from:${AppConfig.allowlistedFrom} newer_than:30d',
    includeSpamTrash: true,
    maxResults: 25,
  );
  final refs = listed.messages;
  if (refs == null || refs.isEmpty) return null;

  AllowlistedCircular? fallback;
  for (final ref in refs) {
    final id = ref.id;
    if (id == null) continue;
    final message = await gmail.users.messages.get(
      'me',
      id,
      format: 'full',
    );
    final from = _header(message, 'From') ?? AppConfig.allowlistedFrom;
    if (!_fromMatchesAllowlist(from)) continue;
    final subject = _header(message, 'Subject') ?? '(no subject)';
    final body = extractMessageText(message);
    if (body.trim().isEmpty) continue;
    final parsed = parseSchoolIn(
      ParseInput(
        from: AppConfig.allowlistedFrom,
        messageDate: _messageDate(message),
        body: body,
        threadId: message.threadId,
      ),
    );
    if (parsed == null || parsed.type != ProposalType.datedAction) {
      continue;
    }
    final hit = AllowlistedCircular(
      id: id,
      from: from,
      subject: subject,
      messageDate: parsed.date ?? _messageDate(message),
      body: body,
      proposal: parsed,
    );
    final looksLikeGold01 = body.toLowerCase().contains('bagless');
    if (looksLikeGold01) return hit;
    fallback ??= hit;
  }
  return fallback;
}

bool _fromMatchesAllowlist(String from) {
  return from.toLowerCase().contains(AppConfig.allowlistedFrom.toLowerCase());
}

DateTime _messageDate(Message message) {
  final internal = message.internalDate;
  if (internal != null) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(internal));
  }
  return DateTime.now();
}

String? _header(Message message, String name) {
  final headers = message.payload?.headers;
  if (headers == null) return null;
  for (final h in headers) {
    if (h.name != null && h.name!.toLowerCase() == name.toLowerCase()) {
      return h.value;
    }
  }
  return null;
}

String extractMessageText(Message message) {
  final payload = message.payload;
  if (payload == null) return '';
  final plain = StringBuffer();
  final html = StringBuffer();
  _walk(payload, plain, html);
  if (plain.isNotEmpty) return normalizeBody(plain.toString());
  if (html.isNotEmpty) return normalizeBody(html.toString());
  final snippet = message.snippet;
  return snippet == null ? '' : normalizeBody(snippet);
}

void _walk(MessagePart part, StringBuffer plain, StringBuffer html) {
  final mime = part.mimeType ?? '';
  final data = part.body?.data;
  if (data != null && data.isNotEmpty) {
    final text = utf8.decode(base64Url.decode(data));
    if (mime == 'text/plain') {
      plain.writeln(text);
    } else if (mime == 'text/html') {
      html.writeln(text);
    }
  }
  for (final child in part.parts ?? const <MessagePart>[]) {
    _walk(child, plain, html);
  }
}
