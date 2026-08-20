import 'package:drift/drift.dart';

import '../gmail/message_record.dart';
import 'database.dart';

class IdReconciliation {
  const IdReconciliation({
    required this.listed,
    required this.storedForListed,
    required this.totalPermanent,
    required this.byStatus,
  });

  final int listed;
  final int storedForListed;
  final int totalPermanent;
  final Map<String, int> byStatus;

  bool get balanced => listed == storedForListed;
}

/// Permanent Gmail identity ledger. Message bodies can be pruned later; rows in
/// this table are never deleted.
class GmailMessageIndex {
  const GmailMessageIndex(this.db);

  final AppDatabase db;

  Future<void> initialize() async {
    await db.customSelect('SELECT 1;').getSingle();
  }

  Future<IdReconciliation> recordAndReconcile({
    required List<String> listedIds,
    required Iterable<GmailMessageRecord> records,
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await db.transaction(() async {
      for (final record in records) {
        await db.customStatement(
          'INSERT INTO gmail_messages('
          'message_id, thread_id, internal_date_ms, from_raw, subject_raw, '
          'parse_status, first_seen_at, last_seen_at'
          ') VALUES(?, ?, ?, ?, ?, ?, ?, ?) '
          'ON CONFLICT(message_id) DO UPDATE SET '
          'thread_id = COALESCE(excluded.thread_id, thread_id), '
          'internal_date_ms = COALESCE('
          'excluded.internal_date_ms, internal_date_ms), '
          'from_raw = COALESCE(excluded.from_raw, from_raw), '
          'subject_raw = COALESCE(excluded.subject_raw, subject_raw), '
          'parse_status = excluded.parse_status, '
          'last_seen_at = excluded.last_seen_at;',
          [
            record.id,
            record.threadId,
            record.internalDateMs,
            record.fromRaw,
            record.subjectRaw,
            record.parseStatus,
            now,
            now,
          ],
        );
      }
    });

    final storedForListed = listedIds.isEmpty
        ? 0
        : (await db
                  .customSelect(
                    'SELECT COUNT(*) AS n FROM gmail_messages '
                    'WHERE message_id IN '
                    '(${List.filled(listedIds.length, '?').join(',')});',
                    variables: [
                      for (final id in listedIds) Variable<String>(id),
                    ],
                  )
                  .getSingle())
              .read<int>('n');
    final total =
        (await db
                .customSelect('SELECT COUNT(*) AS n FROM gmail_messages;')
                .getSingle())
            .read<int>('n');
    final byStatus = <String, int>{
      for (final row
          in await db
              .customSelect(
                'SELECT parse_status, COUNT(*) AS n FROM gmail_messages '
                'GROUP BY parse_status ORDER BY parse_status;',
              )
              .get())
        row.read<String>('parse_status'): row.read<int>('n'),
    };

    return IdReconciliation(
      listed: listedIds.length,
      storedForListed: storedForListed,
      totalPermanent: total,
      byStatus: byStatus,
    );
  }

  Future<({int couldntRead, int incomplete})> missCounts() async {
    final byStatus = <String, int>{
      for (final row
          in await db
              .customSelect(
                'SELECT parse_status, COUNT(*) AS n FROM gmail_messages '
                'GROUP BY parse_status;',
              )
              .get())
        row.read<String>('parse_status'): row.read<int>('n'),
    };
    final couldntRead =
        (byStatus[GmailParseStatus.nothingFound] ?? 0) +
        (byStatus[GmailParseStatus.emptyBody] ?? 0) +
        (byStatus[GmailParseStatus.fetchError] ?? 0);
    return (
      couldntRead: couldntRead,
      incomplete: byStatus[GmailParseStatus.listed] ?? 0,
    );
  }

  Future<List<GmailMiss>> misses({int limit = 40}) async {
    final rows = await db
        .customSelect(
          'SELECT message_id, parse_status, subject_raw FROM gmail_messages '
          'WHERE parse_status IN (?, ?, ?) '
          'ORDER BY last_seen_at DESC LIMIT ?;',
          variables: [
            Variable<String>(GmailParseStatus.nothingFound),
            Variable<String>(GmailParseStatus.emptyBody),
            Variable<String>(GmailParseStatus.fetchError),
            Variable<int>(limit),
          ],
        )
        .get();
    return [
      for (final row in rows)
        GmailMiss(
          id: row.read<String>('message_id'),
          status: row.read<String>('parse_status'),
          subject: row.read<String?>('subject_raw'),
        ),
    ];
  }
}

class GmailMiss {
  const GmailMiss({required this.id, required this.status, this.subject});

  final String id;
  final String status;
  final String? subject;
}
