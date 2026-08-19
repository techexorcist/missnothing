import '../dates.dart';
import '../html_normalize.dart';
import '../proposal.dart';

const schoolInPackId = 'school_in';

final _xDay = RegExp(
  r'\b([A-Z][a-z]+(?:\s[A-Z][a-z]+)?)\s+Day\b',
);
final _xDayCi = RegExp(
  r'\b([A-Za-z]+(?:\s[A-Za-z]+)?)\s+day\b',
  caseSensitive: false,
);
final _xDayStop = {
  'the',
  'a',
  'this',
  'that',
  'school',
  'one',
  'every',
  'same',
  'next',
  'our',
  'your',
};
final _contextDays = {
  'independence',
  'republic',
  'christmas',
  'boxing',
  'labour',
  'labor',
  'may',
  "children's",
  'childrens',
  "teachers'",
  "teacher's",
  'teachers',
  'new year',
  "new year's",
};

final _directive = RegExp(
  r'we request you to send|kindly send your child|kindly send|'
  r'please ensure|children are requested to|may be sent in|please send',
  caseSensitive: false,
);

final _decisionCue = RegExp(
  r'\binterested\b|give away|to give away|\bavailable\b|take a look|'
  r'\bopt[- ]?in\b|book fair|workshop|slot booking',
  caseSensitive: false,
);

final _scarcity = RegExp(
  r'limited number|first-come,\s*first-served|first come,\s*first served|'
  r'while stocks last|limited seats',
  caseSensitive: false,
);

final _whenHint = <RegExp, WhenHint>{
  RegExp(r'\bdispersal\b', caseSensitive: false): WhenHint.dispersal,
  RegExp(r'\bpickup\b|\bpick-up\b', caseSensitive: false): WhenHint.pickup,
  RegExp(r'\bhome time\b', caseSensitive: false): WhenHint.homeTime,
  RegExp(r'\bmorning assembly\b|\bassembly\b', caseSensitive: false):
      WhenHint.assembly,
  RegExp(r'\blunch break\b|\blunch\b', caseSensitive: false): WhenHint.lunch,
  RegExp(r'\bbefore school\b', caseSensitive: false): WhenHint.beforeSchool,
};

final _dressCue = RegExp(
  r'\bethnic\b|\btricolou?r\b|\bmufti\b|colour dress|color dress|'
  r'saffron,\s*white',
  caseSensitive: false,
);
final _bringCue = RegExp(
  r'bagless|snacks bag|snack bag',
  caseSensitive: false,
);
final _offerCue = RegExp(
  r'give away|pre-loved|sweaters?|swears|uniform sale',
  caseSensitive: false,
);

/// Indian school circular pack. School-agnostic language, not one template.
Proposal? parseSchoolIn(ParseInput input) {
  final body = normalizeBody(input.body);
  if (body.isEmpty) return null;

  final dates = enumerateDates(body, input.messageDate);
  final eventDate = pickEventDate(dates);
  final xDays = _namedDays(body);
  final hasDirective = _directive.hasMatch(body);
  final hasDecision = _decisionCue.hasMatch(body);
  final hasScarcity = _scarcity.hasMatch(body);
  final hint = _firstHint(body);

  final items = <ProposalItem>[];

  final dress = _clipAround(body, _dressCue, kind: ItemKind.dress);
  if (dress != null) items.add(dress);

  final bring = _clipAround(
    body,
    _bringCue,
    kind: ItemKind.bring,
    prefer: 'bagless',
  );
  if (bring != null) items.add(bring);

  if (hasDecision && items.every((i) => i.kind != ItemKind.offer)) {
    final loc = _offerLocation(body);
    final offer = _clipAround(
      body,
      _offerCue,
      kind: ItemKind.offer,
      location: loc,
    );
    if (offer != null) {
      items.add(offer);
    }
  }

  if (items.isEmpty && xDays.isNotEmpty && hasDirective) {
    final clip = _sentenceContaining(body, xDays.first);
    if (clip != null) {
      items.add(ProposalItem(kind: ItemKind.other, textRaw: clip));
    }
  }

  if (items.isEmpty) return null;

  late final ProposalType type;
  DateTime? date;
  bool? allDay;

  final datedCues = xDays.isNotEmpty || (hasDirective && eventDate != null);
  if (hasDecision && !datedCues) {
    type = ProposalType.decision;
    date = null;
    allDay = null;
  } else if (eventDate != null && (hasDirective || xDays.isNotEmpty)) {
    type = ProposalType.datedAction;
    date = eventDate;
    allDay = true;
  } else if (hasDirective) {
    type = ProposalType.undatedAction;
    date = null;
    allDay = null;
  } else if (hasDecision) {
    type = ProposalType.decision;
    date = null;
    allDay = null;
  } else {
    return null;
  }

  return Proposal(
    type: type,
    date: date,
    allDay: date == null ? null : allDay,
    urgency: hasScarcity ? Urgency.actToday : Urgency.none,
    whenHint: hint,
    from: input.from,
    threadId: input.threadId,
    items: items,
  );
}

List<String> _namedDays(String body) {
  final out = <String>[];
  for (final m in _xDay.allMatches(body).followedBy(_xDayCi.allMatches(body))) {
    final label = m[1]!.toLowerCase().trim();
    if (_xDayStop.contains(label)) continue;
    if (_contextDays.contains(label)) continue;
    final full = m[0]!.trim();
    if (!out.any((e) => e.toLowerCase() == full.toLowerCase())) {
      out.add(full);
    }
  }
  return out;
}

WhenHint? _firstHint(String body) {
  for (final e in _whenHint.entries) {
    if (e.key.hasMatch(body)) return e.value;
  }
  return null;
}

String? _offerLocation(String body) {
  final foyer = RegExp(
    r'carton box at the center foyer|at the center foyer|in the foyer',
    caseSensitive: false,
  );
  final hit = foyer.firstMatch(body);
  if (hit != null) {
    final t = hit[0]!.toLowerCase();
    if (t.contains('carton box')) return 'carton box at the center foyer';
    return hit[0]!;
  }
  return null;
}

ProposalItem? _clipAround(
  String body,
  RegExp cue, {
  required ItemKind kind,
  String? prefer,
  String? location,
}) {
  Match? m;
  if (prefer != null) {
    m = RegExp(prefer, caseSensitive: false).firstMatch(body);
  }
  m ??= cue.firstMatch(body);
  if (m == null) return null;
  final sentence = _sentenceAt(body, m.start);
  if (sentence == null) return null;
  return ProposalItem(kind: kind, textRaw: sentence, location: location);
}

String? _sentenceContaining(String body, String needle) {
  final i = body.toLowerCase().indexOf(needle.toLowerCase());
  if (i < 0) return null;
  return _sentenceAt(body, i);
}

String? _sentenceAt(String body, int index) {
  var start = 0;
  for (var i = index; i >= 0; i--) {
    if (body[i] == '.' || body[i] == '\n') {
      start = i + 1;
      break;
    }
  }
  var end = body.length;
  for (var i = index; i < body.length; i++) {
    if (body[i] == '.' || body[i] == '\n') {
      end = body[i] == '.' ? i + 1 : i;
      break;
    }
  }
  final clip = foldWs(body.substring(start, end));
  if (clip.isEmpty) return null;
  return clip;
}
