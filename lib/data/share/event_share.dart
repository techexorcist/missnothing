class EventShareText {
  const EventShareText({
    required this.title,
    this.startsAt,
    this.location,
    this.items = const [],
  });

  final String title;
  final DateTime? startsAt;
  final String? location;
  final List<String> items;

  String asText() {
    final lines = <String>[title];
    if (startsAt != null) lines.add(startsAt!.toLocal().toString());
    if (location != null && location!.isNotEmpty) lines.add(location!);
    lines.addAll(items);
    return lines.join('\n');
  }

  String asIcs() {
    final stamp = _icsDate(DateTime.now().toUtc());
    final start = startsAt == null
        ? stamp
        : _icsDate(startsAt!.toUtc(), dateOnly: true);
    final desc = items.join('\\n');
    return [
      'BEGIN:VCALENDAR',
      'VERSION:2.0',
      'PRODID:-//MissNothing//EN',
      'BEGIN:VEVENT',
      'UID:$stamp@missnothing',
      'DTSTAMP:$stamp',
      'DTSTART;VALUE=DATE:${start.substring(0, 8)}',
      'SUMMARY:${_escape(title)}',
      if (location != null && location!.isNotEmpty)
        'LOCATION:${_escape(location!)}',
      if (desc.isNotEmpty) 'DESCRIPTION:${_escape(desc)}',
      'END:VEVENT',
      'END:VCALENDAR',
      '',
    ].join('\r\n');
  }

  String _icsDate(DateTime value, {bool dateOnly = false}) {
    final y = value.year.toString().padLeft(4, '0');
    final m = value.month.toString().padLeft(2, '0');
    final d = value.day.toString().padLeft(2, '0');
    if (dateOnly) return '$y$m${d}T000000Z';
    final h = value.hour.toString().padLeft(2, '0');
    final min = value.minute.toString().padLeft(2, '0');
    final s = value.second.toString().padLeft(2, '0');
    return '$y$m${d}T$h$min${s}Z';
  }

  String _escape(String value) {
    return value
        .replaceAll('\\', r'\\')
        .replaceAll(';', r'\;')
        .replaceAll(',', r'\,')
        .replaceAll('\n', r'\n');
  }
}
