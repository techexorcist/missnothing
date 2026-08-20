import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../db/database.dart';
import '../db/vault.dart';
import '../events/event_repository.dart';
import '../settings/settings_repository.dart';
import 'alarm_planner.dart';
import 'alarm_repository.dart';

const alarmChannelId = 'missnothing_alarms';
const alarmChannelName = 'School reminders';
const needByChannelId = 'missnothing_need_by';
const needByChannelName = 'Need-by';

final notificationPlugin = FlutterLocalNotificationsPlugin();

bool _ready = false;

Future<void> initNotifications({
  void Function(NotificationResponse response)? onResponse,
}) async {
  if (_ready) return;
  tzdata.initializeTimeZones();
  try {
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  } catch (_) {
    tz.setLocalLocation(tz.UTC);
  }

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  await notificationPlugin.initialize(
    const InitializationSettings(android: android),
    onDidReceiveNotificationResponse: onResponse,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  final androidPlugin = notificationPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  await androidPlugin?.requestNotificationsPermission();
  await androidPlugin?.requestExactAlarmsPermission();
  _ready = true;
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {}

class NotificationPayload {
  const NotificationPayload({this.eventId, this.alarmId, this.kind});

  final String? eventId;
  final String? alarmId;
  final String? kind;

  static NotificationPayload? parse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return NotificationPayload(
        eventId: json['eventId'] as String?,
        alarmId: json['alarmId'] as String?,
        kind: json['kind'] as String?,
      );
    } catch (_) {
      return NotificationPayload(eventId: raw);
    }
  }

  String encode() =>
      jsonEncode({'eventId': eventId, 'alarmId': alarmId, 'kind': kind});
}

class EventAlarms {
  static Future<void> reconcile(MissNothingVault vault) async {
    try {
      await initNotifications();
      await vault.use((db) async {
        final planner = await SettingsRepository(db).planner();
        final repo = AlarmRepository(db);
        final replaced = await repo.replaceBriefings(planner.briefings());
        final dropped = await repo.capPending(max: planner.pendingCap);
        for (final row in replaced) {
          await cancel([row.notificationId]);
        }
        for (final row in dropped) {
          await cancel([row.notificationId]);
        }
        final pending = await repo.pending();
        for (final row in pending) {
          await scheduleRow(
            row,
            title: titleFor(row.kind),
            body: await bodyFor(db, row),
          );
        }
      });
    } catch (_) {}
  }

  static String titleFor(String kind) {
    return switch (kind) {
      AlarmKind.nightBefore || AlarmKind.briefingEvening =>
        'Put it out for tomorrow',
      AlarmKind.morningOf => 'Need-by',
      AlarmKind.briefingMorning => "Today's check",
      _ => 'MissNothing',
    };
  }

  static Future<String> bodyFor(AppDatabase db, AlarmSchedule row) async {
    if (row.kind == AlarmKind.briefingMorning) {
      return 'Tap to sync and see anything that arrived overnight';
    }
    if (row.eventId == null) {
      return 'Check what needs to go out';
    }
    final record = await EventRepository(db).byId(row.eventId!);
    if (record == null) return 'School reminder';
    if (record.items.isEmpty) return record.event.title;
    return [for (final item in record.items) item.content].join(' · ');
  }

  static Future<void> scheduleRow(
    AlarmSchedule row, {
    String? title,
    String body = 'School reminder',
  }) async {
    await initNotifications();
    final when = tz.TZDateTime.from(row.fireAt.toLocal(), tz.local);
    if (when.isBefore(tz.TZDateTime.now(tz.local))) return;
    final resolvedTitle = title ?? titleFor(row.kind);
    final needBy = row.kind == AlarmKind.morningOf;
    await notificationPlugin.zonedSchedule(
      row.notificationId,
      resolvedTitle,
      body,
      when,
      NotificationDetails(
        android: AndroidNotificationDetails(
          needBy ? needByChannelId : alarmChannelId,
          needBy ? needByChannelName : alarmChannelName,
          channelDescription: needBy
              ? 'Time Sensitive need-by — the alarm that matters'
              : 'Night-before and morning-of school reminders',
          importance: Importance.max,
          priority: Priority.max,
          category: AndroidNotificationCategory.alarm,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: const [
            AndroidNotificationAction('done', 'Done'),
            AndroidNotificationAction('snooze', 'Snooze 15m'),
            AndroidNotificationAction('open', 'Open'),
          ],
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: NotificationPayload(
        eventId: row.eventId,
        alarmId: row.id,
        kind: row.kind,
      ).encode(),
    );
  }

  static Future<void> cancel(Iterable<int> notificationIds) async {
    try {
      await initNotifications();
      for (final id in notificationIds) {
        await notificationPlugin.cancel(id);
      }
    } catch (_) {}
  }
}

Future<void> requestReminderPermissions() => initNotifications();
