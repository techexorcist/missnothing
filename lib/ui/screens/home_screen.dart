import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/events/event_repository.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';

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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          '${session.syncIncomplete} still downloading',
                          style: TextStyle(color: tokens.ink),
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
                  'TOMORROW · ${_shortDate(tomorrow)}',
                  style: _kicker(tokens),
                ),
                const SizedBox(height: 8),
                Text('Put it out\ntonight.', style: _display(tokens, 32)),
                const SizedBox(height: 8),
                Text(
                  '$out of ${slots.length} out',
                  style: _kicker(tokens).copyWith(color: tokens.actToday),
                ),
                const SizedBox(height: 16),
                for (final slot in slots)
                  _SlotRow(
                    slot: slot,
                    onToggle: () => session.toggleLaidOut(slot),
                  ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => context.push('/kid'),
                  child: const Text('SHOW THE CHILD'),
                ),
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
                Text(
                  '${session.syncIncomplete} still downloading',
                  style: TextStyle(color: tokens.ink2),
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

class _SlotRow extends StatelessWidget {
  const _SlotRow({required this.slot, required this.onToggle});

  final LayoutSlot slot;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    return Container(
      decoration: BoxDecoration(
        color: slot.laidOut ? tokens.surface2 : tokens.canvas,
        border: Border(
          left: BorderSide(color: tokens.line, width: tokens.border),
          right: BorderSide(color: tokens.line, width: tokens.border),
          top: BorderSide(color: tokens.line, width: tokens.border),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Icon(_iconFor(slot.kind), size: 32, color: tokens.brand),
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
                    color: tokens.ink,
                  ),
                ),
                if (slot.subtitle.isNotEmpty || slot.leaveAtHome)
                  Text(
                    slot.leaveAtHome ? 'Leave it at home' : slot.subtitle,
                    style: TextStyle(fontSize: 11, color: tokens.ink2),
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
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: slot.laidOut ? tokens.lime : tokens.canvas,
                  border: Border.all(color: tokens.line, width: tokens.border),
                ),
                child: slot.laidOut
                    ? Icon(Icons.check, size: 16, color: tokens.ink)
                    : null,
              ),
            ),
          ),
        ],
      ),
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

String _shortDate(DateTime day) {
  const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return '${names[day.weekday - 1]} ${day.day}';
}
