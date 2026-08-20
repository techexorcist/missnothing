import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/data/db/message_body_repository.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  test('expired bodies are pruned but permanent IDs remain', () async {
    final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
    addTearDown(db.close);
    final index = GmailMessageIndex(db);
    await index.initialize();
    await index.recordAndReconcile(
      listedIds: const ['m1', 'm2'],
      records: const [
        GmailMessageRecord(
          id: 'm1',
          parseStatus: GmailParseStatus.nothingFound,
        ),
        GmailMessageRecord(
          id: 'm2',
          parseStatus: GmailParseStatus.nothingFound,
        ),
      ],
    );

    final bodies = MessageBodyRepository(db);
    final fetchedAt = DateTime.utc(2026, 7, 1);
    await bodies.put(
      messageId: 'm1',
      normalizedBody: 'temporary',
      fetchedAt: fetchedAt,
      retention: const Duration(days: 14),
    );
    await bodies.put(
      messageId: 'm2',
      normalizedBody: 'event evidence',
      fetchedAt: fetchedAt,
      retention: const Duration(days: 14),
    );
    await db
        .into(db.events)
        .insert(
          EventsCompanion.insert(
            id: 'event-1',
            sourceMessageId: const Value('m2'),
            title: 'School event',
            createdAt: fetchedAt,
            updatedAt: fetchedAt,
          ),
        );

    expect(await bodies.pruneExpired(DateTime.utc(2026, 8, 1)), 1);
    expect(await bodies.find('m1'), isNull);
    expect((await bodies.find('m2'))?.normalizedBody, 'event evidence');
    expect(await db.select(db.gmailMessages).get(), hasLength(2));
  });
}
