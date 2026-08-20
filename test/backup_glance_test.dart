import 'package:drift/native.dart';
import 'package:missnothing/data/backup/vault_backup.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/widgets/glance_state.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
  });

  tearDown(() => db.close());

  test('backup round-trips and rejects a bad passphrase', () async {
    final backup = VaultBackup();
    final blob = backup.seal(await backup.snapshot(db), 'family-key');
    final opened = backup.open(blob, 'family-key');
    expect(backup.preview(opened).eventCount, 0);
    expect(() => backup.open(blob, 'wrong-pass'), throwsFormatException);
  });

  test('glance card hides title when privacy is on', () async {
    final hidden = await GlanceState(db).publish(hide: true);
    expect(hidden.privacyHidden, isTrue);
    expect(hidden.title, 'Hidden');
    final shown = await GlanceState(db).publish(hide: false);
    expect(shown.privacyHidden, isFalse);
  });
}
