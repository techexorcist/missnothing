import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../db/database.dart';
import '../db/vault.dart';
import 'alarm_planner.dart';
import 'alarm_repository.dart';

const alarmChannelId = 'missnothing_alarms';
const alarmChannelName = 'School reminders';

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
  const NotificationPayload({this.eventId, this.alarmId});

  final String? eventId;
  final String? alarmId;

  static NotificationPayload? parse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return NotificationPayload(
        eventId: json['eventId'] as String?,
        alarmId: json['alarmId'] as String?,
      );
    } catch (_) {
      return NotificationPayload(eventId: raw);
    }
  }

  String encode() => jsonEncode({'eventId': eventId, 'alarmId': alarmId});
}

class EventAlarms {
  static Future<void> reconcile(MissNothingVault vault) async {
    try {
      await initNotifications();
      await vault.use((db) async {
        final pending = await AlarmRepository(db).pending();
        for (final row in pending) {
          await scheduleRow(
            row,
            title: switch (row.kind) {
              AlarmKind.nightBefore => 'Put it out for tomorrow',
              AlarmKind.morningOf => 'Still not out',
              _ => 'MissNothing',
            },
            body: 'School reminder',
          );
        }
      });
    } catch (_) {}
  }

  static Future<void> scheduleRow(
    AlarmSchedule row, {
    String? title,
    String body = 'School reminder',
  }) async {
    await initNotifications();
    final when = tz.TZDateTime.from(row.fireAt.toLocal(), tz.local);
    if (when.isBefore(tz.TZDateTime.now(tz.local))) return;
    final resolvedTitle =
        title ??
        switch (row.kind) {
          AlarmKind.nightBefore => 'Put it out for tomorrow',
          AlarmKind.morningOf => 'Still not out',
          _ => 'MissNothing',
        };
    await notificationPlugin.zonedSchedule(
      row.notificationId,
      resolvedTitle,
      body,
      when,
      NotificationDetails(
        android: AndroidNotificationDetails(
          alarmChannelId,
          alarmChannelName,
          channelDescription: 'Night-before and morning-of school reminders',
          importance: Importance.max,
          priority: Priority.max,
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
