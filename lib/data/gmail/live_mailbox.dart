import 'package:googleapis/gmail/v1.dart';

import 'gmail_readonly.dart';
import 'mailbox.dart';
import 'sync_error.dart';

class LiveGmailMailbox implements GmailMailbox {
  LiveGmailMailbox(this.api);

  final GmailApi api;

  @override
  Future<HistoryDelta> listHistory(String startHistoryId) async {
    final added = <String>{};
    final deleted = <String>{};
    String? pageToken;
    String? latest = startHistoryId;
    try {
      do {
        final page = await api.users.history.list(
          'me',
          startHistoryId: startHistoryId,
          pageToken: pageToken,
          historyTypes: const ['messageAdded', 'messageDeleted'],
        );
        latest = page.historyId ?? latest;
        for (final entry in page.history ?? const <History>[]) {
          for (final addedMsg
              in entry.messagesAdded ?? const <HistoryMessageAdded>[]) {
            final id = addedMsg.message?.id;
            if (id != null) added.add(id);
          }
          for (final deletedMsg
              in entry.messagesDeleted ?? const <HistoryMessageDeleted>[]) {
            final id = deletedMsg.message?.id;
            if (id != null) deleted.add(id);
          }
        }
        pageToken = page.nextPageToken;
      } while (pageToken != null && pageToken.isNotEmpty);
    } catch (error) {
      if (_isHistoryStale(error)) {
        throw HistoryStaleException(startHistoryId);
      }
      rethrow;
    }
    return HistoryDelta(
      addedIds: added.toList(),
      deletedIds: deleted.toList(),
      historyId: latest ?? startHistoryId,
    );
  }

  @override
  Future<RecentMailbox> listRecent({required String query}) async {
    final refs = <ListedMessageRef>[];
    String? pageToken;
    do {
      final listed = await api.users.messages.list(
        'me',
        q: query,
        includeSpamTrash: true,
        maxResults: 500,
        pageToken: pageToken,
      );
      for (final message in listed.messages ?? const <Message>[]) {
        final id = message.id;
        if (id != null) {
          refs.add(ListedMessageRef(id: id, threadId: message.threadId));
        }
      }
      pageToken = listed.nextPageToken;
    } while (pageToken != null && pageToken.isNotEmpty);
    return RecentMailbox(ids: refs, historyId: await currentHistoryId());
  }

  @override
  Future<FetchedMessage> getFull(String id) async {
    final message = await api.users.messages.get('me', id, format: 'full');
    return FetchedMessage(
      id: id,
      from: _header(message, 'From') ?? '',
      subject: _header(message, 'Subject') ?? '(no subject)',
      body: extractMessageText(message),
      threadId: message.threadId,
      internalDateMs: int.tryParse(message.internalDate ?? ''),
      hasAttachments: _hasAttachments(message.payload),
      historyId: null,
    );
  }

  @override
  Future<String?> currentHistoryId() async {
    final profile = await api.users.getProfile('me');
    return profile.historyId;
  }
}

bool _isHistoryStale(Object error) {
  final text = error.toString();
  return text.contains('404') ||
      text.contains('notFound') ||
      text.contains('Requested entity was not found');
}

String? _header(Message message, String name) {
  final headers = message.payload?.headers;
  if (headers == null) return null;
  for (final header in headers) {
    if (header.name != null &&
        header.name!.toLowerCase() == name.toLowerCase()) {
      return header.value;
    }
  }
  return null;
}

bool _hasAttachments(MessagePart? part) {
  if (part == null) return false;
  final filename = part.filename ?? '';
  if (filename.isNotEmpty && (part.body?.attachmentId?.isNotEmpty ?? false)) {
    return true;
  }
  for (final child in part.parts ?? const <MessagePart>[]) {
    if (_hasAttachments(child)) return true;
  }
  return false;
}
