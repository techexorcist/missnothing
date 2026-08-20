import 'dart:convert';
import 'dart:typed_data';

import 'package:missnothing/data/ai/proposal_validator.dart';
import 'package:missnothing/data/attachments/attachment_policy.dart';
import 'package:missnothing/data/attachments/pdf_text.dart';
import 'package:missnothing/data/share/event_share.dart';
import 'package:test/test.dart';

void main() {
  test('attachment policy accepts pdf and images under the size cap', () {
    expect(
      AttachmentPolicy.decide(
        mimeType: 'application/pdf',
        sizeBytes: 1024,
        fileName: 'note.pdf',
      ).accepted,
      isTrue,
    );
    expect(
      AttachmentPolicy.decide(
        mimeType: 'application/zip',
        sizeBytes: 10,
        fileName: 'x.zip',
      ).reason,
      'mime',
    );
    expect(
      AttachmentPolicy.decide(
        mimeType: 'image/png',
        sizeBytes: AttachmentPolicy.maxBytes + 1,
      ).reason,
      'too_large',
    );
  });

  test('pdf extract pulls printable strings and rejects non-pdf', () {
    expect(PdfTextExtract.extract(Uint8List.fromList([1, 2, 3])), isNull);
    final pdf = Uint8List.fromList(
      utf8.encode('%PDF-1.4\n(BT Bring a hat please) ET\n'),
    );
    expect(PdfTextExtract.extract(pdf), contains('Bring a hat'));
  });

  test('model JSON is rejected unless evidence is verbatim', () {
    const body = 'Please bring a hat to school tomorrow.';
    expect(
      ProposalValidator.parse(
        jsonEncode({
          'type': 'dated_action',
          'items': ['bring a hat'],
          'evidence': 'Please bring a hat',
        }),
        sourceBody: body,
      ),
      isNotNull,
    );
    expect(
      ProposalValidator.parse(
        jsonEncode({
          'type': 'dated_action',
          'items': ['bring a hat'],
          'evidence': 'invented quote',
        }),
        sourceBody: body,
      ),
      isNull,
    );
  });

  test('event share emits ICS text', () {
    final share = EventShareText(
      title: 'Hat day',
      startsAt: DateTime.utc(2026, 8, 22),
      location: 'Field',
      items: const ['Bring a hat'],
    );
    expect(share.asText(), contains('Hat day'));
    expect(share.asIcs(), contains('BEGIN:VEVENT'));
    expect(share.asIcs(), contains('Hat day'));
  });
}
