import 'package:drift/native.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/data/events/event_repository.dart';
import 'package:missnothing/data/gmail/gmail_readonly.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:missnothing/data/parser/proposal.dart' as school;
import 'package:missnothing/data/review/proposal_repository.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late ProposalRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
    repo = ProposalRepository(db);
    await GmailMessageIndex(db).initialize();
    await GmailMessageIndex(db).recordAndReconcile(
      listedIds: const ['m1'],
      records: const [
        GmailMessageRecord(
          id: 'm1',
          parseStatus: GmailParseStatus.nothingFound,
        ),
      ],
    );
  });

  tearDown(() => db.close());

  AllowlistedCircular circular() {
    return AllowlistedCircular(
      id: 'm1',
      from: 'school@example.com',
      subject: 'Hat day',
      messageDate: DateTime.utc(2026, 8, 21),
      body: 'Please bring a hat.',
      proposal: school.Proposal(
        type: school.ProposalType.datedAction,
        from: 'school@example.com',
        date: DateTime.utc(2026, 8, 21),
        items: const [
          school.ProposalItem(
            kind: school.ItemKind.bring,
            textRaw: 'Please bring a hat.',
          ),
        ],
      ),
    );
  }

  test('confirming a proposal copies an independent event', () async {
    await repo.persistUnreviewed(circular());
    final event = await repo.confirmAsEvent(proposalId: 'prop_m1');
    expect(event.title, 'Hat day');
    expect(event.sourceMessageId, 'm1');

    await repo.persistUnreviewed(
      AllowlistedCircular(
        id: 'm1',
        from: 'school@example.com',
        subject: 'Changed by parser',
        messageDate: DateTime.utc(2026, 8, 22),
        body: 'ignored',
        proposal: const school.Proposal(
          type: school.ProposalType.undatedAction,
          from: 'school@example.com',
          items: [],
        ),
      ),
    );
    final stored = await repo.byMessage('m1');
    expect(stored?.row.status, ProposalStatus.confirmed);
    expect(stored?.row.subject, 'Hat day');
    expect((await db.select(db.events).get()).single.title, 'Hat day');
  });

  test('laid-out ticks persist on event items', () async {
    await repo.persistUnreviewed(circular());
    final event = await repo.confirmAsEvent(proposalId: 'prop_m1');
    final events = EventRepository(db);
    final day = event.startsAt ?? DateTime.utc(2026, 8, 21);
    final slots = await events.slotsOn(day.toLocal());
    expect(slots, isNotEmpty);
    expect(slots.first.laidOut, isFalse);
    await events.setLaidOut(slots.first.itemId, true);
    expect((await events.slotsOn(day.toLocal())).first.laidOut, isTrue);
    await events.setNagMuted(slots.first.itemId, muted: true);
    expect((await events.slotsOn(day.toLocal())).first.nagMuted, isTrue);
  });

  test('skipped proposals are sticky across reparses', () async {
    expect(await repo.persistUnreviewed(circular()), isTrue);
    expect(await repo.persistUnreviewed(circular()), isFalse);
    await repo.decide(proposalId: 'prop_m1', status: ProposalStatus.skipped);
    expect(await repo.persistUnreviewed(circular()), isFalse);
    expect((await repo.byMessage('m1'))?.row.status, ProposalStatus.skipped);
    expect(await repo.unreviewed(), isEmpty);
  });

  test('reschedule flags moved from on a new day', () async {
    await repo.persistUnreviewed(circular());
    final event = await repo.confirmAsEvent(
      proposalId: 'prop_m1',
      startsAt: DateTime(2026, 8, 21),
    );
    final moved = await EventRepository(db).reschedule(
      eventId: event.id,
      startsAt: DateTime(2026, 8, 24),
    );
    expect(moved.startsAt!.day, 24);
    expect(moved.notes, 'moved from Fri 21');
    final ledger = await EventRepository(db).ledger();
    expect(ledger.single.movedFrom, 'moved from Fri 21');
    expect(ledger.single.headline, 'Please bring a hat.');
  });
}
