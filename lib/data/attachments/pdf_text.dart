import 'dart:convert';
import 'dart:typed_data';

/// Local PDF text fallback. Pulls printable strings; scanned pages stay empty
/// so the OCR path can run later. Never interprets HTML or embedded scripts.
class PdfTextExtract {
  static const _header = [0x25, 0x50, 0x44, 0x46]; // %PDF

  static bool isPdf(Uint8List bytes) {
    if (bytes.length < 5) return false;
    for (var i = 0; i < _header.length; i++) {
      if (bytes[i] != _header[i]) return false;
    }
    return true;
  }

  static String? extract(Uint8List bytes) {
    if (!isPdf(bytes)) return null;
    final raw = latin1.decode(bytes, allowInvalid: true);
    final matches = RegExp(r'\((?:\\.|[^\\)]){4,}\)').allMatches(raw);
    final parts = <String>[];
    for (final match in matches) {
      var text = match.group(0)!;
      text = text.substring(1, text.length - 1);
      text = text
          .replaceAll(r'\n', '\n')
          .replaceAll(r'\r', '')
          .replaceAll(RegExp(r'\\(.)'), r'$1');
      if (RegExp(r'[A-Za-z]{3}').hasMatch(text)) {
        parts.add(text.trim());
      }
    }
    if (parts.isEmpty) return '';
    return parts.join('\n');
  }
}
