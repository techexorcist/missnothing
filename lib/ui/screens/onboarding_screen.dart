import 'package:flutter/material.dart';

import '../../theme/mn_tokens.dart';
import '../session.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.session});

  final AppSession session;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pages = const [
    (
      icon: Icons.wb_sunny_outlined,
      title: 'Circulars become alarms',
      body:
          'MissNothing reads allowlisted school mail on this phone and turns '
          'it into review cards. Nothing is scheduled until you add it.',
    ),
    (
      icon: Icons.lock_rounded,
      title: 'Mail stays on this phone',
      body:
          'Bodies, attachments, and events live in an encrypted vault on '
          'this phone. There is no server. Nothing leaves the device.',
    ),
    (
      icon: Icons.notifications_active_outlined,
      title: 'You choose the reminders',
      body:
          'Allow the school sender, grant notification and exact-alarm '
          'access, and keep OEM battery restrictions from silencing the night '
          'before hat day.',
    ),
  ];
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final page = _pages[_index];
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
                page.icon,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: tokens.space),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                page.body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () async {
                  if (_index < _pages.length - 1) {
                    setState(() => _index += 1);
                    return;
                  }
                  await widget.session.requestPermissions();
                  await widget.session.completeOnboarding();
                },
                child: Text(
                  _index == _pages.length - 1 ? 'Get started' : 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
