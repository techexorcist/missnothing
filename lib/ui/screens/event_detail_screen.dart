import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/events/day_label.dart';
import '../../data/events/event_repository.dart';
import '../../data/share/event_share.dart';
import '../../theme/mn_tokens.dart';
import '../session.dart';
import '../text/display_sanitize.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({
    super.key,
    required this.session,
    required this.eventId,
  });

  final AppSession session;
  final String eventId;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  EventRecord? _record;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await widget.session.vault?.use((db) async {
      _record = await EventRepository(db).byId(widget.eventId);
    });
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tokens = MnTokens.of(context);
    final fallback = widget.session.agenda
        .where((event) => event.id == widget.eventId)
        .firstOrNull;
    final event = _record?.event ?? fallback;
    final items = _record?.items ?? const [];
    final headline = items.isEmpty
        ? displayText(event?.title ?? 'School item')
        : itemHeadline(items.first.content);
    final moved = movedFromCopy(event?.notes);
    final share = EventShareText(
      title: headline,
      startsAt: event?.startsAt,
      location: event?.location,
      items: [for (final item in items) item.content],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/agenda');
            }
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.space),
        children: [
          Text(
            'THE ITEM',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              color: tokens.ink2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            headline,
            style: TextStyle(
              fontFamily: tokens.displayFamily,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.05,
              color: tokens.ink,
            ),
          ),
          if (moved != null) ...[
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: tokens.actToday.withValues(alpha: 0.18),
                border: Border.all(color: tokens.line, width: tokens.border),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  moved,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: tokens.ink,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('When'),
            subtitle: Text(
              event?.startsAt == null
                  ? 'No day given'
                  : dayClock(event!.startsAt!, allDay: event.allDay),
            ),
            trailing: const Text('Change'),
            onTap: event == null ? null : () => _pickDay(event.startsAt),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Where'),
            subtitle: Text(
              event?.location == null || event!.location!.isEmpty
                  ? 'No place named'
                  : displayText(event.location!),
            ),
            trailing: const Text('Change'),
            onTap: event == null ? null : () => _pickWhere(event.location),
          ),
          const SizedBox(height: 8),
          Text(
            'WHAT GOES OUT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              color: tokens.ink2,
            ),
          ),
          const SizedBox(height: 8),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '• ${displayText(item.content)}',
                style: TextStyle(fontSize: 16, color: tokens.ink),
              ),
            ),
          if (items.isEmpty)
            Text(
              displayText(event?.title ?? 'Missing event'),
              style: TextStyle(color: tokens.ink2),
            ),
          SizedBox(height: tokens.space),
          FilledButton(
            onPressed: () =>
                SharePlus.instance.share(ShareParams(text: share.asText())),
            child: const Text('Share'),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () =>
                SharePlus.instance.share(ShareParams(text: share.asIcs())),
            child: const Text('Export calendar (ICS)'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: event == null
                ? null
                : () async {
                    await widget.session.markEventDone(event.id);
                    if (context.mounted) context.go('/agenda');
                  },
            child: const Text('Mark done'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDay(DateTime? current) async {
    final now = DateTime.now();
    final initial = current?.toLocal() ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (picked == null) return;
    await widget.session.rescheduleEvent(
      widget.eventId,
      day: DateTime(picked.year, picked.month, picked.day),
    );
    await _load();
  }

  Future<void> _pickWhere(String? current) async {
    final controller = TextEditingController(text: current ?? '');
    final picked = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Where'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Foyer, classroom, gate',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (picked == null || picked.isEmpty) return;
    await widget.session.rescheduleEvent(widget.eventId, location: picked);
    await _load();
  }
}
