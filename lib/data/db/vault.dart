import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

const dbKeyChannel = MethodChannel('app.missnothing/db_key');

class VaultOpen {
  const VaultOpen({
    required this.lastUnlock,
    required this.cipherVersion,
  });

  final String lastUnlock;
  final String cipherVersion;
}

/// Opens SQLCipher after the native side returns a Keystore-unwrapped key.
Future<VaultOpen> unlockVault() async {
  final hex = await dbKeyChannel.invokeMethod<String>('unlock');
  if (hex == null || hex.isEmpty) {
    throw StateError('Keystore returned an empty database key.');
  }

  final dir = await getApplicationSupportDirectory();
  final path = p.join(dir.path, 'missnothing.db');
  final db = sqlite3.open(path);
  db.execute("PRAGMA key = \"x'$hex'\";");

  final cipher = db.select('PRAGMA cipher_version;');
  if (cipher.isEmpty) {
    db.close();
    throw StateError(
      'Opened sqlite without SQLCipher. Refusing to store mail on disk.',
    );
  }

  db.execute(
    'CREATE TABLE IF NOT EXISTS meta ('
    'k TEXT PRIMARY KEY NOT NULL,'
    'v TEXT NOT NULL'
    ');',
  );
  final now = DateTime.now().toIso8601String();
  db.execute(
    'INSERT INTO meta(k, v) VALUES(?, ?) '
    'ON CONFLICT(k) DO UPDATE SET v = excluded.v;',
    ['last_unlock', now],
  );
  final row = db.select('SELECT v FROM meta WHERE k = ?', ['last_unlock']);
  final version = cipher.first.values.first.toString();
  db.close();
  return VaultOpen(lastUnlock: row.first['v'] as String, cipherVersion: version);
}
