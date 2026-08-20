import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import 'skins/dawn_dusk.dart';
import 'app_shell.dart';
import 'screens/event_detail_screen.dart';
import 'screens/incomplete_screen.dart';
import 'screens/kid_mode_screen.dart';
import 'screens/misses_screen.dart';
import 'screens/open_items_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/reconnect_screen.dart';
import 'screens/unlock_screen.dart';
import 'session.dart';

final sessionProvider = Provider<AppSession>((ref) {
  throw StateError('AppSession is provided by MissNothingApp.');
});

class MissNothingApp extends StatefulWidget {
  const MissNothingApp({super.key, this.session});

  final AppSession? session;

  @override
  State<MissNothingApp> createState() => _MissNothingAppState();
}

class _MissNothingAppState extends State<MissNothingApp> {
  late final AppSession _session = widget.session ?? AppSession();
  late final GoRouter _router = _buildRouter(_session);

  @override
  void initState() {
    super.initState();
    _session.addListener(_onSession);
    _session.bootstrap();
  }

  @override
  void dispose() {
    _session.removeListener(_onSession);
    if (widget.session == null) {
      _session.dispose();
    }
    _router.dispose();
    super.dispose();
  }

  void _onSession() {
    final eventId = _session.pendingEventId;
    if (eventId != null && _session.vaultReady) {
      _session.consumePendingEvent();
      _router.go('/event/$eventId');
    }
    _router.refresh();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [sessionProvider.overrideWith((ref) => _session)],
      child: MaterialApp.router(
        title: 'MissNothing',
        theme: buildTheme(tokensForClock(DateTime.now())),
        darkTheme: buildTheme(dusk),
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
    );
  }
}

GoRouter _buildRouter(AppSession session) {
  return GoRouter(
    refreshListenable: session,
    initialLocation: '/home',
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (!session.vaultReady) return loc == '/unlock' ? null : '/unlock';
      if (!session.onboardingDone) {
        return loc == '/onboarding' ? null : '/onboarding';
      }
      if (session.needsReconnect) {
        return loc == '/reconnect' ? null : '/reconnect';
      }
      if (loc == '/unlock' || loc == '/onboarding' || loc == '/reconnect') {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/unlock',
        builder: (context, state) => UnlockScreen(session: session),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(session: session),
      ),
      GoRoute(
        path: '/reconnect',
        builder: (context, state) => ReconnectScreen(session: session),
      ),
      GoRoute(
        path: '/kid',
        builder: (context, state) => KidModeScreen(session: session),
      ),
      GoRoute(
        path: '/misses',
        builder: (context, state) => MissesScreen(session: session),
      ),
      GoRoute(
        path: '/incomplete',
        builder: (context, state) => IncompleteScreen(session: session),
      ),
      GoRoute(
        path: '/open',
        builder: (context, state) => OpenItemsScreen(session: session),
      ),
      GoRoute(
        path: '/event/:id',
        builder: (context, state) => EventDetailScreen(
          session: session,
          eventId: state.pathParameters['id']!,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(session: session, navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => HomeTab(session: session),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/review',
                builder: (context, state) => ReviewTab(session: session),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/agenda',
                builder: (context, state) => AgendaTab(session: session),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => SettingsTab(session: session),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
