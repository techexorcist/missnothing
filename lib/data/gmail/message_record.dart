class GmailMessageRecord {
  const GmailMessageRecord({
    required this.id,
    required this.parseStatus,
    this.threadId,
    this.internalDateMs,
    this.fromRaw,
    this.subjectRaw,
  });

  final String id;
  final String parseStatus;
  final String? threadId;
  final int? internalDateMs;
  final String? fromRaw;
  final String? subjectRaw;

  GmailMessageRecord copyWith({
    String? parseStatus,
    String? threadId,
    int? internalDateMs,
    String? fromRaw,
    String? subjectRaw,
  }) {
    return GmailMessageRecord(
      id: id,
      parseStatus: parseStatus ?? this.parseStatus,
      threadId: threadId ?? this.threadId,
      internalDateMs: internalDateMs ?? this.internalDateMs,
      fromRaw: fromRaw ?? this.fromRaw,
      subjectRaw: subjectRaw ?? this.subjectRaw,
    );
  }
}

abstract final class GmailParseStatus {
  static const listed = 'listed';
  static const fetchError = 'fetch_error';
  static const fromMismatch = 'from_mismatch';
  static const emptyBody = 'empty_body';
  static const nothingFound = 'nothing_found';

  static String parsed(String proposalType) => 'parsed_$proposalType';
}
