class ClockTime {
  const ClockTime(this.hour, this.minute);

  final int hour;
  final int minute;
}

/// Locked clocks from DESIGN.md. Evening put-out, morning check, need-by.
abstract final class SchoolClocks {
  static const putOut = ClockTime(20, 0);
  static const todayCheck = ClockTime(6, 15);
  static const needBy = ClockTime(6, 30);
  static const assembly = ClockTime(8, 0);
  static const beforeSchool = ClockTime(7, 30);
  static const lunch = ClockTime(12, 30);
  static const dispersal = ClockTime(15, 30);
}

/// Maps parser when-hints to the clocks parents already keep in their heads.
abstract final class SchoolTimings {
  static ClockTime? clockFor(String? hint) {
    return switch (hint) {
      'assembly' => SchoolClocks.assembly,
      'beforeSchool' || 'before_school' => SchoolClocks.beforeSchool,
      'lunch' => SchoolClocks.lunch,
      'dispersal' || 'pickup' || 'homeTime' || 'home_time' =>
        SchoolClocks.dispersal,
      _ => null,
    };
  }

  static DateTime? stamp(DateTime? date, String? hint) {
    if (date == null) return null;
    final clock = clockFor(hint);
    if (clock == null) return date;
    final local = date.toLocal();
    return DateTime(
      local.year,
      local.month,
      local.day,
      clock.hour,
      clock.minute,
    );
  }
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
    this.nightBefore = SchoolClocks.putOut,
    this.morningOf = SchoolClocks.needBy,
    this.briefingEvening = SchoolClocks.putOut,
    this.briefingMorning = SchoolClocks.todayCheck,
    this.horizon = const Duration(days: 14),
    this.pendingCap = 64,
  });

  final ClockTime nightBefore;
  final ClockTime morningOf;
  final ClockTime briefingEvening;
  final ClockTime briefingMorning;
  final Duration horizon;
  final int pendingCap;

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
    final planned = [
      for (final plan in [
        AlarmPlan(kind: AlarmKind.nightBefore, fireAt: night.toUtc()),
        AlarmPlan(kind: AlarmKind.morningOf, fireAt: morning.toUtc()),
      ])
        if (plan.fireAt.isAfter(current) && !plan.fireAt.isAfter(cutoff)) plan,
    ];
    if (planned.isNotEmpty) return planned;
    if (!_stillDue(day, current.toLocal())) return const [];
    final localNow = current.toLocal();
    if (_isNight(localNow)) {
      final deferred = _nextNeedBy(localNow);
      if (deferred.isAfter(localNow) && !deferred.toUtc().isAfter(cutoff)) {
        return [AlarmPlan(kind: AlarmKind.morningOf, fireAt: deferred.toUtc())];
      }
      return const [];
    }
    return [
      AlarmPlan(
        kind: AlarmKind.dueNow,
        fireAt: current.add(const Duration(seconds: 5)),
      ),
    ];
  }

  bool _stillDue(DateTime eventDay, DateTime localNow) {
    final today = DateTime(localNow.year, localNow.month, localNow.day);
    return !eventDay.isBefore(today);
  }

  bool _isNight(DateTime local) {
    final minutes = local.hour * 60 + local.minute;
    return minutes >= 20 * 60 || minutes < 6 * 60 + 15;
  }

  DateTime _nextNeedBy(DateTime local) {
    final today = DateTime(
      local.year,
      local.month,
      local.day,
      morningOf.hour,
      morningOf.minute,
    );
    if (local.isBefore(today)) return today;
    return today.add(const Duration(days: 1));
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
      final evening = DateTime(
        day.year,
        day.month,
        day.day,
        briefingEvening.hour,
        briefingEvening.minute,
      );
      final morning = DateTime(
        day.year,
        day.month,
        day.day,
        briefingMorning.hour,
        briefingMorning.minute,
      );
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
  static const dueNow = 'due_now';
  static const inbox = 'inbox';
  static const snooze = 'snooze';
  static const smokeNear = 'smoke_near';
  static const smokeFar = 'smoke_far';

  static bool isBriefing(String kind) =>
      kind == briefingEvening || kind == briefingMorning;
}

abstract final class AlarmStatus {
  static const scheduled = 'scheduled';
  static const fired = 'fired';
  static const cancelled = 'cancelled';
  static const snoozed = 'snoozed';
  static const done = 'done';
}
