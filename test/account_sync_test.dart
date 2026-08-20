import 'package:drift/native.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/gmail/from_header.dart';
import 'package:missnothing/data/gmail/incremental_sync.dart';
import 'package:missnothing/data/gmail/mailbox.dart';
import 'package:missnothing/data/gmail/sync_error.dart';
import 'package:missnothing/data/review/proposal_repository.dart';
import 'package:missnothing/data/sources/source_repository.dart';
import 'package:missnothing/data/sync/account_sync.dart';
import 'package:missnothing/data/sync/sync_cursor_repository.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

import 'support/fake_mailbox.dart';

void main() {
  test('account sync persists cursor, body, and unreviewed proposal', () async {
    final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
    addTearDown(db.close);
    await SourceRepository(db).seedDefault(
      accountId: 'acct_1',
      accountEmail: 'parent@example.com',
      mailbox: 'school@example.com',
    );
    final mailbox = FakeMailbox(
      recent: const RecentMailbox(
        ids: [ListedMessageRef(id: 'm1')],
        historyId: 'H3',
      ),
      messages: {
        'm1': FetchedMessage(
          id: 'm1',
          from: 'School <school@example.com>',
          subject: 'Hat day',
          body: 'Please bring a hat tomorrow.',
          internalDateMs: DateTime.utc(2026, 8, 20).millisecondsSinceEpoch,
        ),
      },
    );

    final first = await AccountSync(db: db, mailbox: mailbox).run(
      accountId: 'acct_1',
      allowlist: [AllowlistEntry.mailbox('school@example.com')],
    );
    expect(first.result.mode, SyncMode.full);
    expect(first.balanced, isTrue);
    expect(first.newItemTexts, isNotEmpty);
    expect(await ProposalRepository(db).unreviewed(), hasLength(1));
    expect((await SyncCursorRepository(db).find('acct_1'))?.historyId, 'H3');

    mailbox.delta = const HistoryDelta(addedIds: [], historyId: 'H4');
    final second = await AccountSync(db: db, mailbox: mailbox).run(
      accountId: 'acct_1',
      allowlist: [AllowlistEntry.mailbox('school@example.com')],
    );
    expect(second.result.mode, SyncMode.incremental);
    expect(second.newItemTexts, isEmpty);
    expect(mailbox.listRecentCalls, 1);
    expect((await SyncCursorRepository(db).find('acct_1'))?.historyId, 'H4');
  });

  test(
    'account sync records classified failures without wiping history',
    () async {
      final db = AppDatabase(NativeDatabase.opened(sqlite3.openInMemory()));
      addTearDown(db.close);
      await SourceRepository(db).seedDefault(
        accountId: 'acct_1',
        accountEmail: 'parent@example.com',
        mailbox: 'school@example.com',
      );
      await SyncCursorRepository(db).recordSuccess(
        accountId: 'acct_1',
        historyId: 'H9',
        full: true,
        at: DateTime.utc(2026, 8, 20),
      );
      final mailbox = FakeMailbox(
        recent: const RecentMailbox(ids: []),
        messages: const {},
        historyError: Exception(
          'invalid_grant: Token has been expired or revoked',
        ),
      );

      final outcome = await AccountSync(db: db, mailbox: mailbox).run(
        accountId: 'acct_1',
        allowlist: [AllowlistEntry.mailbox('school@example.com')],
      );
      expect(outcome.result.failure?.code, SyncErrorCode.revoked);
      final cursor = await SyncCursorRepository(db).find('acct_1');
      expect(cursor?.historyId, 'H9');
      expect(cursor?.lastErrorCode, 'revoked');
    },
  );
}
