import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import '../db/database.dart';
import '../gmail/sync_error.dart';
import 'device_unlock_gate.dart';

const periodicSyncTask = 'missnothing.periodicSync';
const pushSyncTask = 'missnothing.pushSync';

@pragma('vm:entry-point')
void syncCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final gate = DeviceUnlockGate();
    if (!await gate.isDeviceUnlocked()) {
      return true;
    }
    try {
      await gate.unwrapBackgroundKey();
    } on DeviceLockedException {
      return true;
    }
    return true;
  });
}

class BackgroundSyncScheduler {
  const BackgroundSyncScheduler();

  Future<void> initialize() async {
    await Workmanager().initialize(syncCallbackDispatcher);
    await Workmanager().registerPeriodicTask(
      periodicSyncTask,
      periodicSyncTask,
      frequency: const Duration(hours: 3),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> enqueuePushWake({String? accountId}) {
    return Workmanager().registerOneOffTask(
      '$pushSyncTask-${DateTime.now().millisecondsSinceEpoch}',
      pushSyncTask,
      inputData: {if (accountId != null) 'accountId': accountId},
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}

Future<AppDatabase> openBackgroundDatabase(String keyHex) async {
  final dir = await getApplicationSupportDirectory();
  final path = p.join(dir.path, 'missnothing.db');
  return AppDatabase(
    NativeDatabase.createInBackground(
      File(path),
      setup: (database) {
        database.execute("PRAGMA key = \"x'$keyHex'\";");
        if (database.select('PRAGMA cipher_version;').isEmpty) {
          throw StateError('Opened sqlite without SQLCipher.');
        }
      },
    ),
  );
}
