import 'package:drift/drift.dart';

import '../db/database.dart';
import '../settings/settings_repository.dart';
import 'day_label.dart';

class EventRecord {
  const EventRecord({required this.event, required this.items});

  final Event event;
  final List<EventItem> items;
}

class EventRepository {
  const EventRepository(this.db);

  final AppDatabase db;

  Future<List<Event>> active() {
    return (db.select(db.events)
          ..where((row) => row.status.equals('active'))
          ..orderBy([(row) => OrderingTerm.asc(row.startsAt)]))
        .get();
  }

  Future<EventRecord?> byId(String id) async {
    final event = await (db.select(
      db.events,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (event == null) return null;
    final items = await (db.select(
      db.eventItems,
    )..where((row) => row.eventId.equals(id))).get();
    items.sort((a, b) => a.position.compareTo(b.position));
    return EventRecord(event: event, items: items);
  }

  Future<List<LedgerRow>> ledger() async {
    final events = await active();
    final out = <LedgerRow>[];
    for (final event in events) {
      if (event.startsAt == null) continue;
      final record = await byId(event.id);
      final headline = record == null || record.items.isEmpty
          ? event.title
          : record.items.first.content;
      out.add(
        LedgerRow(
          event: event,
          headline: headline,
          movedFrom: movedFromCopy(event.notes),
        ),
      );
    }
    return out;
  }

  Future<Event> reschedule({
    required String eventId,
    DateTime? startsAt,
    String? location,
  }) async {
    final record = await byId(eventId);
    if (record == null) {
      throw StateError('Event $eventId is missing');
    }
    final previous = record.event.startsAt;
    String? notes = record.event.notes;
    if (previous != null &&
        startsAt != null &&
        !_sameDay(previous, startsAt)) {
      notes = movedFromNote(previous);
    }
    await (db.update(db.events)..where((row) => row.id.equals(eventId))).write(
      EventsCompanion(
        startsAt: Value(startsAt),
        location: Value(location ?? record.event.location),
        notes: Value(notes),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    return (await (db.select(
      db.events,
    )..where((row) => row.id.equals(eventId))).getSingle());
  }

  Future<void> setNotes(String id, String notes) async {
    await (db.update(db.events)..where((row) => row.id.equals(id))).write(
      EventsCompanion(
        notes: Value(notes),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> markDone(String id) async {
    await (db.update(db.events)..where((row) => row.id.equals(id))).write(
      EventsCompanion(
        status: const Value('done'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<Set<String>> mutedItemIds() async {
    final raw = await SettingsRepository(db).get(SettingKey.nagMutedIds) ?? '';
    return {
      for (final id in raw.split(','))
        if (id.isNotEmpty) id,
    };
  }

  Future<void> setNagMuted(String itemId, {required bool muted}) async {
    final ids = await mutedItemIds();
    if (muted) {
      ids.add(itemId);
    } else {
      ids.remove(itemId);
    }
    await SettingsRepository(db).set(SettingKey.nagMutedIds, ids.join(','));
  }

  Future<List<LayoutSlot>> slotsOn(DateTime day) async {
    final muted = await mutedItemIds();
    final events = await active();
    final out = <LayoutSlot>[];
    for (final event in events) {
      if (!_sameDay(event.startsAt, day)) continue;
      final record = await byId(event.id);
      if (record == null) continue;
      if (record.items.isEmpty) {
        out.add(
          LayoutSlot(
            itemId: event.id,
            eventId: event.id,
            headline: event.title,
            subtitle: event.location ?? '',
            kind: 'other',
            laidOut: false,
            leaveAtHome: false,
            nagMuted: muted.contains(event.id),
          ),
        );
        continue;
      }
      for (final item in record.items) {
        out.add(
          LayoutSlot(
            itemId: item.id,
            eventId: event.id,
            headline: item.content,
            subtitle: item.location ?? event.location ?? '',
            kind: item.kind,
            laidOut: item.completed,
            leaveAtHome: false,
            nagMuted: muted.contains(item.id),
          ),
        );
      }
    }
    return out;
  }

  Future<void> setLaidOut(String itemId, bool laidOut) async {
    await (db.update(db.eventItems)..where((row) => row.id.equals(itemId)))
        .write(EventItemsCompanion(completed: Value(laidOut)));
  }
}

class LayoutSlot {
  const LayoutSlot({
    required this.itemId,
    required this.eventId,
    required this.headline,
    required this.subtitle,
    required this.kind,
    required this.laidOut,
    required this.leaveAtHome,
    this.nagMuted = false,
  });

  final String itemId;
  final String eventId;
  final String headline;
  final String subtitle;
  final String kind;
  final bool laidOut;
  final bool leaveAtHome;
  final bool nagMuted;
}

class LedgerRow {
  const LedgerRow({
    required this.event,
    required this.headline,
    this.movedFrom,
  });

  final Event event;
  final String headline;
  final String? movedFrom;
}

bool _sameDay(DateTime? value, DateTime day) {
  if (value == null) return false;
  final local = value.toLocal();
  return local.year == day.year &&
      local.month == day.month &&
      local.day == day.day;
}
