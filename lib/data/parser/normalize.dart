/// Turns a mail body into the canonical text every later stage works against.
///
/// This output IS the "raw body" for the substring invariant. Items are clipped
/// from it, so normalisation must happen exactly once, before anything else.
library;

const Map<String, String> _entities = {
  '&nbsp;': ' ',
  '&amp;': '&',
  '&lt;': '<',
  '&gt;': '>',
  '&quot;': '"',
  '&#39;': "'",
  '&apos;': "'",
  '&rsquo;': "'",
  '&lsquo;': "'",
  '&ldquo;': '"',
  '&rdquo;': '"',
  '&ndash;': '-',
  '&mdash;': '-',
  '&hellip;': '...',
};

final RegExp _tag = RegExp(r'<[^>]+>');
final RegExp _blockEnd =
    RegExp(r'</(p|div|tr|li|h[1-6])>', caseSensitive: false);
final RegExp _br = RegExp(r'<br\s*/?>', caseSensitive: false);
final RegExp _numericEntity = RegExp(r'&#(\d+);');
final RegExp _horizontalSpace =
    RegExp('[ \t\u00a0\u2000-\u200a\u202f\u205f\u3000]+');
final RegExp _blankLines = RegExp(r'\n{2,}');

String normalizeBody(String input) {
  var text = input;

  text = text.replaceAll(_br, '\n');
  text = text.replaceAllMapped(_blockEnd, (_) => '\n');
  text = text.replaceAll(_tag, ' ');

  _entities.forEach((entity, replacement) {
    text = text.replaceAll(entity, replacement);
  });
  text = text.replaceAllMapped(_numericEntity, (m) {
    final code = int.tryParse(m.group(1)!);
    if (code == null || code < 32 || code > 0x10ffff) return ' ';
    return String.fromCharCode(code);
  });

  text = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  text = text.replaceAll(_horizontalSpace, ' ');
  text = text.split('\n').map((line) => line.trim()).join('\n');
  text = text.replaceAll(_blankLines, '\n');

  return text.trim();
}

bool isVerbatim(String span, String body) {
  String squash(String s) =>
      s.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();
  return squash(body).contains(squash(span));
}
