import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import '../../config/app_config.dart';
import '../../data/settings/settings_repository.dart';
import '../../theme/app_theme.dart';
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
    return ListView(
      padding: const EdgeInsets.all(AppTokens.space),
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
          trailing: TextButton(
            onPressed: session.actionsOn ? session.connect : null,
            child: const Text('Add'),
          ),
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
        const SizedBox(height: AppTokens.space),
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
            'Turn off battery optimization so night-before alarms survive.',
          ),
          trailing: TextButton(
            onPressed: _openBattery,
            child: const Text('Open'),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Night-before hour'),
          subtitle: const Text('20:00 local, stored in settings'),
          onTap: () => session.setAlarmHour(SettingKey.nightBeforeHour, 20),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Morning-of hour'),
          subtitle: const Text('07:00 local, stored in settings'),
          onTap: () => session.setAlarmHour(SettingKey.morningOfHour, 7),
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
        FilledButton.tonal(
          onPressed: session.scheduleSmokeAlarms,
          child: const Text('Schedule 90s / 5h smoke alarms'),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.space),
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
