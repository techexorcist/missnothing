import 'package:drift/native.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/data/gmail/gmail_readonly.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:missnothing/data/parser/proposal.dart' as school;
import 'package:missnothing/data/reminders/alarm_planner.dart';
import 'package:missnothing/data/reminders/alarm_repository.dart';
import 'package:missnothing/data/review/proposal_repository.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
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
    await ProposalRepository(db).persistUnreviewed(
      AllowlistedCircular(
        id: 'm1',
        from: 'school@example.com',
        subject: 'Hat day',
        messageDate: DateTime.utc(2026, 8, 21),
        body: 'Please bring a hat.',
        proposal: school.Proposal(
          type: school.ProposalType.datedAction,
          from: 'school@example.com',
          date: DateTime.utc(2026, 8, 22),
          items: const [
            school.ProposalItem(
              kind: school.ItemKind.bring,
              textRaw: 'Please bring a hat.',
            ),
          ],
        ),
      ),
    );
  });

  tearDown(() => db.close());

  test('replaceForEvent writes pending rows and snooze adds a child', () async {
    final event = await ProposalRepository(
      db,
    ).confirmAsEvent(proposalId: 'prop_m1');
    final repo = AlarmRepository(db);
    final plans = AlarmPlanner().forEvent(
      startsAt: DateTime.now().toUtc().add(const Duration(days: 2)),
      allDay: true,
      now: DateTime.now().toUtc(),
    );
    await repo.replaceForEvent(eventId: event.id, plans: plans);
    final pending = await repo.pending();
    expect(pending, isNotEmpty);
    expect(pending.first.notificationId, greaterThanOrEqualTo(100));

    final child = await repo.snooze(alarmId: pending.first.id);
    expect(child.kind, AlarmKind.snooze);
    expect(child.snoozeParentId, pending.first.id);
  });

  test('replaceBriefings restocks event-less clocks and cap keeps them', () async {
    final event = await ProposalRepository(
      db,
    ).confirmAsEvent(proposalId: 'prop_m1');
    final repo = AlarmRepository(db);
    final later = DateTime.now().toUtc().add(const Duration(days: 3));
    await repo.replaceForEvent(
      eventId: event.id,
      plans: [
        AlarmPlan(kind: AlarmKind.nightBefore, fireAt: later),
        AlarmPlan(
          kind: AlarmKind.morningOf,
          fireAt: later.add(const Duration(hours: 10)),
        ),
      ],
    );
    await repo.replaceBriefings(
      const AlarmPlanner().briefings(
        now: DateTime(2026, 8, 20, 5),
        days: 2,
      ),
    );
    final dropped = await repo.capPending(max: 4);
    expect(dropped.every((row) => !AlarmKind.isBriefing(row.kind)), isTrue);
    final left = await repo.pending();
    expect(left.where((row) => AlarmKind.isBriefing(row.kind)).length, 4);
    expect(left.every((row) => row.eventId == null), isTrue);
  });
}
