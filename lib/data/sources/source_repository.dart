import 'package:drift/drift.dart';

import '../db/database.dart';
import '../gmail/from_header.dart';

class SourceSnapshot {
  const SourceSnapshot({required this.source, required this.allowlist});

  final Source source;
  final List<AllowlistEntry> allowlist;
}

class SourceRepository {
  const SourceRepository(this.db);

  static const defaultSourceId = 'src_default';

  final AppDatabase db;

  Future<void> seedDefault({
    required String accountId,
    required String accountEmail,
    required String mailbox,
    String label = 'School',
  }) async {
    final now = DateTime.now().toUtc();
    await db
        .into(db.appAccounts)
        .insertOnConflictUpdate(
          AppAccountsCompanion.insert(
            id: accountId,
            email: accountEmail,
            createdAt: now,
            updatedAt: now,
          ),
        );
    const sourceId = defaultSourceId;
    await db
        .into(db.sources)
        .insertOnConflictUpdate(
          SourcesCompanion.insert(
            id: sourceId,
            accountId: accountId,
            label: label,
            createdAt: now,
            updatedAt: now,
          ),
        );
    final existing = await (db.select(
      db.sourceAllowlistEntries,
    )..where((row) => row.sourceId.equals(sourceId))).get();
    if (existing.isEmpty) {
      await db
          .into(db.sourceAllowlistEntries)
          .insert(
            SourceAllowlistEntriesCompanion.insert(
              id: 'allow_default',
              sourceId: sourceId,
              kind: 'mailbox',
              value: mailbox.trim().toLowerCase(),
              createdAt: now,
            ),
          );
    }
  }

  Future<List<SourceSnapshot>> forAccount(String accountId) async {
    final sources =
        await (db.select(db.sources)..where(
              (row) =>
                  row.accountId.equals(accountId) & row.enabled.equals(true),
            ))
            .get();
    final out = <SourceSnapshot>[];
    for (final source in sources) {
      final rows = await (db.select(
        db.sourceAllowlistEntries,
      )..where((row) => row.sourceId.equals(source.id))).get();
      out.add(
        SourceSnapshot(
          source: source,
          allowlist: [
            for (final row in rows)
              row.kind == 'domain'
                  ? AllowlistEntry.domain(row.value)
                  : AllowlistEntry.mailbox(row.value),
          ],
        ),
      );
    }
    return out;
  }

  Future<List<SourceAllowlistEntry>> allowlistRows() {
    return db.select(db.sourceAllowlistEntries).get();
  }

  Future<void> removeAllowlist(String id) {
    return (db.delete(
      db.sourceAllowlistEntries,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<void> addAllowlist({
    required String sourceId,
    required AllowlistEntry entry,
  }) async {
    await db
        .into(db.sourceAllowlistEntries)
        .insertOnConflictUpdate(
          SourceAllowlistEntriesCompanion.insert(
            id: '${sourceId}_${entry.kind.name}_${entry.value}',
            sourceId: sourceId,
            kind: entry.kind.name,
            value: entry.value,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }
}
