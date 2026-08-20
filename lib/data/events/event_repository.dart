import 'package:drift/drift.dart';

import '../db/database.dart';

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

  Future<void> markDone(String id) async {
    await (db.update(db.events)..where((row) => row.id.equals(id))).write(
      EventsCompanion(
        status: const Value('done'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<List<LayoutSlot>> slotsOn(DateTime day) async {
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
  });

  final String itemId;
  final String eventId;
  final String headline;
  final String subtitle;
  final String kind;
  final bool laidOut;
  final bool leaveAtHome;
}

bool _sameDay(DateTime? value, DateTime day) {
  if (value == null) return false;
  final local = value.toLocal();
  return local.year == day.year &&
      local.month == day.month &&
      local.day == day.day;
}
