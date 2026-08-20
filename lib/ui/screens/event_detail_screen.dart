import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/events/event_repository.dart';
import '../../data/share/event_share.dart';
import '../../theme/app_theme.dart';
import '../session.dart';

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
    final fallback = widget.session.agenda
        .where((event) => event.id == widget.eventId)
        .firstOrNull;
    final event = _record?.event ?? fallback;
    final share = EventShareText(
      title: event?.title ?? 'School event',
      startsAt: event?.startsAt,
      location: event?.location,
      items: [for (final item in _record?.items ?? const []) item.content],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
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
        padding: const EdgeInsets.all(AppTokens.space),
        children: [
          Text(
            event?.title ?? 'Missing event',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (event?.startsAt != null)
            Text(event!.startsAt!.toLocal().toString()),
          if (event?.location != null) Text(event!.location!),
          const SizedBox(height: AppTokens.space),
          Text('Items', style: Theme.of(context).textTheme.titleMedium),
          for (final item in _record?.items ?? const [])
            Text('• ${item.content}'),
          const SizedBox(height: AppTokens.space),
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
}
