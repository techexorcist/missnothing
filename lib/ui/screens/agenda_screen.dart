import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/db/database.dart';
import '../../theme/app_theme.dart';
import '../session.dart';
import '../widgets/empty_state.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    if (session.agenda.isEmpty) {
      return const EmptyState(
        icon: Icons.calendar_month_outlined,
        title: 'Agenda is empty',
        message:
            'Accepted circulars become independent events here, with their '
            'own reminder times.',
      );
    }
    final grouped = <String, List<Event>>{};
    for (final event in session.agenda) {
      final key = event.startsAt == null
          ? 'Undated'
          : '${event.startsAt!.toLocal().year}-'
                '${event.startsAt!.toLocal().month.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(event);
    }
    final months = grouped.keys.toList()..sort();
    return ListView(
      padding: const EdgeInsets.all(AppTokens.space),
      children: [
        for (final month in months) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Text(month, style: Theme.of(context).textTheme.titleMedium),
          ),
          for (final event in grouped[month]!)
            Card(
              child: ListTile(
                leading: const Icon(Icons.event_available),
                title: Text(event.title),
                subtitle: Text(
                  [
                    if (event.startsAt != null)
                      event.startsAt!.toLocal().toString().split(' ').first,
                    if (event.location != null) event.location!,
                  ].join(' · '),
                ),
                onTap: () => context.push('/event/${event.id}'),
              ),
            ),
        ],
      ],
    );
  }
}
