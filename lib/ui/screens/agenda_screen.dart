import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/db/database.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';
import '../widgets/empty_state.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final events = session.weekEvents;
    if (events.isEmpty) {
      return Column(
        children: [
          if (session.openEvents.isNotEmpty || session.maybeCards.isNotEmpty)
            TextButton(
              onPressed: () => context.push('/open'),
              child: Text(
                '${session.openEvents.length + session.maybeCards.length} open items',
              ),
            ),
          const Expanded(
            child: EmptyState(
              icon: Icons.calendar_month_outlined,
              title: 'Week is empty',
              message:
                  'Confirmed dated items become a ledger here. A moved date '
                  'is flagged, never silent.',
            ),
          ),
        ],
      );
    }
    final grouped = <String, List<Event>>{};
    for (final event in events) {
      final local = event.startsAt!.toLocal();
      final key = '${local.year}-${local.month.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(event);
    }
    final months = grouped.keys.toList()..sort();
    return ListView(
      padding: EdgeInsets.all(tokens.space),
      children: [
        Text(
          'WEEK',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: tokens.ink2,
          ),
        ),
        if (session.openEvents.isNotEmpty || session.maybeCards.isNotEmpty)
          TextButton(
            onPressed: () => context.push('/open'),
            child: Text(
              '${session.openEvents.length + session.maybeCards.length} open items',
            ),
          ),
        for (final month in months) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Text(month, style: Theme.of(context).textTheme.titleMedium),
          ),
          for (final event in grouped[month]!)
            Card(
              child: ListTile(
                leading: Icon(Icons.event_available, color: tokens.brand),
                title: Text(displayText(event.title)),
                subtitle: Text(
                  [
                    event.startsAt!.toLocal().toString().split(' ').first,
                    if (event.location != null) displayText(event.location!),
                    if (event.notes != null &&
                        event.notes!.toLowerCase().contains('moved'))
                      event.notes!,
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
