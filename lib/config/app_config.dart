/// Compile-time config. Secrets are not committed.
///
/// Copy [secrets.json.example] to `secrets.json` (gitignored) and run:
/// `flutter run --dart-define-from-file=secrets.json`
class AppConfig {
  static const googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );

  static const allowlistedFrom = String.fromEnvironment(
    'ALLOWLISTED_FROM',
    defaultValue: 'vnspreprimary@vidyaniketanhebbal.org',
  );

  static const gmailReadonlyScope =
      'https://www.googleapis.com/auth/gmail.readonly';
}
