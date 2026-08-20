import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.session});

  final AppSession session;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _allowlist = TextEditingController();

  @override
  void dispose() {
    _allowlist.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final tokens = MnTokens.of(context);
    return ListView(
      padding: EdgeInsets.all(tokens.space),
      children: [
        Text('Accounts', style: Theme.of(context).textTheme.titleMedium),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(session.user?.email ?? 'Not connected'),
          subtitle: Text(
            session.accounts.isEmpty
                ? 'Connect Gmail to watch a mailbox'
                : '${session.accounts.length} mailbox(es) stored on this phone',
          ),
        ),
        FilledButton(
          onPressed: session.actionsOn ? session.connect : null,
          child: const Text('Connect Gmail'),
        ),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: session.actionsOn ? session.sync : null,
          child: const Text('Sync'),
        ),
        const Divider(),
        Text('School sources', style: Theme.of(context).textTheme.titleMedium),
        Text('Default compile-time sender: ${AppConfig.allowlistedFrom}'),
        for (final row in session.allowlist)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(row.value),
            subtitle: Text(row.kind),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => session.removeAllowlistValue(row.id),
            ),
          ),
        TextField(
          controller: _allowlist,
          decoration: const InputDecoration(
            labelText: 'Add mailbox or domain',
            hintText: 'office@school.edu or school.edu',
          ),
          onSubmitted: (value) async {
            await session.addAllowlistValue(value);
            _allowlist.clear();
          },
        ),
        SizedBox(height: tokens.space),
        const Divider(),
        Text('Reminders', style: Theme.of(context).textTheme.titleMedium),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Notification and exact-alarm access'),
          trailing: TextButton(
            onPressed: session.requestPermissions,
            child: const Text('Grant'),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('OEM battery restrictions'),
          subtitle: const Text(
            'Turn off battery optimization so 20:00 and 06:30 alarms survive.',
          ),
          trailing: TextButton(
            onPressed: _openBattery,
            child: const Text('Open'),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('School clocks'),
          subtitle: const Text(
            '20:00 put it out · 06:15 today\'s check · 06:30 need-by',
          ),
          onTap: session.restoreSchoolClocks,
        ),
        const Divider(),
        Text('Privacy', style: Theme.of(context).textTheme.titleMedium),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Delete events and cards'),
          subtitle: const Text('Does not revoke Gmail. This phone only.'),
          onTap: session.wipeLocalData,
        ),
        const Divider(),
        Text('Diagnostics', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          '90 seconds proves the channel works. 5 hours, app swiped from '
          'recents and the phone locked, is the OEM test.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        FilledButton.tonal(
          onPressed: session.scheduleSmokeAlarms,
          child: const Text('Schedule 90s / 5h smoke alarms'),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: EdgeInsets.all(tokens.space),
            child: SelectableText(session.log),
          ),
        ),
        const SizedBox(height: 8),
        Text(session.vaultLabel),
      ],
    );
  }

  Future<void> _openBattery() async {
    try {
      const intent = AndroidIntent(
        action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
      );
      await intent.launch();
    } catch (error) {
      widget.session.setLog('Could not open battery settings: $error');
    }
  }
}
