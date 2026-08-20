import 'package:drift/drift.dart';

import '../db/database.dart';
import '../gmail/sync_error.dart';

class SyncCursorRepository {
  const SyncCursorRepository(this.db);

  final AppDatabase db;

  Future<SyncCursor?> find(String accountId) {
    return (db.select(
      db.syncCursors,
    )..where((row) => row.accountId.equals(accountId))).getSingleOrNull();
  }

  Future<void> recordSuccess({
    required String accountId,
    required String? historyId,
    required bool full,
    required DateTime at,
  }) async {
    final existing = await find(accountId);
    await db
        .into(db.syncCursors)
        .insertOnConflictUpdate(
          SyncCursorsCompanion.insert(
            accountId: accountId,
            historyId: Value(historyId),
            lastSyncAt: Value(at.toUtc()),
            lastFullSyncAt: Value(full ? at.toUtc() : existing?.lastFullSyncAt),
            lastErrorCode: const Value(null),
            lastErrorMessage: const Value(null),
            watchExpiresAt: Value(existing?.watchExpiresAt),
          ),
        );
  }

  Future<void> recordFailure({
    required String accountId,
    required SyncErrorCode code,
    required String message,
    required DateTime at,
  }) async {
    final existing = await find(accountId);
    await db
        .into(db.syncCursors)
        .insertOnConflictUpdate(
          SyncCursorsCompanion.insert(
            accountId: accountId,
            historyId: Value(existing?.historyId),
            lastSyncAt: Value(at.toUtc()),
            lastFullSyncAt: Value(existing?.lastFullSyncAt),
            lastErrorCode: Value(code.name),
            lastErrorMessage: Value(message),
            watchExpiresAt: Value(existing?.watchExpiresAt),
          ),
        );
  }
}
