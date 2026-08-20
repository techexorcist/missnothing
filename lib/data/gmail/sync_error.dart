enum SyncErrorCode {
  offline,
  revoked,
  quota,
  backend,
  parser,
  permission,
  deviceLocked,
  unknown,
}

class SyncException implements Exception {
  const SyncException(this.code, this.message, {this.cause});

  final SyncErrorCode code;
  final String message;
  final Object? cause;

  @override
  String toString() => 'SyncException(${code.name}: $message)';
}

class HistoryStaleException implements Exception {
  const HistoryStaleException(this.historyId);

  final String historyId;

  @override
  String toString() => 'HistoryStaleException($historyId)';
}

class DeviceLockedException extends SyncException {
  const DeviceLockedException()
    : super(
        SyncErrorCode.deviceLocked,
        'Device has not been unlocked since reboot. Sync is deferred.',
      );
}

SyncErrorCode classifySyncFailure(Object error) {
  if (error is SyncException) return error.code;
  if (error is DeviceLockedException) return SyncErrorCode.deviceLocked;
  final text = error.toString().toLowerCase();
  if (text.contains('socket') ||
      text.contains('failed host lookup') ||
      text.contains('network is unreachable') ||
      text.contains('connection refused') ||
      text.contains('clientexception') ||
      text.contains('offline')) {
    return SyncErrorCode.offline;
  }
  if (text.contains('invalid_grant') ||
      text.contains('unauthenticated') ||
      text.contains('invalid_rapt') ||
      text.contains('token has been expired or revoked')) {
    return SyncErrorCode.revoked;
  }
  if (text.contains('403') &&
      (text.contains('quota') ||
          text.contains('ratelimit') ||
          text.contains('userRateLimitExceeded') ||
          text.contains('rate limit'))) {
    return SyncErrorCode.quota;
  }
  if (text.contains('429') ||
      text.contains('quotaexceeded') ||
      text.contains('rate limit')) {
    return SyncErrorCode.quota;
  }
  if (text.contains('permission') ||
      text.contains('insufficient') ||
      text.contains('access_denied') ||
      text.contains('403')) {
    return SyncErrorCode.permission;
  }
  if (text.contains('backend') ||
      text.contains('cloud run') ||
      text.contains('internal_authentication') ||
      text.contains('503') ||
      text.contains('502')) {
    return SyncErrorCode.backend;
  }
  if (text.contains('parser') || text.contains('nothing-found')) {
    return SyncErrorCode.parser;
  }
  return SyncErrorCode.unknown;
}

String syncErrorCopy(SyncErrorCode code) {
  return switch (code) {
    SyncErrorCode.offline =>
      'Offline. MissNothing will retry when the network returns.',
    SyncErrorCode.revoked =>
      'Gmail access was revoked. Reconnect this account to keep reading mail.',
    SyncErrorCode.quota =>
      'Gmail temporarily limited this mailbox. Sync will retry later.',
    SyncErrorCode.backend =>
      'The token service could not issue an access token. Try again later.',
    SyncErrorCode.parser =>
      'Mail arrived, but the parser could not extract an action.',
    SyncErrorCode.permission =>
      'Notifications or exact alarms are blocked. Open Android settings.',
    SyncErrorCode.deviceLocked =>
      'Waiting for the first unlock after reboot before reading mail.',
    SyncErrorCode.unknown => 'Sync failed. Details stay on this device.',
  };
}
