/// Rule pack for Indian / English-medium school circulars.
///
/// Rules key off language parents meet at any such school. "X Day" and
/// "kindly send your child" qualify. Sequential circular numbering does not.
library;

import '../dates.dart';
import '../normalize.dart';
import '../pack.dart';
import '../proposal.dart';
import '../sentences.dart';

const schoolInPackId = 'school_in';

const Set<String> _dayStopwords = {
  'the',
  'a',
  'this',
  'that',
  'school',
  'one',
  'every',
  'same',
  'next',
  'last',
  'each',
  'any',
  'some',
  'first',
  'second',
  'other',
};

const Set<String> _festivalDays = {
  'independence day',
  'republic day',
  "children's day",
  'childrens day',
  "teacher's day",
  'teachers day',
  "mother's day",
  'mothers day',
  "father's day",
  'fathers day',
  'earth day',
  'yoga day',
  'labour day',
  'labor day',
  "women's day",
  'womens day',
  'environment day',
  'literacy day',
  "founder's day",
  'founders day',
  'new year day',
  'christmas day',
};

const List<String> _directives = [
  'we request you to send',
  'we request you to',
  'kindly send your child',
  'please send your child',
  'children are requested to',
  'students are requested to',
  'parents are requested to',
  'kindly ensure that',
  'please ensure that',
  'kindly ensure',
  'please ensure',
  'may be sent in',
  'kindly send',
  'please send',
  'are requested to',
  'kindly arrange',
  'please arrange',
  'kindly note that children',
  'kindly bring',
  'please bring',
];

const List<String> _opportunity = [
  'interested',
  'give away',
  'giving away',
  'available on a',
  'take a look',
  'opt in',
  'opt-in',
  'sign up',
  'book a slot',
  'register for',
  'may avail',
  'on offer',
  'up for grabs',
];

const List<String> _scarcity = [
  'limited number',
  'first-come, first-served',
  'first come, first served',
  'on a first-come',
  'on a first come',
  'while stocks last',
  'limited seats',
  'limited stock',
  'limited slots',
  'subject to availability',
];

const Map<String, WhenHint> _whenHints = {
  'morning assembly': WhenHint.assembly,
  'before school': WhenHint.beforeSchool,
  'lunch break': WhenHint.lunch,
  'home time': WhenHint.homeTime,
  'dispersal': WhenHint.dispersal,
  'pick-up': WhenHint.pickup,
  'pick up': WhenHint.pickup,
  'pickup': WhenHint.pickup,
  'assembly': WhenHint.assembly,
  'lunch': WhenHint.lunch,
};

const List<String> _placeNouns = [
  'notice board',
  'noticeboard',
  'foyer',
  'office',
  'library',
  'reception',
  'gate',
  'hall',
  'counter',
  'desk',
  'ground',
  'auditorium',
  'classroom',
  'quadrangle',
  'lobby',
  'corridor',
];

const List<String> _dressCues = [
  'dress',
  'dressed',
  'outfit',
  'wear',
  'worn',
  'attire',
  'costume',
  'uniform',
  'colour',
  'color',
  'mufti',
  'ethnic',
];
const List<String> _bringCues = [
  'bring',
  'carry',
  'bag',
  'submit',
  'return',
  'send your child with',
  'hand over',
  'pack',
];
const List<String> _attendCues = [
  'attend',
  'assemble',
  'gather',
  'be present',
  'report to',
  'join us',
];

const List<String> _leadFiller = [
  'your child with only their',
  'your child with only',
  'your child',
  'your ward',
  'their child',
  'to come in',
  'to be in',
  'dressed in',
  'dressed',
  'wearing',
  'to wear',
  'that',
  'in',
  'with',
  'only',
  'their',
  'any',
  'a',
  'an',
  'the',
  'some',
  'to',
  'and',
  'of',
  'for',
  'is',
  'are',
];

const String _edgeChars = ' ,;:.–—-';

String _trimEdges(String s) {
  var start = 0;
  var end = s.length;
  while (start < end && _edgeChars.contains(s[start])) {
    start += 1;
  }
  while (end > start && _edgeChars.contains(s[end - 1])) {
    end -= 1;
  }
  return s.substring(start, end);
}

(int, String)? _findAny(String haystack, List<String> phrases) {
  final low = haystack.toLowerCase();
  for (final p in phrases) {
    final i = low.indexOf(p);
    if (i >= 0) return (i, p);
  }
  return null;
}

String _stripLead(String span) {
  var s = _trimEdges(span);
  var changed = true;
  while (changed) {
    changed = false;
    final low = s.toLowerCase();
    for (final f in _leadFiller) {
      if (low.startsWith('$f ')) {
        s = _trimEdges(s.substring(f.length + 1));
        changed = true;
        break;
      }
    }
  }
  return s;
}

final RegExp _xDay = RegExp(r'\b([A-Z][a-z]+)(\s+[A-Z][a-z]+)?\s+Day\b');

List<(int, String)> xDayHits(String sentence) {
  final hits = <(int, String)>[];
  for (final m in _xDay.allMatches(sentence)) {
    final head = m.group(1)!.toLowerCase();
    if (_dayStopwords.contains(head)) continue;
    if (_festivalDays.contains(m.group(0)!.toLowerCase())) continue;
    hits.add((m.start, m.group(0)!));
  }
  return hits;
}

ItemKind _classifyKind(String span) {
  final low = span.toLowerCase();
  if (_dressCues.any(low.contains)) return ItemKind.dress;
  if (_bringCues.any(low.contains)) return ItemKind.bring;
  if (_attendCues.any(low.contains)) return ItemKind.attend;
  return ItemKind.other;
}

String? _extractLocation(String body) {
  for (final noun in _placeNouns) {
    final rx = RegExp(
      r'\b(?:in|at|near|outside)\s+(?:a\s+|the\s+)?([^.,;\n]*\b' +
          RegExp.escape(noun) +
          r'\b[^.,;\n]*)',
      caseSensitive: false,
    );
    final m = rx.firstMatch(body);
    if (m != null) {
      final span = _stripLead(m.group(1)!);
      if (span.isNotEmpty) return span;
    }
  }
  return null;
}

WhenHint? _extractWhenHint(String body) {
  final low = body.toLowerCase();
  String? bestPhrase;
  WhenHint? best;
  _whenHints.forEach((phrase, hint) {
    if (low.contains(phrase) &&
        (bestPhrase == null || phrase.length > bestPhrase!.length)) {
      bestPhrase = phrase;
      best = hint;
    }
  });
  return best;
}

Proposal? parseSchoolIn(ParseInput input) => const SchoolInPack().parse(input);

class SchoolInPack implements RulePack {
  const SchoolInPack();

  @override
  String get id => schoolInPackId;

  @override
  Proposal? parse(ParseInput input) {
    final body = normalizeBody(input.body);
    final subject = normalizeBody(input.subject);
    final searchText = subject.isEmpty ? body : '$subject\n$body';

    final candidates = extractDateCandidates(searchText, input.headerDate);
    final dated = realDates(candidates);
    final sentences = splitSentences(body);

    final items = <ProposalItem>[];
    final seen = <String>{};

    void push(ItemKind kind, String rawSpan, {String? location}) {
      final span = _trimEdges(rawSpan);
      if (span.isEmpty || span.split(RegExp(r'\s+')).length < 2) return;
      final key = span.toLowerCase();
      if (seen.contains(key)) return;
      if (!isVerbatim(span, body)) return;
      seen.add(key);
      items.add(ProposalItem(kind: kind, textRaw: span, location: location));
    }

    final consumed = <int>{};
    for (var idx = 0; idx < sentences.length; idx++) {
      if (consumed.contains(idx)) continue;
      final s = sentences[idx];

      final directive = _findAny(s.text, _directives);
      final xDay = xDayHits(s.text);
      final opportunity = _findAny(s.text, _opportunity);
      final scarce = _findAny(s.text, _scarcity);

      if (directive != null) {
        final (at, phrase) = directive;
        push(
          _classifyKind(s.text),
          _stripLead(s.text.substring(at + phrase.length)),
        );
        continue;
      }

      if (xDay.isNotEmpty) {
        final startAbs = s.start + xDay.first.$1;
        var endAbs = s.end;
        if (idx + 1 < sentences.length &&
            _findAny(sentences[idx + 1].text, _directives) != null) {
          endAbs = sentences[idx + 1].end;
          consumed.add(idx + 1);
        }
        final span = body.substring(startAbs, endAbs);
        push(_classifyKind(span), span);
        continue;
      }

      if (opportunity != null || scarce != null) {
        var span = s.text;
        if (scarce != null) {
          final (at, phrase) = scarce;
          span = span.substring(at + phrase.length);
        }
        push(ItemKind.offer, _stripLead(span));
      }
    }

    final isDecision = _findAny(body, _opportunity) != null &&
        dated.isEmpty &&
        items.isNotEmpty;

    var finalItems =
        (isDecision && items.length > 1) ? items.sublist(0, 1) : items;

    final loc = _extractLocation(body);
    if (loc != null) {
      finalItems = [
        for (final i in finalItems)
          if (i.kind == ItemKind.offer && i.location == null)
            ProposalItem(kind: i.kind, textRaw: i.textRaw, location: loc)
          else
            i,
      ];
    }

    if (finalItems.isEmpty) {
      if (input.hasAttachments) {
        return Proposal(
          type: ProposalType.undatedAction,
          urgency: _findAny(body, _scarcity) != null
              ? Urgency.actToday
              : Urgency.none,
          from: input.from,
          threadId: input.threadId,
          dateCandidates: candidates.map((c) => c.date).toList(),
          items: const [
            ProposalItem(
              kind: ItemKind.other,
              textRaw: 'Circular attached - open to read',
            ),
          ],
        );
      }
      return null;
    }

    final ProposalType type;
    final DateTime? date;
    if (dated.isNotEmpty) {
      type = ProposalType.datedAction;
      date = dated.first.date;
    } else if (isDecision) {
      type = ProposalType.decision;
      date = null;
    } else {
      type = ProposalType.undatedAction;
      date = null;
    }

    return Proposal(
      type: type,
      date: date,
      allDay: date == null ? null : true,
      location: loc,
      urgency:
          _findAny(body, _scarcity) != null ? Urgency.actToday : Urgency.none,
      whenHint: _extractWhenHint(body),
      from: input.from,
      threadId: input.threadId,
      items: finalItems,
      dateCandidates: candidates.map((c) => c.date).toList(),
    );
  }
}
