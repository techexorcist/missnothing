import 'dart:convert';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

import 'package:missnothing/config/app_config.dart';
import 'package:missnothing/data/gmail/from_header.dart';
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

class AllowlistedFetch {
  const AllowlistedFetch({
    required this.notes,
    this.hit,
  });

  final AllowlistedCircular? hit;
  final List<String> notes;
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

/// Fetch allowlisted mail (including Spam/Trash). Returns the newest message
/// that parses as any type. Skip reasons are always logged so a parser miss
/// is not mistaken for an empty inbox.
Future<AllowlistedFetch> fetchAllowlistedCircular(GmailApi gmail) async {
  final listed = await gmail.users.messages.list(
    'me',
    q: 'from:${AppConfig.allowlistedFrom} newer_than:30d',
    includeSpamTrash: true,
    maxResults: 25,
  );
  final refs = listed.messages;
  if (refs == null || refs.isEmpty) {
    return const AllowlistedFetch(
      notes: ['Gmail list returned no messages (Spam/Trash included).'],
    );
  }

  final notes = <String>[];
  for (final ref in refs) {
    final id = ref.id;
    if (id == null) {
      notes.add('skip: message ref had no id');
      continue;
    }
    final message = await gmail.users.messages.get(
      'me',
      id,
      format: 'full',
    );
    final from = _header(message, 'From') ?? '';
    if (!fromMatchesAllowlist(from, AppConfig.allowlistedFrom)) {
      notes.add(
        'skip $id: mailbox "${mailboxFromFromHeader(from)}" '
        '!= ${AppConfig.allowlistedFrom} (From=$from)',
      );
      continue;
    }
    final subject = _header(message, 'Subject') ?? '(no subject)';
    final body = extractMessageText(message);
    if (body.trim().isEmpty) {
      notes.add('skip $id: empty body after normalize ($subject)');
      continue;
    }
    final parsed = parseSchoolIn(
      ParseInput(
        from: AppConfig.allowlistedFrom,
        messageDate: _messageDate(message),
        body: body,
        subject: subject,
        threadId: message.threadId,
      ),
    );
    if (parsed == null) {
      notes.add(
        'skip $id: parser returned null — nothing-found, not a Gmail miss '
        '($subject)',
      );
      continue;
    }
    notes.add(
      'used $id type=${parsed.type.name} date=${parsed.date} '
      '($subject)',
    );
    return AllowlistedFetch(
      hit: AllowlistedCircular(
        id: id,
        from: from,
        subject: subject,
        messageDate: parsed.date ?? _messageDate(message),
        body: body,
        proposal: parsed,
      ),
      notes: notes,
    );
  }
  return AllowlistedFetch(notes: notes);
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
