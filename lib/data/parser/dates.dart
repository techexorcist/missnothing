/// Candidate date extraction.
///
/// A reference number on the letterhead must never parse as a date. A date
/// equal to the mail's own Date header is the issue date, not the event.
library;

class DateCandidate {
  const DateCandidate({
    required this.date,
    required this.sourceText,
    required this.isIssueDate,
  });

  final DateTime date;
  final String sourceText;
  final bool isIssueDate;

  /// Alias used by gold tests.
  String get raw => sourceText;
}

const List<String> _monthNames = [
  'january',
  'february',
  'march',
  'april',
  'may',
  'june',
  'july',
  'august',
  'september',
  'october',
  'november',
  'december',
];
const List<String> _monthAbbr = [
  'jan',
  'feb',
  'mar',
  'apr',
  'may',
  'jun',
  'jul',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec',
];

int? _monthNumber(String word) {
  final w = word.toLowerCase().replaceAll('.', '');
  final full = _monthNames.indexOf(w);
  if (full >= 0) return full + 1;
  final abbr = _monthAbbr.indexOf(w);
  if (abbr >= 0) return abbr + 1;
  return null;
}

final String _monthAlt = ([
  ..._monthNames,
  ..._monthAbbr,
]..sort((a, b) => b.length - a.length)).join('|');

final List<RegExp> _refBlacklist = [
  RegExp(r'Cir\.?\s*No\.?\s*:?\s*\S+', caseSensitive: false),
  RegExp(r'Ref\.?\s*No\.?\s*:?\s*\S+', caseSensitive: false),
  RegExp(r'Circular\s*No\.?\s*:?\s*\S+', caseSensitive: false),
  RegExp(r'\b\d+/[A-Za-z]{2,}/\d{4}\s*-\s*\d{2,4}\b'),
  RegExp(r'\b(?:19|20)\d{2}\s*-\s*\d{2}\b'),
];

String maskReferences(String body) {
  var masked = body;
  for (final rx in _refBlacklist) {
    masked = masked.replaceAllMapped(rx, (m) => ' ' * m.group(0)!.length);
  }
  return masked;
}

DateTime _civil(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime? _withInferredYear(int day, int month, DateTime header) {
  if (month < 1 || month > 12 || day < 1 || day > 31) return null;
  DateTime? build(int year) {
    final d = DateTime(year, month, day);
    return (d.month == month && d.day == day) ? d : null;
  }

  final sameYear = build(header.year);
  if (sameYear == null) return null;
  if (sameYear.isBefore(_civil(header))) return build(header.year + 1);
  return sameYear;
}

List<DateCandidate> extractDateCandidates(String body, DateTime headerDate) {
  final header = _civil(headerDate);
  final masked = maskReferences(body);
  final found = <DateTime, DateCandidate>{};

  void add(DateTime? d, String source) {
    if (d == null) return;
    final civil = _civil(d);
    found.putIfAbsent(
      civil,
      () => DateCandidate(
        date: civil,
        sourceText: source.trim(),
        isIssueDate: civil == header,
      ),
    );
  }

  for (final m in RegExp(
    r'\b(\d{1,2})(?:st|nd|rd|th)?\s+(' + _monthAlt + r')\b',
    caseSensitive: false,
  ).allMatches(masked)) {
    final month = _monthNumber(m.group(2)!);
    if (month == null) continue;
    add(_withInferredYear(int.parse(m.group(1)!), month, header), m.group(0)!);
  }

  for (final m in RegExp(
    r'\b(' + _monthAlt + r')\s+(\d{1,2})(?:st|nd|rd|th)?\b',
    caseSensitive: false,
  ).allMatches(masked)) {
    final month = _monthNumber(m.group(1)!);
    if (month == null) continue;
    add(_withInferredYear(int.parse(m.group(2)!), month, header), m.group(0)!);
  }

  for (final m in RegExp(
    r'\b(\d{1,2})[/.-](\d{1,2})[/.-](\d{2,4})\b',
  ).allMatches(masked)) {
    final day = int.parse(m.group(1)!);
    final month = int.parse(m.group(2)!);
    var year = int.parse(m.group(3)!);
    if (year < 100) year += 2000;
    if (month < 1 || month > 12) continue;
    final d = DateTime(year, month, day);
    if (d.month == month && d.day == day) add(d, m.group(0)!);
  }

  if (RegExp(r'\btomorrow\b', caseSensitive: false).hasMatch(masked)) {
    add(header.add(const Duration(days: 1)), 'tomorrow');
  }
  if (RegExp(r'\btoday\b', caseSensitive: false).hasMatch(masked)) {
    add(header, 'today');
  }
  final weekday = RegExp(
    r'\b(?:this|next|coming)\s+(monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b',
    caseSensitive: false,
  ).firstMatch(masked);
  if (weekday != null) {
    const names = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    final target = names.indexOf(weekday.group(1)!.toLowerCase()) + 1;
    var delta = (target - header.weekday) % 7;
    if (delta <= 0) delta += 7;
    add(header.add(Duration(days: delta)), weekday.group(0)!);
  }

  final list = found.values.toList()..sort((a, b) => a.date.compareTo(b.date));
  return list;
}

List<DateCandidate> realDates(List<DateCandidate> all) =>
    all.where((c) => !c.isIssueDate).toList();

/// Gold-test aliases.
List<DateCandidate> enumerateDates(String body, DateTime messageDate) =>
    extractDateCandidates(body, messageDate);

DateTime? pickEventDate(List<DateCandidate> candidates) {
  final others = realDates(candidates);
  if (others.isNotEmpty) return others.first.date;
  return null;
}

bool looksLikeCirRef(String token) =>
    RegExp(r'\d+/[A-Za-z]{2,}/\d{4}\s*-\s*\d{2,4}').hasMatch(token);
