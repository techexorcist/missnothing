import 'dart:convert';
import 'dart:io';

import 'package:missnothing/data/parser/dates.dart';
import 'package:missnothing/data/parser/html_normalize.dart';
import 'package:missnothing/data/parser/packs/school_in.dart';
import 'package:missnothing/data/parser/proposal.dart';
import 'package:test/test.dart';

void main() {
  late String gold01Body;
  late String gold02Body;

  setUpAll(() {
    gold01Body = File('test/fixtures/gold_01_body.txt').readAsStringSync();
    gold02Body = File('test/fixtures/gold_02_body.txt').readAsStringSync();
  });

  Map<String, dynamic> fixture(String name) {
    return jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;
  }

  group('gold-01 dated_action', () {
    test('detection / date / not Cir No or issue day', () {
      final spec = fixture('gold_01.json');
      final parsed = parseSchoolIn(
        ParseInput(
          from: spec['from'] as String,
          messageDate: DateTime.parse(spec['message_date'] as String),
          body: gold01Body,
        ),
      );
      expect(parsed, isNotNull, reason: 'detection: pack returned nothing');
      expect(parsed!.type, ProposalType.datedAction);
      expect(_ymd(parsed.date), spec['expect']['date']);
      expect(parsed.allDay, isTrue);

      final kinds = parsed.items.map((i) => i.kind).toSet();
      expect(kinds.contains(ItemKind.dress), isTrue, reason: 'detection: dress');
      expect(kinds.contains(ItemKind.bring), isTrue,
          reason: 'detection: bagless/bring');
      expect(parsed.items.length, 2);

      for (final item in parsed.items) {
        expect(
          isSubstringOfRaw(item.textRaw, gold01Body),
          isTrue,
          reason: 'span must be a substring of the raw body: ${item.textRaw}',
        );
      }

      final dates = enumerateDates(
        gold01Body,
        DateTime.parse(spec['message_date'] as String),
      );
      expect(dates.any((c) => _ymd(c.date) == '2026-08-19'), isTrue);
      expect(_ymd(pickEventDate(dates)), '2026-08-19');
      expect(looksLikeCirRef('34/MONT/2026-27'), isTrue);
    });
  });

  group('gold-02 decision', () {
    test('date null, act_today, location, not nothing-found, not 29 Jul', () {
      final spec = fixture('gold_02.json');
      final parsed = parseSchoolIn(
        ParseInput(
          from: spec['from'] as String,
          messageDate: DateTime.parse(spec['message_date'] as String),
          body: gold02Body,
        ),
      );
      expect(parsed, isNotNull,
          reason: 'must not dump gold-02 into nothing-found');
      expect(parsed!.type, ProposalType.decision);
      expect(parsed.date, isNull);
      expect(parsed.allDay, isNull);
      expect(parsed.urgency, Urgency.actToday);
      expect(parsed.whenHint, WhenHint.dispersal);
      expect(parsed.items.length, 1);
      expect(parsed.items.first.kind, ItemKind.offer);
      expect(parsed.items.first.location, 'carton box at the center foyer');
      expect(isSubstringOfRaw(parsed.items.first.textRaw, gold02Body), isTrue);
      expect(
        isSubstringOfRaw(parsed.items.first.location!, gold02Body),
        isTrue,
      );
      expect(gold02Body.contains('swears'), isTrue);
    });
  });
}

String? _ymd(DateTime? d) {
  if (d == null) return null;
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '${d.year}-$m-$day';
}
