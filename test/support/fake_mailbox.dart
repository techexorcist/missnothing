import 'package:missnothing/data/gmail/mailbox.dart';

class FakeMailbox implements GmailMailbox {
  FakeMailbox({
    required this.recent,
    required this.messages,
    this.historyId = 'H2',
    this.delta,
    this.historyError,
    this.listFailures = 0,
  });

  final RecentMailbox recent;
  final Map<String, FetchedMessage> messages;
  String? historyId;
  HistoryDelta? delta;
  Object? historyError;
  int listFailures;
  int listRecentCalls = 0;
  int listHistoryCalls = 0;
  int getFullCalls = 0;
  int getMetadataCalls = 0;

  @override
  Future<String?> currentHistoryId() async => historyId;

  @override
  Future<FetchedMessage> getMetadata(String id) async {
    getMetadataCalls += 1;
    final message = messages[id] ?? (throw StateError('unknown message $id'));
    return FetchedMessage(
      id: message.id,
      from: message.from,
      subject: message.subject,
      body: '',
      threadId: message.threadId,
      internalDateMs: message.internalDateMs,
    );
  }

  @override
  Future<FetchedMessage> getFull(String id) async {
    getFullCalls += 1;
    return messages[id] ?? (throw StateError('unknown message $id'));
  }

  @override
  Future<HistoryDelta> listHistory(String startHistoryId) async {
    listHistoryCalls += 1;
    final error = historyError;
    if (error != null) throw error;
    return delta ??
        HistoryDelta(
          addedIds: const [],
          historyId: historyId ?? startHistoryId,
        );
  }

  @override
  Future<RecentMailbox> listRecent({required String query}) async {
    listRecentCalls += 1;
    if (listFailures > 0) {
      listFailures -= 1;
      throw Exception('429 rate limit exceeded');
    }
    return recent;
  }
}
