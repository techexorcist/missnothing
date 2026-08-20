import 'dart:convert';
import 'dart:io';

import 'package:missnothing/data/parser/dates.dart';
import 'package:missnothing/data/parser/normalize.dart';
import 'package:missnothing/data/parser/packs/school_in.dart';
import 'package:missnothing/data/parser/proposal.dart';
import 'package:test/test.dart';

/// Three-part scoring: detection and date are safety-critical; span is cosmetic.
class Score {
  int detectionHit = 0;
  int detectionTotal = 0;
  int spanExact = 0;
  int spanTotal = 0;
  bool dateOk = false;

  @override
  String toString() =>
      'detection $detectionHit/$detectionTotal  '
      'date ${dateOk ? "1/1" : "0/1"}  '
      'span $spanExact/$spanTotal';
}

String squash(String s) =>
    s.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();

Map<String, dynamic> loadFixture(String name) {
  return jsonDecode(File('test/fixtures/$name').readAsStringSync())
      as Map<String, dynamic>;
}

Proposal? runPack(Map<String, dynamic> fx) {
  final header = DateTime.parse(fx['message_date'] as String);
  return parseSchoolIn(
    ParseInput(
      body: fx['body'] as String,
      subject: fx['subject'] as String? ?? '',
      messageDate: DateTime(header.year, header.month, header.day),
      from: fx['from'] as String,
      threadId: 'thread-${fx['id']}',
    ),
  );
}

void main() {
  final scores = <String, Score>{};

  tearDownAll(() {
    stdout.writeln('\n--- fixture scores ---');
    scores.forEach((id, s) => stdout.writeln('  $id  $s'));
    stdout.writeln('----------------------\n');
  });

  for (final name in ['gold_01.json', 'gold_02.json']) {
    final fx = loadFixture(name);
    final id = fx['id'] as String;
    final expect_ = fx['expect'] as Map<String, dynamic>;
    final expectedItems = (expect_['items'] as List)
        .cast<Map<String, dynamic>>();
    final score = scores[id] = Score();

    group(id, () {
      late Proposal? p;
      late String normalized;

      setUp(() {
        p = runPack(fx);
        normalized = normalizeBody(fx['body'] as String);
      });

      test('produces a proposal (never nothing-found)', () {
        expect(
          p,
          isNotNull,
          reason: '$id must not fall into "School mail - nothing found"',
        );
      });

      test('type', () {
        expect(p!.type.wire, expect_['type']);
      });

      test('date is the event day, not the letterhead', () {
        final want = expect_['date'] as String?;
        final got = p!.date == null ? null : Proposal.fmt(p!.date!);
        score.dateOk = got == want;
        expect(got, want);
      });

      test('all_day present only when dated', () {
        final json = p!.toJson();
        if (p!.date == null) {
          expect(
            json.containsKey('all_day'),
            isFalse,
            reason: 'all_day is meaningless without a date',
          );
        } else {
          expect(json['all_day'], expect_['all_day'] ?? true);
        }
      });

      test('urgency', () {
        expect(p!.urgency.wire, expect_['urgency']);
      });

      test('when_hint', () {
        expect(p!.whenHint?.wire, expect_['when_hint']);
      });

      test('location is extracted, not hardcoded', () {
        final want = expect_['location'] as String?;
        if (want == null) {
          expect(p!.location, isNull);
        } else {
          expect(squash(p!.location ?? ''), squash(want));
          expect(
            p!.items.any((item) => squash(item.location ?? '') == squash(want)),
            isTrue,
            reason: 'location lives on the offer item',
          );
        }
      });

      test('one item per distinct parent action', () {
        expect(
          p!.items.length,
          expectedItems.length,
          reason: 'items must be distinct actions, not sentence fragments',
        );
      });

      test('detection - every expected action is found [SAFETY CRITICAL]', () {
        score.detectionTotal = expectedItems.length;
        final actual = p!.items.map((i) => squash(i.textRaw)).toList();
        final missing = <String>[];
        for (final want in expectedItems) {
          final needle = squash(want['detect'] as String);
          if (actual.any((a) => a.contains(needle))) {
            score.detectionHit += 1;
          } else {
            missing.add(needle);
          }
        }
        expect(missing, isEmpty, reason: 'undetected actions: $missing');
      });

      test('span - clipped quote matches expectation [cosmetic]', () {
        score.spanTotal = expectedItems.length;
        for (var i = 0; i < expectedItems.length && i < p!.items.length; i++) {
          if (squash(p!.items[i].textRaw) ==
              squash(expectedItems[i]['text_raw'] as String)) {
            score.spanExact += 1;
          }
        }
        expect(
          score.spanExact,
          score.spanTotal,
          reason: 'span drift is cosmetic, but record it before accepting',
        );
      });

      test('item kinds', () {
        for (var i = 0; i < expectedItems.length; i++) {
          expect(p!.items[i].kind.wire, expectedItems[i]['kind']);
        }
      });

      test('festival names never become the headline', () {
        for (final item in p!.items) {
          expect(
            squash(item.textRaw).contains('independence day'),
            isFalse,
            reason: 'the item is the headline, never the festival',
          );
        }
      });

      test(
        'every stored span is verbatim from the normalised body [INVARIANT]',
        () {
          for (final item in p!.items) {
            expect(
              isVerbatim(item.textRaw, normalized),
              isTrue,
              reason:
                  'not a substring of the normalised body: "${item.textRaw}"',
            );
          }
          if (p!.location != null) {
            expect(isVerbatim(p!.location!, normalized), isTrue);
          }
        },
      );

      test('reference numbers are masked before date parsing', () {
        final masked = maskReferences(normalized);
        for (final token in (fx['must_reject'] as List).cast<String>()) {
          expect(
            masked.contains(token),
            isFalse,
            reason: '"$token" must never be visible to the date parser',
          );
        }
      });

      test('date candidates are exactly as expected', () {
        final got = p!.dateCandidates.map(Proposal.fmt).toList()..sort();
        final want = (fx['date_candidates'] as List).cast<String>().toList()
          ..sort();
        expect(got, want);
      });

      test('emoji and multibyte content survive intact', () {
        for (final item in p!.items) {
          expect(item.textRaw.runes.every((r) => r != 0xFFFD), isTrue);
        }
      });

      if (fx['must_keep_typo'] != null) {
        test('school typos stay in the body and are not cues', () {
          final typo = fx['must_keep_typo'] as String;
          expect(fx['body'] as String, contains(typo));
          expect(
            p!.items.any((item) => item.textRaw.toLowerCase().contains(typo)),
            isFalse,
            reason: 'the typo must not be the extracted action',
          );
        });
      }
    });
  }

  group('generic guards', () {
    test('normalizeBody collapses nbsp and empty paragraphs', () {
      final out = normalizeBody('<p>A&nbsp;&nbsp;B</p><p>&nbsp;</p><p>C</p>');
      expect(out.contains('&nbsp;'), isFalse);
      expect(RegExp(r'\n{2,}').hasMatch(out), isFalse);
      expect(out.contains('A B'), isTrue);
    });

    test('X Day fires on unseen day names but not on "the day"', () {
      expect(xDayHits('Friday is a Pyjama Day for all.').isNotEmpty, isTrue);
      expect(xDayHits('Please note the Day scholars list.').isEmpty, isTrue);
    });

    test('festival days are context, never the action', () {
      expect(
        xDayHits('Independence Day celebrations begin at nine.').isEmpty,
        isTrue,
      );
    });

    test('half / working / first day are not minted as X Day', () {
      expect(xDayHits('Tomorrow is a half day.').isEmpty, isTrue);
      expect(xDayHits('Friday is a working day.').isEmpty, isTrue);
      expect(xDayHits('This is the first day of term.').isEmpty, isTrue);
      expect(xDayHits('The last day of school is Friday.').isEmpty, isTrue);
      expect(xDayHits('Each day begins with assembly.').isEmpty, isTrue);
      expect(xDayHits('The other day we sent a note.').isEmpty, isTrue);
      expect(xDayHits('A full day programme follows.').isEmpty, isTrue);
    });

    test('relative dates resolve against the header, not the device clock', () {
      final header = DateTime(2026, 8, 17);
      final c = extractDateCandidates('Colour dress tomorrow, please.', header);
      expect(c.map((e) => Proposal.fmt(e.date)), contains('2026-08-18'));
    });

    test('today and this Friday resolve against the Date header', () {
      final header = DateTime(2026, 8, 17); // Monday
      final c = extractDateCandidates(
        'Sports today. Assembly this Friday.',
        header,
      );
      expect(c.map((e) => Proposal.fmt(e.date)), contains('2026-08-17'));
      expect(c.map((e) => Proposal.fmt(e.date)), contains('2026-08-21'));
    });

    test('a month-day before the header rolls into next year', () {
      final header = DateTime(2026, 12, 20);
      final c = extractDateCandidates('Reopening on 5 January.', header);
      expect(c.map((e) => Proposal.fmt(e.date)), contains('2027-01-05'));
    });

    test('month-first dates parse', () {
      final header = DateTime(2026, 8, 15);
      final c = extractDateCandidates('Colour dress on August 19.', header);
      expect(c.map((e) => Proposal.fmt(e.date)), contains('2026-08-19'));
    });

    test('31 February is not normalised into March', () {
      final header = DateTime(2026, 8, 15);
      final c = extractDateCandidates('Picnic on 31 February 2026.', header);
      expect(c.map((e) => Proposal.fmt(e.date)), isNot(contains('2026-03-03')));
      expect(c.map((e) => Proposal.fmt(e.date)), isNot(contains('2026-02-31')));
    });

    test('pickEventDate takes the earliest real date, not document order', () {
      final header = DateTime(2026, 8, 10);
      final c = extractDateCandidates(
        'PTM on 20 August. Colour dress on 19 August.',
        header,
      );
      expect(Proposal.fmt(pickEventDate(c)!), '2026-08-19');
    });

    test('academic year and ref numbers never become dates', () {
      final header = DateTime(2026, 8, 15);
      final c = extractDateCandidates(
        'Cir No:34/MONT/2026-27 dated 15 August 2026',
        header,
      );
      expect(c.length, 1);
      expect(Proposal.fmt(c.single.date), '2026-08-15');
      expect(c.single.isIssueDate, isTrue);
    });

    test('unparseable allowlisted mail returns null, not a guess', () {
      final p = parseSchoolIn(
        ParseInput(
          from: 'school@example.com',
          body: 'Dear Parents, thank you for your continued support.',
          messageDate: DateTime(2026, 8, 15),
        ),
      );
      expect(p, isNull, reason: 'a true miss must surface in nothing-found');
    });

    test(
      'empty body with an attachment becomes a stub, never a silent drop',
      () {
        final p = parseSchoolIn(
          ParseInput(
            from: 'school@example.com',
            body: 'Dear Parents,',
            messageDate: DateTime(2026, 8, 15),
            hasAttachments: true,
          ),
        );
        expect(p, isNotNull);
        expect(p!.items.single.textRaw, contains('Circular attached'));
      },
    );
  });
}
