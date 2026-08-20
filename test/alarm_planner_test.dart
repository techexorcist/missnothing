import 'package:missnothing/data/reminders/alarm_planner.dart';
import 'package:test/test.dart';

void main() {
  const planner = AlarmPlanner(
    nightBefore: ClockTime(20, 0),
    morningOf: ClockTime(7, 0),
  );

  test('schedules night-before and morning-of within the horizon', () {
    final now = DateTime.now().toUtc();
    final starts = now.add(const Duration(days: 3));
    final plans = planner.forEvent(startsAt: starts, allDay: true, now: now);
    expect(plans.map((plan) => plan.kind).toSet(), {
      AlarmKind.nightBefore,
      AlarmKind.morningOf,
    });
    expect(plans.every((plan) => plan.fireAt.isAfter(now)), isTrue);
  });

  test('skips alarms that already passed', () {
    final now = DateTime.now().toUtc();
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
