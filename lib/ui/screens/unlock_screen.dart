import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../session.dart';

class UnlockScreen extends StatelessWidget {
  const UnlockScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.lock_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: AppTokens.space),
              Text(
                'MissNothing',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'School circulars stay on this phone. Unlock with your '
                'device PIN or biometric to open the alarm vault.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(session.vaultLabel, textAlign: TextAlign.center),
              const SizedBox(height: AppTokens.space),
              FilledButton(
                onPressed: session.busy ? null : session.unlockVaultInteractive,
                child: const Text('Unlock vault'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
