import 'package:flutter/material.dart';

import '../../data/review/proposal_repository.dart';
import '../../theme/app_theme.dart';
import '../session.dart';
import '../widgets/empty_state.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    if (session.inbox.isEmpty) {
      return Column(
        children: [
          if (session.lastUndoProposalId != null)
            TextButton(
              onPressed: session.undoSkip,
              child: const Text('Undo last skip'),
            ),
          const Expanded(
            child: EmptyState(
              icon: Icons.style_outlined,
              title: 'No cards waiting',
              message:
                  'Parsed circulars appear here as dated actions, undated asks, '
                  'or decisions. Nothing is scheduled until you add it.',
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.space),
      itemCount: session.inbox.length,
      itemBuilder: (context, index) {
        final card = session.inbox[index];
        return Dismissible(
          key: ValueKey(card.row.id),
          background: _swipeFill(
            context,
            Colors.green,
            'Add',
            Alignment.centerLeft,
          ),
          secondaryBackground: _swipeFill(
            context,
            Colors.red.shade400,
            'Skip',
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ReviewCard(session: session, card: card),
          ),
        );
      },
    );
  }

  Widget _swipeFill(
    BuildContext context,
    Color color,
    String label,
    Alignment alignment,
  ) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTokens.radius),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.session, required this.card});

  final AppSession session;
  final ProposalRecord card;

  @override
  Widget build(BuildContext context) {
    final date = card.row.proposedDate;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(card.row.type.replaceAll('_', ' '))),
                Chip(label: Text(card.row.urgency)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              card.row.subject,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (date != null) Text(date.toLocal().toString().split(' ').first),
            if (card.row.location != null) Text(card.row.location!),
            const SizedBox(height: 8),
            for (final item in card.items) Text('• ${item.textRaw}'),
            const SizedBox(height: 8),
            Text(
              card.row.evidence,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppTokens.space),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => session.confirmProposal(card),
                  child: const Text('Add'),
                ),
                FilledButton.tonal(
                  onPressed: () => _edit(context),
                  child: const Text('Edit'),
                ),
                OutlinedButton(
                  onPressed: () => session.maybeProposal(card),
                  child: const Text('Maybe'),
                ),
                TextButton(
                  onPressed: () => session.skipProposal(card),
                  child: const Text('Skip'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: card.row.proposedDate?.toLocal() ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (!context.mounted) return;
    final controller = TextEditingController(text: card.row.location ?? '');
    final location = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    await session.confirmProposal(
      card,
      date: picked ?? card.row.proposedDate,
      location: location ?? card.row.location,
    );
  }
}
