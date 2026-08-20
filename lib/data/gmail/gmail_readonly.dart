import 'dart:convert';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

import 'package:missnothing/config/app_config.dart';
import 'package:missnothing/data/gmail/from_header.dart';
import 'package:missnothing/data/gmail/incremental_sync.dart';
import 'package:missnothing/data/gmail/live_mailbox.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:missnothing/data/parser/html_normalize.dart';
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
    required this.listedIds,
    required this.records,
    this.hit,
  });

  final AllowlistedCircular? hit;
  final List<String> notes;
  final List<String> listedIds;
  final List<GmailMessageRecord> records;
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

/// Fetch allowlisted mail (including Spam/Trash) through the incremental
/// engine. A missing history cursor forces a full list.
Future<AllowlistedFetch> fetchAllowlistedCircular(GmailApi gmail) async {
  final result = await IncrementalSync(mailbox: LiveGmailMailbox(gmail)).run(
    allowlist: [AllowlistEntry.mailbox(AppConfig.allowlistedFrom)],
    query: 'from:${AppConfig.allowlistedFrom} newer_than:30d',
  );
  return result.toAllowlistedFetch();
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
