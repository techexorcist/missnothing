import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import '../db/database.dart';

class BackupPreview {
  const BackupPreview({
    required this.eventCount,
    required this.proposalCount,
    required this.exportedAt,
  });

  final int eventCount;
  final int proposalCount;
  final DateTime exportedAt;
}

/// Versioned JSON export. The passphrase is stretched with SHA-256 and the
/// payload is XOR-streamed, then prefixed with a MAC. This is a family-device
/// export, not a multi-tenant KMS design.
class VaultBackup {
  static const version = 1;
  static const _magic = 'MNB1';

  Future<Map<String, Object?>> snapshot(AppDatabase db) async {
    final events = await db.select(db.events).get();
    final eventItems = await db.select(db.eventItems).get();
    final proposals = await db.select(db.proposals).get();
    final proposalItems = await db.select(db.proposalItems).get();
    return {
      'version': version,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'events': [
        for (final row in events)
          {
            'id': row.id,
            'title': row.title,
            'startsAt': row.startsAt?.toIso8601String(),
            'location': row.location,
            'status': row.status,
            'notes': row.notes,
          },
      ],
      'eventItems': [
        for (final row in eventItems)
          {
            'id': row.id,
            'eventId': row.eventId,
            'position': row.position,
            'kind': row.kind,
            'content': row.content,
          },
      ],
      'proposals': [
        for (final row in proposals)
          {
            'id': row.id,
            'subject': row.subject,
            'status': row.status,
            'type': row.type,
          },
      ],
      'proposalItems': [
        for (final row in proposalItems)
          {'id': row.id, 'proposalId': row.proposalId, 'textRaw': row.textRaw},
      ],
    };
  }

  Uint8List seal(Map<String, Object?> snapshot, String passphrase) {
    if (passphrase.length < 8) {
      throw ArgumentError('Passphrase must be at least 8 characters.');
    }
    final payload = utf8.encode(jsonEncode(snapshot));
    final key = sha256.convert(
      utf8.encode('missnothing.backup.v1:$passphrase'),
    );
    final cipher = _xor(payload, key.bytes);
    final mac = Hmac(
      sha256,
      key.bytes,
    ).convert([...utf8.encode(_magic), ...cipher]);
    return Uint8List.fromList([
      ...utf8.encode(_magic),
      ...mac.bytes,
      ...cipher,
    ]);
  }

  Map<String, Object?> open(Uint8List blob, String passphrase) {
    final magic = utf8.decode(blob.sublist(0, 4));
    if (magic != _magic) {
      throw const FormatException('Not a MissNothing backup.');
    }
    final mac = blob.sublist(4, 36);
    final cipher = blob.sublist(36);
    final key = sha256.convert(
      utf8.encode('missnothing.backup.v1:$passphrase'),
    );
    final expected = Hmac(
      sha256,
      key.bytes,
    ).convert([...utf8.encode(_magic), ...cipher]);
    if (!_constantTimeEquals(mac, expected.bytes)) {
      throw const FormatException('Passphrase or file is wrong.');
    }
    final json = jsonDecode(utf8.decode(_xor(cipher, key.bytes)));
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Backup payload is not an object.');
    }
    return json;
  }

  BackupPreview preview(Map<String, Object?> snapshot) {
    final events = snapshot['events'];
    final proposals = snapshot['proposals'];
    return BackupPreview(
      eventCount: events is List ? events.length : 0,
      proposalCount: proposals is List ? proposals.length : 0,
      exportedAt:
          DateTime.tryParse('${snapshot['exportedAt']}') ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    );
  }

  Uint8List _xor(List<int> data, List<int> key) {
    final out = Uint8List(data.length);
    for (var i = 0; i < data.length; i++) {
      out[i] = data[i] ^ key[i % key.length];
    }
    return out;
  }

  bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
