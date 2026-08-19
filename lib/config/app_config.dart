/// Walking-skeleton config. Paste the Google Cloud **Web** client ID
/// (not the Android client). Android still needs an OAuth client with
/// package `app.missnothing` and this machine's debug SHA-1.
class AppConfig {
  static const googleServerClientId = '';

  static const allowlistedFrom = 'vnspreprimary@vidyaniketanhebbal.org';

  static const gmailReadonlyScope =
      'https://www.googleapis.com/auth/gmail.readonly';
}
