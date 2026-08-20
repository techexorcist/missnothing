import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';
import '../widgets/empty_state.dart';

class IncompleteScreen extends StatelessWidget {
  const IncompleteScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final tokens = MnTokens.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Still downloading')),
          body: session.incompletes.isEmpty
              ? const EmptyState(
                  icon: Icons.downloading_outlined,
                  title: 'Nothing waiting',
                  message:
                      'Allowlisted ids we listed but have not fetched yet '
                      'appear here. A silent miss starts as an incomplete.',
                )
              : ListView(
                  padding: EdgeInsets.all(tokens.space),
                  children: [
                    Text(
                      '${session.syncIncomplete} LISTED · NOT FETCHED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                        color: tokens.ink2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We saw these.\nStill downloading.',
                      style: TextStyle(
                        fontFamily: tokens.displayFamily,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                        color: tokens.ink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final miss in session.incompletes)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          displayText(miss.subject ?? miss.id),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(miss.status.replaceAll('_', ' ')),
                      ),
                    TextButton(
                      onPressed: () => context.go('/home'),
                      child: const Text('Back to tomorrow'),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
