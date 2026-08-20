/// Date copy for Week, Home, and event detail. Sanitise still happens at render.
const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

String shortDay(DateTime day) {
  final local = day.toLocal();
  return '${_weekdays[local.weekday - 1]} ${local.day}';
}

String dayClock(DateTime day, {required bool allDay}) {
  final local = day.toLocal();
  final date = shortDay(local);
  if (allDay) return date;
  final hh = local.hour.toString().padLeft(2, '0');
  final mm = local.minute.toString().padLeft(2, '0');
  return '$date · $hh:$mm';
}

String movedFromNote(DateTime previous) => 'moved from ${shortDay(previous)}';

String? movedFromCopy(String? notes) {
  if (notes == null) return null;
  final trimmed = notes.trim();
  if (trimmed.toLowerCase().startsWith('moved from ')) return trimmed;
  return null;
}
