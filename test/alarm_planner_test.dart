import 'package:missnothing/data/reminders/alarm_planner.dart';
import 'package:test/test.dart';

void main() {
  const planner = AlarmPlanner();

  test('need-by is 06:30 on the day and put-out is 20:00 the night before', () {
    final now = DateTime.utc(2026, 8, 20, 10);
    final starts = DateTime(2026, 8, 23);
    final plans = planner.forEvent(startsAt: starts, allDay: true, now: now);
    final byKind = {for (final plan in plans) plan.kind: plan.fireAt.toLocal()};
    expect(byKind.keys, {
      AlarmKind.nightBefore,
      AlarmKind.morningOf,
    });
    expect(byKind[AlarmKind.nightBefore]!.hour, 20);
    expect(byKind[AlarmKind.nightBefore]!.minute, 0);
    expect(byKind[AlarmKind.nightBefore]!.day, 22);
    expect(byKind[AlarmKind.morningOf]!.hour, 6);
    expect(byKind[AlarmKind.morningOf]!.minute, 30);
    expect(byKind[AlarmKind.morningOf]!.day, 23);
  });

  test('briefings are 06:15 today\'s check and 20:00 put-out', () {
    final now = DateTime(2026, 8, 20, 5);
    final plans = planner.briefings(now: now, days: 1);
    final byKind = {for (final plan in plans) plan.kind: plan.fireAt.toLocal()};
    expect(byKind[AlarmKind.briefingMorning]!.hour, 6);
    expect(byKind[AlarmKind.briefingMorning]!.minute, 15);
    expect(byKind[AlarmKind.briefingEvening]!.hour, 20);
    expect(byKind[AlarmKind.briefingEvening]!.minute, 0);
  });

  test('skips alarms that already passed', () {
    final now = DateTime.utc(2026, 8, 20, 10);
    final plans = planner.forEvent(
      startsAt: now.subtract(const Duration(days: 2)),
      allDay: true,
      now: now,
    );
    expect(plans, isEmpty);
  });

  test('undated events produce no alarms', () {
    expect(planner.forEvent(startsAt: null, allDay: true), isEmpty);
  });
}
