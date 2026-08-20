import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';
import '../widgets/empty_state.dart';

class OpenItemsScreen extends StatelessWidget {
  const OpenItemsScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final events = session.openEvents;
    final maybes = session.maybeCards;
    if (events.isEmpty && maybes.isEmpty) {
      return const EmptyState(
        icon: Icons.inbox_outlined,
        title: 'Nothing left open',
        message:
            'Undated to-dos and Maybes land here so they cannot hide behind '
            'a date that never existed.',
      );
    }
    return ListView(
      padding: EdgeInsets.all(tokens.space),
      children: [
        Text(
          'OPEN ITEMS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: tokens.ink2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Still in play.',
          style: TextStyle(
            fontFamily: tokens.displayFamily,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: tokens.ink,
          ),
        ),
        const SizedBox(height: 16),
        if (maybes.isNotEmpty) ...[
          Text(
            'MAYBE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: tokens.decision,
            ),
          ),
          for (final card in maybes)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                itemHeadline(
                  card.items.isEmpty
                      ? card.row.subject
                      : card.items.first.textRaw,
                ),
              ),
              subtitle: const Text('Resurfaced from Sort'),
              trailing: TextButton(
                onPressed: () => session.confirmProposal(card),
                child: const Text('PUT OUT'),
              ),
            ),
        ],
        for (final event in events)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.notes, color: tokens.undated),
            title: Text(displayText(event.title)),
            subtitle: event.location == null
                ? const Text('No day given')
                : Text(displayText(event.location!)),
            onTap: () => context.push('/event/${event.id}'),
          ),
      ],
    );
  }
}
