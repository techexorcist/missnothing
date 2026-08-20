import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      grouped.putIfAbsent(_dayKey(row.event.startsAt!), () => []).add(row);
    }
    final keys = grouped.keys.toList();
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
        const SizedBox(height: 16),
        for (var i = 0; i < keys.length; i++)
          _RibbonLine(rows: grouped[keys[i]]!, isLast: i == keys.length - 1),
      ],
    );
  }
}

class _RibbonLine extends StatelessWidget {
  const _RibbonLine({required this.rows, required this.isLast});

  final List<LedgerRow> rows;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final day = rows.first.event.startsAt!.toLocal();
    final today = DateTime.now();
    final isToday =
        day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return Material(
      color: tokens.canvas,
      child: InkWell(
        onTap: rows.length == 1
            ? () => context.push('/event/${rows.single.event.id}')
            : null,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: tokens.line, width: tokens.border),
              right: BorderSide(color: tokens.line, width: tokens.border),
              top: BorderSide(color: tokens.line, width: tokens.border),
              bottom: isLast
                  ? BorderSide(color: tokens.line, width: tokens.border)
                  : BorderSide.none,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 52,
                  color: isToday ? tokens.actToday : tokens.surface2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekdays[day.weekday - 1],
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          color: isToday ? tokens.canvas : tokens.ink2,
                        ),
                      ),
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          fontFamily: tokens.displayFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          color: isToday ? tokens.canvas : tokens.ink,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: tokens.border, color: tokens.line),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(11, 9, 11, 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final row in rows)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: GestureDetector(
                              onTap: () =>
                                  context.push('/event/${row.event.id}'),
                              child: Text(
                                itemHeadline(row.headline),
                                style: TextStyle(
                                  fontFamily: tokens.displayFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  color: tokens.ink,
                                ),
                              ),
                            ),
                          ),
                        if (rows.any((row) => row.movedFrom != null))
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              rows
                                  .map((row) => row.movedFrom)
                                  .whereType<String>()
                                  .first,
                              style: TextStyle(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: tokens.actToday,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _dayKey(DateTime value) {
  final local = value.toLocal();
  return '${local.year}-${local.month}-${local.day}';
}
