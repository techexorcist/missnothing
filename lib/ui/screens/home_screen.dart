import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../theme/app_theme.dart';
import '../session.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final email = session.user?.email;
    final now = DateTime.now();
    final today = session.agenda.where(
      (event) => _sameDay(event.startsAt, now),
    );
    final tomorrow = session.agenda.where(
      (event) => _sameDay(event.startsAt, now.add(const Duration(days: 1))),
    );
    return ListView(
      padding: const EdgeInsets.all(AppTokens.space),
      children: [
        Text(
          email == null ? 'Good to see you' : 'Monitoring $email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(session.vaultLabel),
        Text('Allowlist: ${AppConfig.allowlistedFrom}'),
        Text(session.lastSyncLabel),
        const SizedBox(height: AppTokens.space),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatChip(label: 'To review', value: '${session.reviewCount}'),
            _StatChip(label: 'Events', value: '${session.eventCount}'),
            _StatChip(label: 'Today', value: '${today.length}'),
            _StatChip(label: 'Tomorrow', value: '${tomorrow.length}'),
          ],
        ),
        const SizedBox(height: AppTokens.space),
        Semantics(
          button: true,
          label: 'Connect Gmail',
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: session.actionsOn ? session.connect : null,
              child: const Text('Connect Gmail'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          button: true,
          label: 'Sync school mail',
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: session.actionsOn ? session.sync : null,
              child: const Text('Sync'),
            ),
          ),
        ),
        if (session.busy) ...[
          const SizedBox(height: 12),
          const LinearProgressIndicator(),
        ],
        const SizedBox(height: AppTokens.space),
        if (session.reviewCount == 0 && today.isEmpty && tomorrow.isEmpty)
          const EmptyState(
            icon: Icons.wb_sunny_outlined,
            title: 'Nothing for today yet',
            message:
                'Connect Gmail and sync. Review cards will land here before '
                'any reminder is kept.',
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.space),
              child: Text(session.log),
            ),
          ),
      ],
    );
  }
}

bool _sameDay(DateTime? value, DateTime day) {
  if (value == null) return false;
  final local = value.toLocal();
  return local.year == day.year &&
      local.month == day.month &&
      local.day == day.day;
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label · $value'),
      visualDensity: VisualDensity.comfortable,
    );
  }
}
