import '../db/database.dart';
import '../db/gmail_message_index.dart';
import '../db/message_body_repository.dart';
import '../gmail/from_header.dart';
import '../gmail/incremental_sync.dart';
import '../gmail/mailbox.dart';
import '../review/proposal_repository.dart';
import 'sync_cursor_repository.dart';

class AccountSyncOutcome {
  const AccountSyncOutcome({required this.result, required this.balanced});

  final IncrementalSyncResult result;
  final bool balanced;
}

class AccountSync {
  AccountSync({
    required this.db,
    required this.mailbox,
    this.bodyRetention = const Duration(days: 14),
  });

  final AppDatabase db;
  final GmailMailbox mailbox;
  final Duration bodyRetention;

  Future<AccountSyncOutcome> run({
    required String accountId,
    required Iterable<AllowlistEntry> allowlist,
  }) async {
    final cursors = SyncCursorRepository(db);
    final cursor = await cursors.find(accountId);
    final sync = IncrementalSync(mailbox: mailbox);
    final result = await sync.run(
      allowlist: allowlist,
      historyId: cursor?.historyId,
    );
    final now = DateTime.now().toUtc();
    if (result.failure != null) {
      await cursors.recordFailure(
        accountId: accountId,
        code: result.failure!.code,
        message: result.failure!.message,
        at: now,
      );
      return AccountSyncOutcome(result: result, balanced: false);
    }

    final index = GmailMessageIndex(db);
    final reconciliation = await index.recordAndReconcile(
      listedIds: result.listedIds,
      records: result.records,
    );
    final bodies = MessageBodyRepository(db);
    final proposals = ProposalRepository(db);
    for (final circular in result.parsed) {
      await bodies.put(
        messageId: circular.id,
        normalizedBody: circular.body,
        fetchedAt: now,
        retention: bodyRetention,
        parserVersion: ProposalRepository.parserVersion,
      );
      await proposals.persistUnreviewed(circular);
    }
    await bodies.pruneExpired(now);
    await cursors.recordSuccess(
      accountId: accountId,
      historyId: result.historyId,
      full: result.mode == SyncMode.full,
      at: now,
    );
    return AccountSyncOutcome(
      result: result,
      balanced: reconciliation.balanced,
    );
  }
}
