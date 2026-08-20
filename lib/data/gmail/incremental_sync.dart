import 'package:missnothing/data/gmail/from_header.dart';
import 'package:missnothing/data/gmail/gmail_readonly.dart';
import 'package:missnothing/data/gmail/mailbox.dart';
import 'package:missnothing/data/gmail/message_record.dart';
import 'package:missnothing/data/gmail/sync_error.dart';
import 'package:missnothing/data/parser/packs/school_in.dart';
import 'package:missnothing/data/parser/proposal.dart';

typedef SchoolParser = Proposal? Function(ParseInput input);

class IncrementalSyncResult {
  const IncrementalSyncResult({
    required this.mode,
    required this.listedIds,
    required this.records,
    required this.parsed,
    required this.notes,
    this.historyId,
    this.failure,
  });

  final SyncMode mode;
  final List<String> listedIds;
  final List<GmailMessageRecord> records;
  final List<AllowlistedCircular> parsed;
  final List<String> notes;
  final String? historyId;
  final SyncException? failure;

  AllowlistedFetch toAllowlistedFetch() {
    return AllowlistedFetch(
      notes: notes,
      listedIds: listedIds,
      records: records,
      hit: parsed.isEmpty ? null : parsed.first,
    );
  }
}

enum SyncMode { incremental, full }

class IncrementalSync {
  IncrementalSync({
    required this.mailbox,
    this.parse = parseSchoolIn,
    this.sleep = _defaultSleep,
    this.maxAttempts = 3,
  });

  final GmailMailbox mailbox;
  final SchoolParser parse;
  final Future<void> Function(Duration duration) sleep;
  final int maxAttempts;

  Future<IncrementalSyncResult> run({
    required Iterable<AllowlistEntry> allowlist,
    String? historyId,
    String query = 'newer_than:30d',
  }) async {
    try {
      if (historyId == null || historyId.isEmpty) {
        return await _full(allowlist, query);
      }
      try {
        return await _incremental(allowlist, historyId);
      } on HistoryStaleException {
        final full = await _full(allowlist, query);
        return IncrementalSyncResult(
          mode: SyncMode.full,
          listedIds: full.listedIds,
          records: full.records,
          parsed: full.parsed,
          notes: [
            'historyId $historyId was stale (404). Fell back to a full resync.',
            ...full.notes,
          ],
          historyId: full.historyId,
        );
      }
    } catch (error) {
      final code = classifySyncFailure(error);
      return IncrementalSyncResult(
        mode: historyId == null ? SyncMode.full : SyncMode.incremental,
        listedIds: const [],
        records: const [],
        parsed: const [],
        notes: [syncErrorCopy(code)],
        historyId: historyId,
        failure: SyncException(code, syncErrorCopy(code), cause: error),
      );
    }
  }

  Future<IncrementalSyncResult> _incremental(
    Iterable<AllowlistEntry> allowlist,
    String historyId,
  ) async {
    final delta = await _retry(() => mailbox.listHistory(historyId));
    final notes = <String>[
      'incremental history ${delta.addedIds.length} added, '
          '${delta.deletedIds.length} deleted',
    ];
    final processed = await _processIds(delta.addedIds, allowlist, notes);
    return IncrementalSyncResult(
      mode: SyncMode.incremental,
      listedIds: delta.addedIds,
      records: processed.records,
      parsed: processed.parsed,
      notes: notes,
      historyId: delta.historyId,
    );
  }

  Future<IncrementalSyncResult> _full(
    Iterable<AllowlistEntry> allowlist,
    String query,
  ) async {
    final recent = await _retry(() => mailbox.listRecent(query: query));
    final ids = recent.ids.map((ref) => ref.id).toList();
    final notes = <String>[
      if (ids.isEmpty)
        'Gmail list returned no messages (Spam/Trash included).'
      else
        'full resync listed ${ids.length} messages',
    ];
    final processed = await _processIds(ids, allowlist, notes);
    return IncrementalSyncResult(
      mode: SyncMode.full,
      listedIds: ids,
      records: processed.records,
      parsed: processed.parsed,
      notes: notes,
      historyId: recent.historyId ?? await mailbox.currentHistoryId(),
    );
  }

  Future<({List<GmailMessageRecord> records, List<AllowlistedCircular> parsed})>
  _processIds(
    List<String> ids,
    Iterable<AllowlistEntry> allowlist,
    List<String> notes,
  ) async {
    final records = <String, GmailMessageRecord>{
      for (final id in ids)
        id: GmailMessageRecord(id: id, parseStatus: GmailParseStatus.listed),
    };
    final parsed = <AllowlistedCircular>[];
    for (final id in ids) {
      try {
        final message = await _retry(() => mailbox.getFull(id));
        final base = records[id]!.copyWith(
          threadId: message.threadId,
          internalDateMs: message.internalDateMs,
          fromRaw: message.from,
          subjectRaw: message.subject,
        );
        if (!matchesAllowlist(message.from, allowlist)) {
          records[id] = base.copyWith(
            parseStatus: GmailParseStatus.fromMismatch,
          );
          notes.add(
            'skip $id: mailbox "${mailboxFromFromHeader(message.from)}" '
            'is not on the allowlist',
          );
          continue;
        }
        if (message.body.trim().isEmpty && !message.hasAttachments) {
          records[id] = base.copyWith(parseStatus: GmailParseStatus.emptyBody);
          notes.add(
            'skip $id: empty body after normalize (${message.subject})',
          );
          continue;
        }
        final proposal = parse(
          ParseInput(
            from: mailboxFromFromHeader(message.from) ?? message.from,
            messageDate: message.internalDateMs == null
                ? DateTime.now()
                : DateTime.fromMillisecondsSinceEpoch(message.internalDateMs!),
            body: message.body,
            subject: message.subject,
            threadId: message.threadId,
            hasAttachments: message.hasAttachments,
          ),
        );
        if (proposal == null) {
          records[id] = base.copyWith(
            parseStatus: GmailParseStatus.nothingFound,
          );
          notes.add(
            'skip $id: parser returned null — nothing-found, not a Gmail miss '
            '(${message.subject})',
          );
          continue;
        }
        records[id] = base.copyWith(
          parseStatus: GmailParseStatus.parsed(_wire(proposal.type)),
        );
        notes.add(
          'used $id type=${proposal.type.name} date=${proposal.date} '
          '(${message.subject})',
        );
        parsed.add(
          AllowlistedCircular(
            id: id,
            from: message.from,
            subject: message.subject,
            messageDate:
                proposal.date ??
                (message.internalDateMs == null
                    ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(
                        message.internalDateMs!,
                      )),
            body: message.body,
            proposal: proposal,
          ),
        );
      } catch (error) {
        records[id] = records[id]!.copyWith(
          parseStatus: GmailParseStatus.fetchError,
        );
        notes.add('skip $id: Gmail fetch failed: $error');
      }
    }
    return (records: records.values.toList(), parsed: parsed);
  }

  Future<T> _retry<T>(Future<T> Function() action) async {
    Object? last;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await action();
      } catch (error) {
        last = error;
        if (error is HistoryStaleException) rethrow;
        final code = classifySyncFailure(error);
        final retryable =
            code == SyncErrorCode.quota ||
            code == SyncErrorCode.offline ||
            code == SyncErrorCode.backend;
        if (!retryable || attempt == maxAttempts - 1) rethrow;
        await sleep(Duration(milliseconds: 200 * (1 << attempt)));
      }
    }
    throw last ?? StateError('Retry loop exited without a result.');
  }
}

String _wire(ProposalType type) {
  return switch (type) {
    ProposalType.datedAction => 'dated_action',
    ProposalType.undatedAction => 'undated_action',
    ProposalType.decision => 'decision',
  };
}

Future<void> _defaultSleep(Duration duration) => Future<void>.delayed(duration);
