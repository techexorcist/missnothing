import 'package:drift/native.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  test('message IDs remain permanent while parse status can improve', () async {
    final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
    addTearDown(db.close);
    final index = GmailMessageIndex(db);
    await index.initialize();

    final first = await index.recordAndReconcile(
      listedIds: const ['m1', 'm2'],
      records: const [
        GmailMessageRecord(
          id: 'm1',
          parseStatus: GmailParseStatus.nothingFound,
        ),
        GmailMessageRecord(id: 'm2', parseStatus: GmailParseStatus.emptyBody),
      ],
    );
    expect(first.balanced, isTrue);
    expect(first.totalPermanent, 2);
    expect(first.byStatus[GmailParseStatus.nothingFound], 1);

    final second = await index.recordAndReconcile(
      listedIds: const ['m1'],
      records: [
        GmailMessageRecord(
          id: 'm1',
          parseStatus: GmailParseStatus.parsed('dated_action'),
        ),
      ],
    );
    expect(second.balanced, isTrue);
    expect(second.totalPermanent, 2, reason: 'm2 must never be pruned');
    expect(second.byStatus[GmailParseStatus.parsed('dated_action')], 1);
    expect(second.byStatus[GmailParseStatus.emptyBody], 1);
    expect(second.byStatus.containsKey(GmailParseStatus.nothingFound), isFalse);
  });

  test('reconciliation detects a listed ID missing from storage', () async {
    final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
    addTearDown(db.close);
    final index = GmailMessageIndex(db);
    await index.initialize();

    final result = await index.recordAndReconcile(
      listedIds: const ['m1', 'm2'],
      records: const [
        GmailMessageRecord(id: 'm1', parseStatus: GmailParseStatus.listed),
      ],
    );

    expect(result.balanced, isFalse);
    expect(result.listed, 2);
    expect(result.storedForListed, 1);
  });

  test('version one migration preserves the legacy message ledger', () async {
    final raw = sqlite3.openInMemory()
      ..execute(
        'CREATE TABLE meta (k TEXT PRIMARY KEY NOT NULL, v TEXT NOT NULL);',
      )
      ..execute(
        'CREATE TABLE gmail_messages ('
        'message_id TEXT PRIMARY KEY NOT NULL,'
        'thread_id TEXT,'
        'internal_date_ms INTEGER,'
        'from_raw TEXT,'
        'subject_raw TEXT,'
        'parse_status TEXT NOT NULL,'
        'first_seen_at TEXT NOT NULL,'
        'last_seen_at TEXT NOT NULL'
        ');',
      )
      ..execute(
        "INSERT INTO gmail_messages VALUES("
        "'legacy-id', NULL, NULL, NULL, NULL, 'nothing_found', "
        "'2026-08-20', '2026-08-20');",
      );
    final db = AppDatabase(NativeDatabase.opened(raw));
    addTearDown(db.close);

    await GmailMessageIndex(db).initialize();

    final oldRows = await db.select(db.gmailMessages).get();
    expect(oldRows.single.messageId, 'legacy-id');
    expect(await db.select(db.proposals).get(), isEmpty);
    expect(raw.select('PRAGMA user_version;').single.values.single, 1);
  });

  test(
    'miss counts separate unread failures from incomplete downloads',
    () async {
      final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
      addTearDown(db.close);
      final index = GmailMessageIndex(db);
      await index.initialize();

      await index.recordAndReconcile(
        listedIds: const ['m1', 'm2', 'm3', 'm4', 'm5'],
        records: [
          GmailMessageRecord(
            id: 'm1',
            parseStatus: GmailParseStatus.nothingFound,
            subjectRaw: 'Sports day circular',
          ),
          GmailMessageRecord(id: 'm2', parseStatus: GmailParseStatus.emptyBody),
          GmailMessageRecord(
            id: 'm3',
            parseStatus: GmailParseStatus.fetchError,
          ),
          GmailMessageRecord(id: 'm4', parseStatus: GmailParseStatus.listed),
          GmailMessageRecord(
            id: 'm5',
            parseStatus: GmailParseStatus.parsed('dated_action'),
          ),
        ],
      );

      final counts = await index.missCounts();
      expect(counts.couldntRead, 3);
      expect(counts.incomplete, 1);

      final misses = await index.misses();
      expect(misses.map((miss) => miss.id).toSet(), {'m1', 'm2', 'm3'});
      expect(
        misses.singleWhere((miss) => miss.id == 'm1').subject,
        'Sports day circular',
      );
      final waiting = await index.incompletes();
      expect(waiting.single.id, 'm4');
    },
  );
}
