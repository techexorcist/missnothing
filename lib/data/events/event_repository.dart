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
}
