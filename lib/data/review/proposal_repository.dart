import 'package:drift/drift.dart';

import '../db/database.dart';
import '../gmail/gmail_readonly.dart';
import '../parser/proposal.dart' as school;

abstract final class ProposalStatus {
  static const unreviewed = 'unreviewed';
  static const confirmed = 'confirmed';
  static const skipped = 'skipped';
  static const maybe = 'maybe';
}

class ProposalRecord {
  const ProposalRecord({required this.row, required this.items});

  final Proposal row;
  final List<ProposalItem> items;
}

/// Persists parser output. Confirmed events are copied out so later body
/// pruning or parser upgrades cannot rewrite user decisions.
class ProposalRepository {
  const ProposalRepository(this.db);

  final AppDatabase db;

  static const parserVersion = 'school_in.v1';

  /// Returns true only the first time this message becomes an unreviewed card.
  Future<bool> persistUnreviewed(AllowlistedCircular circular) async {
    final existing = await byMessage(circular.id);
    if (existing != null &&
        (existing.row.status == ProposalStatus.confirmed ||
            existing.row.status == ProposalStatus.skipped)) {
      return false;
    }
    final isNew = existing == null;

    final now = DateTime.now().toUtc();
    final id = existing?.row.id ?? 'prop_${circular.id}';
    await db.transaction(() async {
      await db
          .into(db.proposals)
          .insertOnConflictUpdate(
            ProposalsCompanion.insert(
              id: id,
              messageId: circular.id,
              type: _wire(circular.proposal.type),
              status: Value(existing?.row.status ?? ProposalStatus.unreviewed),
              proposedDate: Value(circular.proposal.date),
              allDay: Value(circular.proposal.allDay),
              location: Value(circular.proposal.location),
              urgency: Value(circular.proposal.urgency.name),
              whenHint: Value(circular.proposal.whenHint?.name),
              subject: circular.subject,
              fromRaw: circular.from,
              evidence: circular.body,
              parserVersion: parserVersion,
              createdAt: existing?.row.createdAt ?? now,
              updatedAt: now,
            ),
          );
      await (db.delete(
        db.proposalItems,
      )..where((row) => row.proposalId.equals(id))).go();
      for (var i = 0; i < circular.proposal.items.length; i++) {
        final item = circular.proposal.items[i];
        await db
            .into(db.proposalItems)
            .insert(
              ProposalItemsCompanion.insert(
                id: '${id}_$i',
                proposalId: id,
                position: i,
                kind: item.kind.name,
                textRaw: item.textRaw,
                location: Value(item.location),
              ),
            );
      }
    });
    return isNew;
  }

  Future<ProposalRecord?> byMessage(String messageId) async {
    final row = await (db.select(
      db.proposals,
    )..where((p) => p.messageId.equals(messageId))).getSingleOrNull();
    if (row == null) return null;
    final items = await (db.select(
      db.proposalItems,
    )..where((item) => item.proposalId.equals(row.id))).get();
    return ProposalRecord(row: row, items: items);
  }

  Future<List<Proposal>> unreviewed() {
    return (db.select(db.proposals)
          ..where(
            (row) =>
                row.status.equals(ProposalStatus.unreviewed) |
                row.status.equals(ProposalStatus.maybe),
          )
          ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)]))
        .get();
  }

  Future<List<ProposalRecord>> unreviewedRecords() async {
    final rows = await unreviewed();
    final out = <ProposalRecord>[];
    for (final row in rows) {
      final items = await (db.select(
        db.proposalItems,
      )..where((item) => item.proposalId.equals(row.id))).get();
      items.sort((a, b) => a.position.compareTo(b.position));
      out.add(ProposalRecord(row: row, items: items));
    }
    return out;
  }

  Future<ProposalRecord?> byId(String proposalId) async {
    final row = await (db.select(
      db.proposals,
    )..where((p) => p.id.equals(proposalId))).getSingleOrNull();
    if (row == null) return null;
    final items = await (db.select(
      db.proposalItems,
    )..where((item) => item.proposalId.equals(row.id))).get();
    items.sort((a, b) => a.position.compareTo(b.position));
    return ProposalRecord(row: row, items: items);
  }

  Future<void> decide({
    required String proposalId,
    required String status,
    DateTime? editedDate,
    String? editedLocation,
  }) async {
    await (db.update(
      db.proposals,
    )..where((row) => row.id.equals(proposalId))).write(
      ProposalsCompanion(
        status: Value(status),
        proposedDate: Value(editedDate),
        location: Value(editedLocation),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<Event> confirmAsEvent({
    required String proposalId,
    String? title,
    DateTime? startsAt,
    String? location,
    bool? allDay,
  }) async {
    final proposal = await (db.select(
      db.proposals,
    )..where((row) => row.id.equals(proposalId))).getSingle();
    final items = await (db.select(
      db.proposalItems,
    )..where((row) => row.proposalId.equals(proposalId))).get();
    final now = DateTime.now().toUtc();
    final eventId = 'evt_$proposalId';
    await db.transaction(() async {
      await db
          .into(db.events)
          .insertOnConflictUpdate(
            EventsCompanion.insert(
              id: eventId,
              proposalId: Value(proposalId),
              sourceMessageId: Value(proposal.messageId),
              title: title ?? proposal.subject,
              startsAt: Value(startsAt ?? proposal.proposedDate),
              allDay: Value(allDay ?? proposal.allDay ?? true),
              location: Value(location ?? proposal.location),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await (db.delete(
        db.eventItems,
      )..where((row) => row.eventId.equals(eventId))).go();
      for (final item in items) {
        await db
            .into(db.eventItems)
            .insert(
              EventItemsCompanion.insert(
                id: 'ei_${item.id}',
                eventId: eventId,
                position: item.position,
                kind: item.kind,
                content: item.textRaw,
                location: Value(item.location),
              ),
            );
      }
      await (db.update(
        db.proposals,
      )..where((row) => row.id.equals(proposalId))).write(
        ProposalsCompanion(
          status: const Value(ProposalStatus.confirmed),
          updatedAt: Value(now),
        ),
      );
    });
    return (await (db.select(
      db.events,
    )..where((row) => row.id.equals(eventId))).getSingle());
  }
}

String _wire(school.ProposalType type) {
  return switch (type) {
    school.ProposalType.datedAction => 'dated_action',
    school.ProposalType.undatedAction => 'undated_action',
    school.ProposalType.decision => 'decision',
  };
}
