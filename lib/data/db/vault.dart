import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../gmail/message_record.dart';
import 'database.dart';
import 'gmail_message_index.dart';

const dbKeyChannel = MethodChannel('app.missnothing/db_key');

class VaultOpen {
  const VaultOpen({
    required this.lastUnlock,
    required this.cipherVersion,
    required this.vault,
  });

  final String lastUnlock;
  final String cipherVersion;
  final MissNothingVault vault;
}

class MissNothingVault {
  MissNothingVault._({required String path, required String keyHex})
    : _path = path,
      _keyHex = keyHex;

  final String _path;
  final String _keyHex;
  AppDatabase? _db;
  Future<AppDatabase>? _opening;

  AppDatabase _openDatabase() {
    return AppDatabase(
      NativeDatabase.createInBackground(
        File(_path),
        setup: (db) {
          db.execute("PRAGMA key = \"x'$_keyHex'\";");
          if (db.select('PRAGMA cipher_version;').isEmpty) {
            throw StateError(
              'Opened sqlite without SQLCipher. '
              'Refusing to store mail on disk.',
            );
          }
        },
      ),
    );
  }

  Future<AppDatabase> _ensureOpen() {
    final existing = _db;
    if (existing != null) return Future.value(existing);
    return _opening ??= () async {
      try {
        final db = _openDatabase();
        await GmailMessageIndex(db).initialize();
        _db = db;
        return db;
      } catch (_) {
        _opening = null;
        rethrow;
      }
    }();
  }

  Future<T> use<T>(Future<T> Function(AppDatabase db) action) async {
    final db = await _ensureOpen();
    return action(db);
  }

  Future<void> close() async {
    final db = _db;
    _db = null;
    _opening = null;
    await db?.close();
  }

  Future<IdReconciliation> recordGmailMessages({
    required List<String> listedIds,
    required Iterable<GmailMessageRecord> records,
  }) {
    return use((db) async {
      final index = GmailMessageIndex(db);
      await index.initialize();
      return index.recordAndReconcile(listedIds: listedIds, records: records);
    });
  }
}

/// Opens SQLCipher after the native side returns a Keystore-unwrapped key.
Future<VaultOpen> unlockVault() async {
  final hex = await dbKeyChannel.invokeMethod<String>('unlock');
  if (hex == null || hex.isEmpty) {
    throw StateError('Keystore returned an empty database key.');
  }

  final dir = await getApplicationSupportDirectory();
  final path = p.join(dir.path, 'missnothing.db');
  final vault = MissNothingVault._(path: path, keyHex: hex);
  final raw = sqlite3.open(path);
  raw.execute("PRAGMA key = \"x'$hex'\";");

  final cipher = raw.select('PRAGMA cipher_version;');
  if (cipher.isEmpty) {
    raw.close();
    throw StateError(
      'Opened sqlite without SQLCipher. Refusing to store mail on disk.',
    );
  }
  final version = cipher.first.values.first.toString();
  raw.close();

  late final String lastUnlock;
  await vault.use((db) async {
    final now = DateTime.now().toIso8601String();
    await db.customStatement(
      'INSERT INTO meta(k, v) VALUES(?, ?) '
      'ON CONFLICT(k) DO UPDATE SET v = excluded.v;',
      ['last_unlock', now],
    );
    final row = await db
        .customSelect(
          'SELECT v FROM meta WHERE k = ?;',
          variables: [Variable<String>('last_unlock')],
        )
        .getSingle();
    lastUnlock = row.read<String>('v');
  });
  return VaultOpen(
    lastUnlock: lastUnlock,
    cipherVersion: version,
    vault: vault,
  );
}
