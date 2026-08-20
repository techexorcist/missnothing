export 'normalize.dart' show normalizeBody, isVerbatim;

/// Whitespace-normalized, lowercased, for substring checks.
String foldWs(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

bool isSubstringOfRaw(String span, String rawBody) {
  final hay = foldWs(rawBody).toLowerCase();
  final needle = foldWs(span).toLowerCase();
  if (needle.isEmpty) return false;
  return hay.contains(needle);
}
