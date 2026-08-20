import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';

class KidModeScreen extends StatelessWidget {
  const KidModeScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final lines = session.tomorrowSlots
        .map((slot) => slot.leaveAtHome ? 'No ${slot.headline}' : slot.headline)
        .toList();
    return Scaffold(
      backgroundColor: tokens.undated,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(tokens.space * 1.5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  color: tokens.surface,
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
              const Spacer(),
              Text(
                'TOMORROW AT SCHOOL',
                style: TextStyle(
                  color: tokens.surface,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                lines.isEmpty ? 'Nothing special tomorrow.' : lines.join('\n'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: tokens.displayFamily,
                  fontSize: 32,
                  height: 1.08,
                  fontWeight: FontWeight.w700,
                  color: tokens.surface,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
