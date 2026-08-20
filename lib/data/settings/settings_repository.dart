import 'package:missnothing/data/db/database.dart';

abstract final class SettingKey {
  static const onboardingDone = 'onboarding_done';
  static const nightBeforeHour = 'night_before_hour';
  static const morningOfHour = 'morning_of_hour';
  static const retentionDays = 'body_retention_days';
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
}
