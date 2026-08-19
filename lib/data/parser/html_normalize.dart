final _entity = {
  'nbsp': ' ',
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
};

/// Decode a few HTML entities, drop tags, collapse &nbsp; / blank lines.
String normalizeBody(String raw) {
  var s = raw.replaceAll(RegExp(r'\r\n?'), '\n');
  s = s.replaceAllMapped(RegExp(r'&([a-z]+);', caseSensitive: false), (m) {
    return _entity[m[1]!.toLowerCase()] ?? m[0]!;
  });
  s = s.replaceAllMapped(RegExp(r'&#(\d+);'), (m) {
    return String.fromCharCode(int.parse(m[1]!));
  });
  s = s.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  s = s.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n');
  s = s.replaceAll(RegExp(r'<[^>]+>'), ' ');
  s = s.replaceAll('\u00a0', ' ');
  s = s.replaceAll(RegExp(r'[ \t]+'), ' ');
  s = s.replaceAll(RegExp(r' *\n *'), '\n');
  s = s.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  return s.trim();
}

/// Whitespace-normalized, lowercased, for substring checks.
String foldWs(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

bool isSubstringOfRaw(String span, String rawBody) {
  final hay = foldWs(rawBody).toLowerCase();
  final needle = foldWs(span).toLowerCase();
  if (needle.isEmpty) return false;
  return hay.contains(needle);
}
