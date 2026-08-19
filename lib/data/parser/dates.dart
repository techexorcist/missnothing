class DateCandidate {
  const DateCandidate({
    required this.date,
    required this.raw,
    required this.isIssueDate,
  });

  final DateTime date;
  final String raw;
  final bool isIssueDate;
}

final _months = <String, int>{
  'january': 1,
  'jan': 1,
  'february': 2,
  'feb': 2,
  'march': 3,
  'mar': 3,
  'april': 4,
  'apr': 4,
  'may': 5,
  'june': 6,
  'jun': 6,
  'july': 7,
  'jul': 7,
  'august': 8,
  'aug': 8,
  'september': 9,
  'sep': 9,
  'sept': 9,
  'october': 10,
  'oct': 10,
  'november': 11,
  'nov': 11,
  'december': 12,
  'dec': 12,
};

final _cirNoLine = RegExp(r'cir\s*no\s*:', caseSensitive: false);
final _refShape = RegExp(r'\d+/[A-Z]+/\d{4}-\d{2}');
final _academicYear = RegExp(r'\b\d{4}-\d{2}\b');
final _namedDate = RegExp(
  r'\b(\d{1,2})(?:st|nd|rd|th)?\s+'
  r'(january|february|march|april|may|june|july|august|september|october|november|december|'
  r'jan|feb|mar|apr|jun|jul|aug|sep|sept|oct|nov|dec)\s*'
  r'(\d{4})?\b',
  caseSensitive: false,
);
final _slashDate = RegExp(r'\b(\d{1,2})/(\d{1,2})(?:/(\d{2,4}))?\b');

bool _blacklistedRaw(String raw) {
  if (_refShape.hasMatch(raw)) return true;
  if (_academicYear.hasMatch(raw) && !_namedDate.hasMatch(raw)) return true;
  return false;
}

DateTime _civil(DateTime t) => DateTime(t.year, t.month, t.day);

DateTime _withYear(int day, int month, int? year, DateTime header) {
  final y = year ?? header.year;
  var d = DateTime(y, month, day);
  if (year != null) return d;
  if (month < header.month || (month == header.month && day < header.day)) {
    d = DateTime(header.year + 1, month, day);
  }
  return d;
}

/// Enumerate date tokens. Cir-No / academic-year shapes are dropped.
/// The email Date header’s civil day is marked [DateCandidate.isIssueDate].
List<DateCandidate> enumerateDates(String body, DateTime messageDate) {
  final header = _civil(messageDate);
  final masked = body.replaceAll(_refShape, ' ');
  final found = <String, DateCandidate>{};

  void add(DateTime date, String raw) {
    if (_blacklistedRaw(raw)) return;
    if (_cirNoLine.hasMatch(raw)) return;
    final civil = _civil(date);
    final key = '${civil.year}-${civil.month}-${civil.day}';
    found.putIfAbsent(
      key,
      () => DateCandidate(
        date: civil,
        raw: raw,
        isIssueDate: civil == header,
      ),
    );
  }

  for (final m in _namedDate.allMatches(masked)) {
    final day = int.parse(m[1]!);
    final month = _months[m[2]!.toLowerCase()]!;
    final year = m[3] == null ? null : int.parse(m[3]!);
    if (day < 1 || day > 31) continue;
    add(_withYear(day, month, year, header), m[0]!);
  }

  for (final m in _slashDate.allMatches(masked)) {
    if (_refShape.hasMatch(m[0]!)) continue;
    final day = int.parse(m[1]!);
    final month = int.parse(m[2]!);
    if (month < 1 || month > 12 || day < 1 || day > 31) continue;
    int? year;
    if (m[3] != null) {
      year = int.parse(m[3]!);
      if (year < 100) year += 2000;
    }
    add(_withYear(day, month, year, header), m[0]!);
  }

  return found.values.toList();
}

/// Prefer a non-issue candidate. Keep the issue date only if nothing else exists
/// *and* a caller later decides a directive binds that day.
DateTime? pickEventDate(List<DateCandidate> candidates) {
  final others = candidates.where((c) => !c.isIssueDate).toList();
  if (others.isNotEmpty) return others.first.date;
  return null;
}

bool looksLikeAcademicYear(String token) => _academicYear.hasMatch(token);
bool looksLikeCirRef(String token) => _refShape.hasMatch(token);
