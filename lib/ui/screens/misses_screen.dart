import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';
import '../widgets/empty_state.dart';

class MissesScreen extends StatelessWidget {
  const MissesScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final tokens = MnTokens.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Couldn\'t read')),
          body: session.misses.isEmpty
              ? const EmptyState(
                  icon: Icons.mark_email_unread_outlined,
                  title: 'No misses logged',
                  message:
                      'Allowlisted mail we could not turn into a card appears here. '
                      'The app\'s name is a claim; this screen admits a miss.',
                )
              : ListView(
                  padding: EdgeInsets.all(tokens.space),
                  children: [
                    Text(
                      '${session.couldntRead} EMAILS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                        color: tokens.ink2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We got these.\nCouldn\'t read.',
                      style: TextStyle(
                        fontFamily: tokens.displayFamily,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                        color: tokens.ink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final miss in session.misses)
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
