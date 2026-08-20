import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/db/database.dart';
import '../../data/events/day_label.dart';
import '../../data/events/event_repository.dart';
import '../../data/reminders/alarm_planner.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';

String tomorrowStatement(List<LayoutSlot> slots) {
  if (slots.isEmpty) return 'Nothing to put out.';
  final names = [for (final slot in slots) slot.headline];
  if (names.length == 1) return 'Tomorrow: ${names.single}.';
  if (names.length == 2) return 'Tomorrow: ${names[0]}. And ${names[1]}.';
  return 'Tomorrow: ${names.first}. And ${names.length - 1} more.';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session});

  final AppSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final slots = session.tomorrowSlots;
    final out = slots.where((slot) => slot.laidOut || slot.leaveAtHome).length;
    final child = slots.isEmpty && session.reviewCount == 0
        ? CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      child: _Kettle(
                        color: tokens.lime,
                        ink: tokens.ink,
                        title: 'Nothing\nto put out.',
                        sub: session.lastSyncLabel,
                      ),
                    ),
                    if (session.couldntRead > 0)
                      TextButton(
                        onPressed: () => context.push('/misses'),
                        child: Text(
                          'We got ${session.couldntRead}. Couldn\'t read.',
                          style: TextStyle(
                            color: tokens.ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    if (session.syncIncomplete > 0)
                      TextButton(
                        onPressed: () => context.push('/incomplete'),
                        child: Text(
                          '${session.syncIncomplete} still downloading',
                          style: TextStyle(
                            color: tokens.ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        : ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(tokens.space),
            children: [
              if (slots.isEmpty) ...[
                Text(
                  '${session.reviewCount} LOOSE · FROM SCHOOL',
                  style: _kicker(tokens),
                ),
                const SizedBox(height: 8),
                Text('Where do\nthese go?', style: _display(tokens, 32)),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => context.go('/review'),
                  child: const Text('SORT THEM'),
                ),
              ] else ...[
                Text(
                  'TOMORROW · ${shortDay(tomorrow)}',
                  style: _kicker(tokens),
                ),
                const SizedBox(height: 8),
                Text(tomorrowStatement(slots), style: _display(tokens, 32)),
                const SizedBox(height: 8),
                Text(
                  '$out of ${slots.length} out',
                  style: _kicker(tokens).copyWith(color: tokens.actToday),
                ),
                const SizedBox(height: 16),
                _SlotStack(
                  slots: slots,
                  onToggle: (slot) => session.toggleLaidOut(slot),
                  onStopAsking: (slot) => session.stopAsking(slot),
                ),
                if (session.pendingAlarms.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text('ARMED', style: _kicker(tokens)),
                  const SizedBox(height: 8),
                  for (final alarm in session.pendingAlarms)
                    _AlarmToggle(
                      alarm: alarm,
                      onToggle: () => session.toggleAlarm(alarm),
                    ),
                ],
                if (session.reviewCount > 0)
                  TextButton(
                    onPressed: () => context.go('/review'),
                    child: Text('${session.reviewCount} still to sort'),
                  ),
              ],
              if (session.couldntRead > 0) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.push('/misses'),
                  child: Text(
                    'We got ${session.couldntRead}. Couldn\'t read.',
                    style: TextStyle(
                      color: tokens.actToday,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              if (session.syncIncomplete > 0)
                TextButton(
                  onPressed: () => context.push('/incomplete'),
                  child: Text(
                    '${session.syncIncomplete} still downloading',
                    style: TextStyle(
                      color: tokens.ink2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          );
    return RefreshIndicator(onRefresh: session.refreshFromVault, child: child);
  }
}

class _Kettle extends StatelessWidget {
  const _Kettle({
    required this.color,
    required this.ink,
    required this.title,
    required this.sub,
  });

  final Color color;
  final Color ink;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return ColoredBox(
      color: color,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(tokens.space * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: tokens.displayFamily,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  height: 0.95,
                  color: ink,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                sub.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  fontSize: 12,
                  color: ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlotStack extends StatelessWidget {
  const _SlotStack({
    required this.slots,
    required this.onToggle,
    required this.onStopAsking,
  });

  final List<LayoutSlot> slots;
  final void Function(LayoutSlot slot) onToggle;
  final void Function(LayoutSlot slot) onStopAsking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < slots.length; i++)
          _SlotRow(
            slot: slots[i],
            isLast: i == slots.length - 1,
            onToggle: () => onToggle(slots[i]),
            onStopAsking: slots[i].nagMuted
                ? null
                : () => onStopAsking(slots[i]),
          ),
      ],
    );
  }
}

class _SlotRow extends StatelessWidget {
  const _SlotRow({
    required this.slot,
    required this.isLast,
    required this.onToggle,
    this.onStopAsking,
  });

  final LayoutSlot slot;
  final bool isLast;
  final VoidCallback onToggle;
  final VoidCallback? onStopAsking;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: slot.laidOut ? tokens.surface2 : tokens.canvas,
            border: Border(
              left: BorderSide(color: tokens.line, width: tokens.border),
              right: BorderSide(color: tokens.line, width: tokens.border),
              top: BorderSide(color: tokens.line, width: tokens.border),
              bottom: isLast
                  ? BorderSide(color: tokens.line, width: tokens.border)
                  : BorderSide.none,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            children: [
              Icon(_iconFor(slot.kind), size: 40, color: tokens.brand),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slot.headline,
                      style: TextStyle(
                        fontFamily: tokens.displayFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        color: tokens.ink,
                      ),
                    ),
                    if (slot.subtitle.isNotEmpty || slot.nagMuted)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          slot.nagMuted ? 'Stopped asking' : slot.subtitle,
                          style: TextStyle(fontSize: 11, color: tokens.ink2),
                        ),
                      ),
                    if (onStopAsking != null)
                      TextButton(
                        onPressed: onStopAsking,
                        child: const Text('STOP ASKING'),
                      ),
                  ],
                ),
              ),
              Semantics(
                button: true,
                label: slot.laidOut ? 'Mark not out' : 'Mark laid out',
                child: InkWell(
                  onTap: onToggle,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: slot.laidOut ? tokens.lime : tokens.canvas,
                      border: Border.all(
                        color: tokens.line,
                        width: tokens.border,
                      ),
                    ),
                    child: slot.laidOut
                        ? Icon(Icons.check, size: 16, color: tokens.ink)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (slot.leaveAtHome)
          Positioned(
            right: 44,
            top: 8,
            child: Transform.rotate(
              angle: 0.1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tokens.canvas,
                  border: Border.all(
                    color: tokens.actToday,
                    width: tokens.border,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  child: Text(
                    'LEAVE HOME',
                    style: TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: tokens.actToday,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

IconData _iconFor(String kind) {
  return switch (kind) {
    'dress' => Icons.checkroom,
    'bring' => Icons.inventory_2_outlined,
    'attend' => Icons.event_outlined,
    'offer' => Icons.card_giftcard_outlined,
    _ => Icons.notes,
  };
}

TextStyle _kicker(MnTokens tokens) {
  return TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.4,
    color: tokens.ink2,
  );
}

TextStyle _display(MnTokens tokens, double size) {
  return TextStyle(
    fontFamily: tokens.displayFamily,
    fontSize: size,
    fontWeight: FontWeight.w700,
    height: 1.02,
    letterSpacing: -0.6,
    color: tokens.ink,
  );
}

class _AlarmToggle extends StatelessWidget {
  const _AlarmToggle({required this.alarm, required this.onToggle});

  final AlarmSchedule alarm;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final local = alarm.fireAt.toLocal();
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    final label = switch (alarm.kind) {
      AlarmKind.nightBefore ||
      AlarmKind.briefingEvening => '$hh:$mm Put it out',
      AlarmKind.morningOf => '$hh:$mm Need-by',
      AlarmKind.dueNow => '$hh:$mm Put it out now',
      AlarmKind.briefingMorning => "$hh:$mm Today's check",
      _ => '$hh:$mm ${alarm.kind.replaceAll('_', ' ')}',
    };
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: TextStyle(color: tokens.ink)),
      value: alarm.status == AlarmStatus.scheduled,
      activeThumbColor: tokens.confirmed,
      onChanged: (_) => onToggle(),
    );
  }
}
