import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/reminders/alarm_planner.dart';

abstract final class SettingKey {
  static const onboardingDone = 'onboarding_done';
  static const nightBeforeHour = 'night_before_hour';
  static const morningOfHour = 'morning_of_hour';
  static const morningOfMinute = 'morning_of_minute';
  static const retentionDays = 'body_retention_days';
  static const nagMutedIds = 'nag_muted_item_ids';
}

class SettingsRepository {
  const SettingsRepository(this.db);

  final AppDatabase db;

  Future<String?> get(String key) async {
    final row = await (db.select(
      db.appSettings,
    )..where((item) => item.key.equals(key))).getSingleOrNull();
    return row?.jsonValue;
  }

  Future<void> set(String key, String value) async {
    await db
        .into(db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: key,
            jsonValue: value,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<bool> onboardingDone() async {
    return await get(SettingKey.onboardingDone) == 'true';
  }

  Future<void> setOnboardingDone() => set(SettingKey.onboardingDone, 'true');

  Future<int> hour(String key, int fallback) async {
    return int.tryParse(await get(key) ?? '') ?? fallback;
  }

  Future<AlarmPlanner> planner() async {
    return AlarmPlanner(
      nightBefore: ClockTime(
        await hour(SettingKey.nightBeforeHour, SchoolClocks.putOut.hour),
        SchoolClocks.putOut.minute,
      ),
      morningOf: ClockTime(
        await hour(SettingKey.morningOfHour, SchoolClocks.needBy.hour),
        await hour(SettingKey.morningOfMinute, SchoolClocks.needBy.minute),
      ),
    );
  }
}
