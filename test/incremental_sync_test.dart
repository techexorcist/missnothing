import 'package:missnothing/data/gmail/from_header.dart';
import 'package:missnothing/data/gmail/incremental_sync.dart';
import 'package:missnothing/data/gmail/mailbox.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:missnothing/data/gmail/sync_error.dart';
import 'package:missnothing/data/parser/proposal.dart';
import 'package:test/test.dart';

import 'support/fake_mailbox.dart';

Proposal? _dated(ParseInput input) {
  if (input.body.contains('bring')) {
    return Proposal(
      type: ProposalType.datedAction,
      from: input.from,
      date: DateTime.utc(2026, 8, 21),
      items: const [ProposalItem(kind: ItemKind.bring, textRaw: 'bring a hat')],
    );
  }
  return null;
}

DateTime _now() => DateTime.utc(2026, 8, 20);

IncrementalSync _sync(FakeMailbox mailbox, {SchoolParser parse = _dated}) {
  return IncrementalSync(
    mailbox: mailbox,
    parse: parse,
    sleep: (_) async {},
    clock: _now,
  );
}

void main() {
  final allow = [AllowlistEntry.mailbox('school@example.com')];
  final schoolMail = FetchedMessage(
    id: 'm1',
    from: 'School <school@example.com>',
    subject: 'Hat day',
    body: 'Please bring a hat tomorrow.',
    internalDateMs: DateTime.utc(2026, 8, 20).millisecondsSinceEpoch,
  );

  test(
    'full sync records every listed ID and parses allowlisted mail',
    () async {
      final mailbox = FakeMailbox(
        recent: const RecentMailbox(
          ids: [
            ListedMessageRef(id: 'm1'),
            ListedMessageRef(id: 'm2'),
          ],
          historyId: 'H9',
        ),
        messages: {
          'm1': schoolMail,
          'm2': const FetchedMessage(
            id: 'm2',
            from: 'attacker@evil.com',
            subject: 'spoof',
            body: 'bring nothing',
          ),
        },
      );
      final result = await _sync(mailbox).run(allowlist: allow);

      expect(result.mode, SyncMode.full);
      expect(result.listedIds, ['m1', 'm2']);
      expect(result.parsed.single.id, 'm1');
      expect(
        result.records.firstWhere((r) => r.id == 'm2').parseStatus,
        GmailParseStatus.fromMismatch,
      );
      expect(mailbox.getMetadataCalls, 2);
      expect(mailbox.getFullCalls, 1, reason: 'spoof never fetches a body');
      expect(result.historyId, 'H9');
    },
  );

  test('stale historyId falls back to a full resync', () async {
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(
        ids: [ListedMessageRef(id: 'm1')],
        historyId: 'H20',
      ),
      messages: {'m1': schoolMail},
      historyError: const HistoryStaleException('H1'),
    );
    final result = await _sync(mailbox).run(allowlist: allow, historyId: 'H1');

    expect(result.mode, SyncMode.full);
    expect(mailbox.listHistoryCalls, 1);
    expect(mailbox.listRecentCalls, 1);
    expect(result.notes.first, contains('stale'));
    expect(result.parsed, isNotEmpty);
  });

  test('incremental mode only processes history additions', () async {
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(ids: [ListedMessageRef(id: 'old')]),
      messages: {'m1': schoolMail},
      delta: const HistoryDelta(addedIds: ['m1'], historyId: 'H5'),
    );
    final result = await _sync(mailbox).run(allowlist: allow, historyId: 'H4');

    expect(result.mode, SyncMode.incremental);
    expect(mailbox.listRecentCalls, 0);
    expect(result.listedIds, ['m1']);
    expect(result.historyId, 'H5');
  });

  test('quota errors are retried then classified', () async {
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(ids: []),
      messages: const {},
      listFailures: 1,
    );
    final result = await _sync(mailbox).run(allowlist: allow);

    expect(mailbox.listRecentCalls, 2);
    expect(result.failure, isNull);
    expect(result.listedIds, isEmpty);
  });

  test('revoked tokens become an actionable sync failure', () {
    expect(
      classifySyncFailure(
        Exception('invalid_grant: Token has been expired or revoked'),
      ),
      SyncErrorCode.revoked,
    );
    expect(syncErrorCopy(SyncErrorCode.revoked), contains('Reconnect'));
  });

  test('past dated events are recorded but not proposed', () async {
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(ids: [ListedMessageRef(id: 'm1')]),
      messages: {'m1': schoolMail},
    );
    final result = await _sync(
      mailbox,
      parse: (input) => Proposal(
        type: ProposalType.datedAction,
        from: input.from,
        date: DateTime.utc(2026, 7, 1),
        items: const [
          ProposalItem(kind: ItemKind.dress, textRaw: 'colour dress'),
        ],
      ),
    ).run(allowlist: allow);

    expect(result.parsed, isEmpty);
    expect(
      result.records.single.parseStatus,
      GmailParseStatus.parsed('dated_action'),
    );
    expect(result.notes.join('\n'), contains('past event'));
  });

  test('undated cards on old mail are not proposed', () async {
    final old = DateTime.utc(2026, 7, 1).millisecondsSinceEpoch;
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(ids: [ListedMessageRef(id: 'm1')]),
      messages: {
        'm1': FetchedMessage(
          id: 'm1',
          from: 'School <school@example.com>',
          subject: 'Sweaters',
          body: 'give away sweaters',
          internalDateMs: old,
        ),
      },
    );
    final result = await _sync(
      mailbox,
      parse: (input) => Proposal(
        type: ProposalType.decision,
        from: input.from,
        items: const [
          ProposalItem(kind: ItemKind.offer, textRaw: 'give away sweaters'),
        ],
      ),
    ).run(allowlist: allow);

    expect(result.parsed, isEmpty);
    expect(
      result.records.single.parseStatus,
      GmailParseStatus.parsed('decision'),
    );
  });
}
