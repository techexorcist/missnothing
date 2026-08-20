import 'package:flutter/material.dart';

import '../../theme/mn_tokens.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return Semantics(
      label: '$title. $message',
      child: Padding(
        padding: EdgeInsets.all(tokens.space * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: tokens.brand),
            SizedBox(height: tokens.space),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: tokens.displayFamily,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: tokens.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: tokens.ink2),
            ),
          ],
        ),
      ),
    );
  }
}
