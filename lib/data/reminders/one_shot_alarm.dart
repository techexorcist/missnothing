import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../parser/proposal.dart';
import 'notifications.dart';

const _channelId = 'missnothing_skeleton';
const _channelName = 'MissNothing skeleton';
const nearAlarmId = 1;
const farAlarmId = 2;

class ScheduledAlarms {
  const ScheduledAlarms({required this.near, required this.far});

  final DateTime near;
  final DateTime far;
}

Future<void> initOneShotAlarms() => initNotifications();

/// Two exact alarms: 90s is a smoke test (will fire on almost any phone).
/// 5h is the OEM-kill test — swipe out of recents, lock, leave it.
Future<ScheduledAlarms> scheduleParsedCircular(Proposal proposal) async {
  await initOneShotAlarms();
  await notificationPlugin.cancel(nearAlarmId);
  await notificationPlugin.cancel(farAlarmId);

  final now = tz.TZDateTime.now(tz.local);
  final near = now.add(const Duration(seconds: 90));
  final far = now.add(const Duration(hours: 5));
  final items = proposal.items.map((i) => i.textRaw).join(' · ');
  final date = proposal.date == null
      ? proposal.type.name
      : '${proposal.date!.year}-${proposal.date!.month.toString().padLeft(2, '0')}-${proposal.date!.day.toString().padLeft(2, '0')}';

  await _zoned(nearAlarmId, 'MissNothing · 90s smoke · $date', items, near);
  await _zoned(
    farAlarmId,
    'MissNothing · 5h OEM · $date',
    'Swipe out of recents, lock, leave it. $items',
    far,
  );
  return ScheduledAlarms(near: near, far: far);
}

Future<void> _zoned(int id, String title, String body, tz.TZDateTime when) {
  return notificationPlugin.zonedSchedule(
    id,
    title,
    body,
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
}
