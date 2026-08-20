import 'package:flutter/material.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';

class ReconnectScreen extends StatelessWidget {
  const ReconnectScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return Scaffold(
      backgroundColor: tokens.canvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(tokens.space * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.link_off, size: 72, color: tokens.brand),
              SizedBox(height: tokens.space),
              Text(
                'Reconnect Gmail',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: tokens.displayFamily,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: tokens.ink,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Google revoked this phone\'s mail access. Nothing is scheduled '
                'until you reconnect. Only gmail.readonly is requested.',
                textAlign: TextAlign.center,
                style: TextStyle(color: tokens.ink2, height: 1.4),
              ),
              const Spacer(),
              Text(
                session.log,
                textAlign: TextAlign.center,
                style: TextStyle(color: tokens.ink2, fontSize: 12),
              ),
              SizedBox(height: tokens.space),
              FilledButton(
                onPressed: session.busy ? null : session.connect,
                child: const Text('Reconnect Gmail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
