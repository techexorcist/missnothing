/// Strip phone numbers, URLs and bidi marks at render time only.
String displayText(String raw) {
  return raw
      .replaceAll(RegExp(r'https?://\S+', caseSensitive: false), '')
      .replaceAll(RegExp(r'\+?\d[\d\s().-]{7,}\d'), '')
      .replaceAll(RegExp(r'[\u200B-\u200F\u202A-\u202E]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

String itemHeadline(String raw) {
  final text = displayText(raw);
  if (text.isEmpty) return 'School item';
  final cut = text.split(RegExp(r'[.!;]')).first.trim();
  if (cut.length <= 42) return cut;
  return '${cut.substring(0, 41).trimRight()}…';
}

bool looksBagless(String raw) {
  final lower = raw.toLowerCase();
  return lower.contains('bagless') ||
      lower.contains('leave it at home') ||
      lower.contains('no school bag') ||
      lower.contains('snacks bag only');
}
