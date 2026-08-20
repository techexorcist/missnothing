class ClockTime {
  const ClockTime(this.hour, this.minute);

  final int hour;
  final int minute;
}

class AlarmPlan {
  const AlarmPlan({required this.kind, required this.fireAt});

  final String kind;
  final DateTime fireAt;
}

/// Night-before / morning-of offsets, plus a rolling horizon so we never
/// enqueue unbounded exact alarms.
class AlarmPlanner {
  const AlarmPlanner({
    this.nightBefore = const ClockTime(20, 0),
    this.morningOf = const ClockTime(7, 0),
    this.horizon = const Duration(days: 14),
  });

  final ClockTime nightBefore;
  final ClockTime morningOf;
  final Duration horizon;

  List<AlarmPlan> forEvent({
    required DateTime? startsAt,
    required bool allDay,
    DateTime? now,
  }) {
    if (startsAt == null) return const [];
    final current = (now ?? DateTime.now()).toUtc();
    final local = startsAt.toLocal();
    final day = DateTime(local.year, local.month, local.day);
    final night = DateTime(
      day.year,
      day.month,
      day.day,
      nightBefore.hour,
      nightBefore.minute,
    ).subtract(const Duration(days: 1));
    final morning = DateTime(
      day.year,
      day.month,
      day.day,
      morningOf.hour,
      morningOf.minute,
    );
    final cutoff = current.add(horizon);
    return [
      for (final plan in [
        AlarmPlan(kind: AlarmKind.nightBefore, fireAt: night.toUtc()),
        AlarmPlan(kind: AlarmKind.morningOf, fireAt: morning.toUtc()),
      ])
        if (plan.fireAt.isAfter(current) && !plan.fireAt.isAfter(cutoff)) plan,
    ];
  }

  List<AlarmPlan> briefings({DateTime? now, int days = 7}) {
    final current = (now ?? DateTime.now()).toLocal();
    final out = <AlarmPlan>[];
    for (var i = 0; i < days; i++) {
      final day = DateTime(
        current.year,
        current.month,
        current.day,
      ).add(Duration(days: i));
      final evening = DateTime(day.year, day.month, day.day, 19);
      final morning = DateTime(day.year, day.month, day.day, 7);
      for (final plan in [
        AlarmPlan(kind: AlarmKind.briefingEvening, fireAt: evening.toUtc()),
        AlarmPlan(kind: AlarmKind.briefingMorning, fireAt: morning.toUtc()),
      ]) {
        if (plan.fireAt.isAfter(current.toUtc())) out.add(plan);
      }
    }
    return out;
  }
}

abstract final class AlarmKind {
  static const nightBefore = 'night_before';
  static const morningOf = 'morning_of';
  static const briefingEvening = 'briefing_evening';
  static const briefingMorning = 'briefing_morning';
  static const snooze = 'snooze';
  static const smokeNear = 'smoke_near';
  static const smokeFar = 'smoke_far';
}

abstract final class AlarmStatus {
  static const scheduled = 'scheduled';
  static const fired = 'fired';
  static const cancelled = 'cancelled';
  static const snoozed = 'snoozed';
  static const done = 'done';
}
