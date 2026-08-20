import 'package:missnothing/config/app_config.dart';
import 'package:missnothing/data/gmail/from_header.dart';
import 'package:test/test.dart';

void main() {
  const allow = 'vnspreprimary@vidyaniketanhebbal.org';

  test('bare address matches exactly', () {
    expect(fromMatchesAllowlist(allow, allow), isTrue);
    expect(fromMatchesAllowlist(' $allow ', allow), isTrue);
  });

  test('display-name plus angle-bracket mailbox matches the mailbox', () {
    expect(
      fromMatchesAllowlist('Vidya Niketan <$allow>', allow),
      isTrue,
    );
  });

  test('allowlisted string in display-name does not match', () {
    expect(
      fromMatchesAllowlist('"$allow" <attacker@evil.com>', allow),
      isFalse,
    );
    expect(
      mailboxFromFromHeader('"$allow" <attacker@evil.com>'),
      'attacker@evil.com',
    );
  });

  test('substring of a different mailbox does not match', () {
    expect(
      fromMatchesAllowlist('not$allow', allow),
      isFalse,
    );
  });

  test('config allowlist is compared case-insensitively', () {
    expect(
      fromMatchesAllowlist(allow.toUpperCase(), AppConfig.allowlistedFrom),
      isTrue,
    );
  });
}
