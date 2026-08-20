import 'package:flutter/material.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';

class UnlockScreen extends StatelessWidget {
  const UnlockScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(tokens.space * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.lock_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: tokens.space),
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
              SizedBox(height: tokens.space),
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
