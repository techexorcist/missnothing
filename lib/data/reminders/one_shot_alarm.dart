import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../parser/proposal.dart';

const _channelId = 'missnothing_skeleton';
const _channelName = 'MissNothing skeleton';
const _notificationId = 1;

final _plugin = FlutterLocalNotificationsPlugin();

bool _initialized = false;

Future<void> initOneShotAlarms() async {
  if (_initialized) return;
  tzdata.initializeTimeZones();
  final info = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(info.identifier));

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  await _plugin.initialize(
    const InitializationSettings(android: android),
  );

  final androidPlugin = _plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidPlugin?.requestNotificationsPermission();
  await androidPlugin?.requestExactAlarmsPermission();
  _initialized = true;
}

/// Fire one exact notification shortly so OEM kill is visible today.
Future<DateTime> scheduleParsedCircular(Proposal proposal) async {
  await initOneShotAlarms();
  final when = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 90));
  final items = proposal.items.map((i) => i.textRaw).join(' · ');
  final date = proposal.date == null
      ? ''
      : '${proposal.date!.year}-${proposal.date!.month.toString().padLeft(2, '0')}-${proposal.date!.day.toString().padLeft(2, '0')}';
  await _plugin.zonedSchedule(
    _notificationId,
    'MissNothing · $date',
    items,
    when,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Walking-skeleton exact alarm',
        importance: Importance.max,
        priority: Priority.max,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
  return when;
}
