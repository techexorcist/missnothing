import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/agenda_screen.dart';
import 'screens/home_screen.dart';
import 'screens/review_screen.dart';
import 'screens/settings_screen.dart';
import 'session.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.session,
    required this.navigationShell,
  });

  final AppSession session;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        const titles = ['Tomorrow', 'Sort', 'Term', 'Set'];
        final wide = MediaQuery.sizeOf(context).width >= 840;
        final destinations = [
          const NavigationDestination(
            icon: Icon(Icons.wb_twilight_outlined),
            selectedIcon: Icon(Icons.wb_twilight),
            label: 'Tomorrow',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: session.reviewCount > 0,
              label: Text('${session.reviewCount}'),
              child: const Icon(Icons.style_outlined),
            ),
            selectedIcon: const Icon(Icons.style),
            label: 'Sort',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Term',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Set',
          ),
        ];
        void go(int index) {
          navigationShell.goBranch(index);
          session.refreshFromVault();
        }

        if (wide) {
          return Scaffold(
            body: Row(
              children: [
                Semantics(
                  label: 'Main navigation',
                  child: NavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: go,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      for (final dest in destinations)
                        NavigationRailDestination(
                          icon: dest.icon,
                          selectedIcon: dest.selectedIcon,
                          label: Text(dest.label),
                        ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Column(
                    children: [
                      AppBar(title: Text(titles[navigationShell.currentIndex])),
                      Expanded(child: navigationShell),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: navigationShell.currentIndex == 0
              ? null
              : AppBar(title: Text(titles[navigationShell.currentIndex])),
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: go,
            destinations: destinations,
          ),
        );
      },
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.session});
  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => HomeScreen(session: session),
    );
  }
}

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key, required this.session});
  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => ReviewScreen(session: session),
    );
  }
}

class AgendaTab extends StatelessWidget {
  const AgendaTab({super.key, required this.session});
  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => AgendaScreen(session: session),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key, required this.session});
  final AppSession session;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => SettingsScreen(session: session),
    );
  }
}
