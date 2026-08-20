import 'package:flutter/services.dart';

import '../gmail/sync_error.dart';

const backgroundKeyChannel = MethodChannel('app.missnothing/db_key');

class DeviceUnlockGate {
  const DeviceUnlockGate({this.channel = backgroundKeyChannel});

  final MethodChannel channel;

  /// True when the phone has been unlocked at least once since reboot.
  Future<bool> isDeviceUnlocked() async {
    try {
      return await channel.invokeMethod<bool>('isDeviceUnlocked') ?? false;
    } on MissingPluginException {
      return true;
    }
  }

  Future<String> unwrapBackgroundKey() async {
    try {
      final hex = await channel.invokeMethod<String>('unlockBackground');
      if (hex == null || hex.isEmpty) {
        throw const DeviceLockedException();
      }
      return hex;
    } on PlatformException catch (error) {
      if (error.code == 'device_locked' || error.code == 'no_background_key') {
        throw const DeviceLockedException();
      }
      rethrow;
    } on MissingPluginException {
      throw const DeviceLockedException();
    }
  }
}
