import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/events/day_label.dart';
import '../../data/events/event_repository.dart';
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
    final rows = session.weekLedger;
    if (rows.isEmpty) {
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
    final grouped = <String, List<LedgerRow>>{};
    for (final row in rows) {
      final key = shortDay(row.event.startsAt!);
      grouped.putIfAbsent(key, () => []).add(row);
    }
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
        const SizedBox(height: 8),
        Text(
          'What is on.',
          style: TextStyle(
            fontFamily: tokens.displayFamily,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: tokens.ink,
          ),
        ),
        if (session.openEvents.isNotEmpty || session.maybeCards.isNotEmpty)
          TextButton(
            onPressed: () => context.push('/open'),
            child: Text(
              '${session.openEvents.length + session.maybeCards.length} open items',
            ),
          ),
        for (final day in grouped.keys) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 16),
            child: Text(
              day.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: tokens.ink2,
              ),
            ),
          ),
          for (final row in grouped[day]!)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: tokens.surface,
                elevation: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: tokens.line,
                      width: tokens.border,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: tokens.line,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      itemHeadline(row.headline),
                      style: TextStyle(
                        fontFamily: tokens.displayFamily,
                        fontWeight: FontWeight.w700,
                        color: tokens.ink,
                      ),
                    ),
                    subtitle: Text(
                      [
                        dayClock(
                          row.event.startsAt!,
                          allDay: row.event.allDay,
                        ),
                        if (row.event.location != null)
                          displayText(row.event.location!),
                      ].join(' · '),
                    ),
                    trailing: row.movedFrom == null
                        ? null
                        : Text(
                            row.movedFrom!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: tokens.actToday,
                            ),
                          ),
                    onTap: () => context.push('/event/${row.event.id}'),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
