import 'package:drift/drift.dart';

import '../db/database.dart';
import '../events/event_repository.dart';

class GlanceCard {
  const GlanceCard({
    required this.title,
    this.whenLabel,
    required this.privacyHidden,
  });

  final String title;
  final String? whenLabel;
  final bool privacyHidden;
}

class GlanceState {
  const GlanceState(this.db);

  final AppDatabase db;

  Future<GlanceCard> publish({bool? hide}) async {
    final existing = await (db.select(
      db.widgetStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    final privacy = hide ?? existing?.privacyHidden ?? false;
    final upcoming = await EventRepository(db).active();
    final next = upcoming.where((row) => row.startsAt != null).toList();
    next.sort((a, b) => a.startsAt!.compareTo(b.startsAt!));
    final event = next.isEmpty ? null : next.first;
    await db
        .into(db.widgetStates)
        .insertOnConflictUpdate(
          WidgetStatesCompanion.insert(
            id: const Value(1),
            privacyHidden: Value(privacy),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
    if (privacy) {
      return const GlanceCard(title: 'Hidden', privacyHidden: true);
    }
    return GlanceCard(
      title: event?.title ?? 'Nothing upcoming',
      whenLabel: event?.startsAt?.toLocal().toString().split(' ').first,
      privacyHidden: false,
    );
  }
}
