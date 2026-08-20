class ListedMessageRef {
  const ListedMessageRef({required this.id, this.threadId});

  final String id;
  final String? threadId;
}

class FetchedMessage {
  const FetchedMessage({
    required this.id,
    required this.from,
    required this.subject,
    required this.body,
    this.threadId,
    this.internalDateMs,
    this.hasAttachments = false,
    this.historyId,
  });

  final String id;
  final String from;
  final String subject;
  final String body;
  final String? threadId;
  final int? internalDateMs;
  final bool hasAttachments;
  final String? historyId;
}

class HistoryDelta {
  const HistoryDelta({
    required this.addedIds,
    required this.historyId,
    this.deletedIds = const [],
  });

  final List<String> addedIds;
  final List<String> deletedIds;
  final String historyId;
}

class RecentMailbox {
  const RecentMailbox({required this.ids, this.historyId});

  final List<ListedMessageRef> ids;
  final String? historyId;
}

/// Narrow Gmail surface so incremental sync can be tested without HTTP.
abstract class GmailMailbox {
  Future<HistoryDelta> listHistory(String startHistoryId);

  Future<RecentMailbox> listRecent({required String query});

  Future<FetchedMessage> getFull(String id);

  Future<String?> currentHistoryId();
}
