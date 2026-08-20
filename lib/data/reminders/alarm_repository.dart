import 'package:drift/drift.dart';

import '../db/database.dart';
import 'alarm_planner.dart';

class AlarmRepository {
  const AlarmRepository(this.db);

  final AppDatabase db;

  Future<List<AlarmSchedule>> pending() {
    return (db.select(db.alarmSchedules)
          ..where((row) => row.status.equals(AlarmStatus.scheduled))
          ..orderBy([(row) => OrderingTerm.asc(row.fireAt)]))
        .get();
  }

  Future<List<AlarmSchedule>> forEvent(String eventId) {
    return (db.select(
      db.alarmSchedules,
    )..where((row) => row.eventId.equals(eventId))).get();
  }

  /// Drops prior rows for [eventId] so a second write with the same
  /// fire times does not collide on id.
  Future<List<AlarmSchedule>> replaceForEvent({
    required String eventId,
    required List<AlarmPlan> plans,
  }) async {
    final existing = await forEvent(eventId);
    await (db.delete(
      db.alarmSchedules,
    )..where((row) => row.eventId.equals(eventId))).go();
    var nextId = await _nextNotificationId();
    final now = DateTime.now().toUtc();
    for (final plan in plans) {
      await db
          .into(db.alarmSchedules)
          .insert(
            AlarmSchedulesCompanion.insert(
              id: '${eventId}_${plan.kind}_${plan.fireAt.millisecondsSinceEpoch}',
              eventId: Value(eventId),
              kind: plan.kind,
              fireAt: plan.fireAt,
              notificationId: nextId++,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
    return existing;
  }

  Future<AlarmSchedule> snooze({
    required String alarmId,
    Duration delay = const Duration(minutes: 15),
  }) async {
    final parent = await (db.select(
      db.alarmSchedules,
    )..where((row) => row.id.equals(alarmId))).getSingle();
    final now = DateTime.now().toUtc();
    await (db.update(
      db.alarmSchedules,
    )..where((row) => row.id.equals(alarmId))).write(
      AlarmSchedulesCompanion(
        status: const Value(AlarmStatus.snoozed),
        updatedAt: Value(now),
      ),
    );
    final fireAt = now.add(delay);
    final child = AlarmSchedulesCompanion.insert(
      id: '${parent.id}_snooze_${fireAt.millisecondsSinceEpoch}',
      eventId: Value(parent.eventId),
      kind: AlarmKind.snooze,
      fireAt: fireAt,
      snoozeParentId: Value(parent.id),
      notificationId: await _nextNotificationId(),
      createdAt: now,
      updatedAt: now,
    );
    await db.into(db.alarmSchedules).insert(child);
    return (await (db.select(
      db.alarmSchedules,
    )..where((row) => row.id.equals(child.id.value))).getSingle());
  }

  Future<void> setArmed(String alarmId, {required bool armed}) async {
    await (db.update(
      db.alarmSchedules,
    )..where((row) => row.id.equals(alarmId))).write(
      AlarmSchedulesCompanion(
        status: Value(armed ? AlarmStatus.scheduled : AlarmStatus.cancelled),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<List<AlarmSchedule>> replaceBriefings(List<AlarmPlan> plans) async {
    final existing =
        await (db.select(db.alarmSchedules)..where(
              (row) => row.kind.isIn([
                AlarmKind.briefingEvening,
                AlarmKind.briefingMorning,
              ]),
            ))
            .get();
    await (db.delete(db.alarmSchedules)..where(
          (row) => row.kind.isIn([
            AlarmKind.briefingEvening,
            AlarmKind.briefingMorning,
          ]),
        ))
        .go();
    var nextId = await _nextNotificationId();
    final now = DateTime.now().toUtc();
    for (final plan in plans) {
      await db
          .into(db.alarmSchedules)
          .insert(
            AlarmSchedulesCompanion.insert(
              id: 'briefing_${plan.kind}_${plan.fireAt.millisecondsSinceEpoch}',
              kind: plan.kind,
              fireAt: plan.fireAt,
              notificationId: nextId++,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
    return existing;
  }

  /// Event alarms yield first so the two briefings never drain.
  Future<List<AlarmSchedule>> capPending({int max = 64}) async {
    final rows = await pending();
    if (rows.length <= max) return const [];
    final overflow = rows.length - max;
    final drop = [
      for (final row in rows.reversed)
        if (!AlarmKind.isBriefing(row.kind)) row,
    ].take(overflow).toList();
    for (final row in drop) {
      await setArmed(row.id, armed: false);
    }
    return drop;
  }

  Future<void> markDoneForEvent(String eventId) async {
    await (db.update(
      db.alarmSchedules,
    )..where((row) => row.eventId.equals(eventId))).write(
      AlarmSchedulesCompanion(
        status: const Value(AlarmStatus.done),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<int> _nextNotificationId() async {
    final row = await db
        .customSelect('SELECT MAX(notification_id) AS m FROM alarm_schedules;')
        .getSingle();
    final current = row.read<int?>('m') ?? 99;
    return current < 99 ? 100 : current + 1;
  }
}
