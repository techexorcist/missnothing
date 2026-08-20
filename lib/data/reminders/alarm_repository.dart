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

  Future<void> replaceForEvent({
    required String eventId,
    required List<AlarmPlan> plans,
  }) async {
    final existing = await forEvent(eventId);
    if (existing.isNotEmpty) {
      await (db.update(
        db.alarmSchedules,
      )..where((row) => row.eventId.equals(eventId))).write(
        AlarmSchedulesCompanion(
          status: const Value(AlarmStatus.cancelled),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
    }
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
