/// Name the items. The circular title never belongs here.
String namedItems(Iterable<String> headlines) {
  final names = [
    for (final raw in headlines)
      if (raw.trim().isNotEmpty) raw.trim(),
  ];
  if (names.isEmpty) return '';
  if (names.length == 1) return names.single;
  if (names.length == 2) return '${names[0]}. And ${names[1]}.';
  return '${names.first}. And ${names.length - 1} more.';
}
