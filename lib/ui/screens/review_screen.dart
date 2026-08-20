import 'package:flutter/material.dart';

import '../../data/review/proposal_repository.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';
import '../widgets/empty_state.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    if (session.inbox.isEmpty) {
      return Column(
        children: [
          if (session.lastUndoProposalId != null)
            TextButton(
              onPressed: session.undoSkip,
              child: const Text('Undo last bin'),
            ),
          const Expanded(
            child: EmptyState(
              icon: Icons.style_outlined,
              title: 'Nothing loose',
              message:
                  'Parsed circulars land here as objects to put out, leave '
                  'for later, or bin. Nothing is scheduled until you place it.',
            ),
          ),
        ],
      );
    }
    return ListView(
      padding: EdgeInsets.all(tokens.space),
      children: [
        Text(
          '${session.inbox.length} LOOSE · FROM SCHOOL',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            color: tokens.ink2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Where do\nthese go?',
          style: TextStyle(
            fontFamily: tokens.displayFamily,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.05,
            color: tokens.ink,
          ),
        ),
        const SizedBox(height: 16),
        for (final card in session.inbox)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Dismissible(
              key: ValueKey(card.row.id),
              background: _swipeFill(
                tokens.lime,
                'PUT OUT',
                Alignment.centerLeft,
              ),
              secondaryBackground: _swipeFill(
                tokens.surface2,
                'BIN',
                Alignment.centerRight,
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  await session.confirmProposal(card);
                } else {
                  await session.skipProposal(card);
                }
                return false;
              },
              child: _ReviewCard(session: session, card: card),
            ),
          ),
      ],
    );
  }

  Widget _swipeFill(Color color, String label, Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: color,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.session, required this.card});

  final AppSession session;
  final ProposalRecord card;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final date = card.row.proposedDate;
    final headline = card.items.isEmpty
        ? displayText(card.row.subject)
        : itemHeadline(card.items.first.textRaw);
    final typeWord = switch (card.row.type) {
      'undated_action' => 'NO DAY GIVEN',
      'decision' => 'INTERESTED?',
      _ => date == null ? 'ON A DAY' : 'ON A DAY · ${date.toLocal().day}',
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.surface,
        border: Border.all(color: tokens.line, width: tokens.border),
        boxShadow: [BoxShadow(color: tokens.line, offset: const Offset(5, 5))],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5, color: tokens.typeAccent(card.row.type)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(tokens.space),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeWord,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                        color: tokens.typeAccent(card.row.type),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      headline,
                      style: TextStyle(
                        fontFamily: tokens.displayFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: tokens.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final item in card.items)
                      Text(
                        '• ${displayText(item.textRaw)}',
                        style: TextStyle(fontSize: 13, color: tokens.ink2),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      displayText(card.row.fromRaw),
                      style: TextStyle(fontSize: 10, color: tokens.ink3),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => session.skipProposal(card),
                            child: Text(
                              card.row.type == 'decision' ? 'NO' : 'BIN',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => session.maybeProposal(card),
                            child: Text(
                              card.row.type == 'decision' ? 'MAYBE' : 'LATER',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => session.confirmProposal(card),
                            child: Text(
                              card.row.type == 'decision' ? 'YES' : 'PUT OUT',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
