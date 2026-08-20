import 'package:drift/drift.dart';

import 'database.dart';

class MessageBodyRepository {
  const MessageBodyRepository(this.db);

  final AppDatabase db;

  Future<void> put({
    required String messageId,
    required String normalizedBody,
    required DateTime fetchedAt,
    required Duration retention,
    String? parserVersion,
  }) async {
    await db
        .into(db.gmailMessageBodies)
        .insertOnConflictUpdate(
          GmailMessageBodiesCompanion.insert(
            messageId: messageId,
            normalizedBody: normalizedBody,
            fetchedAt: fetchedAt.toUtc(),
            expiresAt: fetchedAt.toUtc().add(retention),
            parserVersion: Value(parserVersion),
          ),
        );
  }

  Future<GmailMessageBody?> find(String messageId) {
    return (db.select(
      db.gmailMessageBodies,
    )..where((row) => row.messageId.equals(messageId))).getSingleOrNull();
  }

  /// Bodies expire independently from permanent Gmail IDs. A body backing an
  /// active event is retained so its source evidence remains reviewable.
  Future<int> pruneExpired(DateTime now) {
    return db.customUpdate(
      'DELETE FROM gmail_message_bodies '
      'WHERE expires_at < ? '
      'AND NOT EXISTS ('
      'SELECT 1 FROM events '
      'WHERE events.source_message_id = gmail_message_bodies.message_id '
      "AND events.status != 'deleted'"
      ');',
      variables: [Variable<DateTime>(now.toUtc())],
      updates: {db.gmailMessageBodies},
      updateKind: UpdateKind.delete,
    );
  }
}
