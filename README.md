# MissNothing

School circulars, turned into alarms. Local-only. Android walking skeleton first.

## Privacy / OAuth URLs

- Homepage: https://techexorcist.github.io/missnothing/
- Privacy: https://techexorcist.github.io/missnothing/privacy.html

## Run the skeleton (Android)

1. Google Cloud: enable Gmail API. Consent **Production**, app name **MissNothing**, those two URLs.
2. Create a **Web** OAuth client. Paste its client ID into `lib/config/app_config.dart` as `googleServerClientId`.
3. Create an **Android** OAuth client:
   - package: `app.missnothing`
   - debug SHA-1: `4B:A4:07:EA:DC:FB:B8:BD:E2:06:D8:CA:7C:09:24:5C:F4:72:D1:4A`
4. Plug in a phone, OEM battery exemption if Xiaomi/Oppo/Samsung.
5. `export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"`
6. `export ANDROID_HOME="$HOME/Library/Android/sdk"`
7. `flutter run`

Connect Gmail → Sync. Two exact notifications: **90 seconds** (smoke; fires on almost any phone) and **5 hours** (OEM test). After Sync, swipe the app out of recents, lock the phone, leave it. A 90-second fire does not prove Xiaomi/Oppo/Samsung will keep a 12-hour alarm.

Work lands on `main` in small slices. No pull requests.

