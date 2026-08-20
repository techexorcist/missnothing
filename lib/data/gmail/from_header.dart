/// Mailbox from an RFC 5322 From header. Display-name is ignored.
String? mailboxFromFromHeader(String from) {
  final trimmed = from.trim();
  if (trimmed.isEmpty) return null;
  final angle = RegExp(r'<([^<>]+)>').firstMatch(trimmed);
  final raw = angle != null ? angle.group(1)! : trimmed;
  return raw.trim().toLowerCase();
}

bool fromMatchesAllowlist(String fromHeader, String allowlisted) {
  return matchesAllowlist(fromHeader, [AllowlistEntry.mailbox(allowlisted)]);
}

class AllowlistEntry {
  const AllowlistEntry._(this.kind, this.value);

  factory AllowlistEntry.mailbox(String value) =>
      AllowlistEntry._(AllowlistKind.mailbox, value.trim().toLowerCase());

  factory AllowlistEntry.domain(String value) =>
      AllowlistEntry._(AllowlistKind.domain, _normalizeDomain(value));

  final AllowlistKind kind;
  final String value;
}

enum AllowlistKind { mailbox, domain }

bool matchesAllowlist(String fromHeader, Iterable<AllowlistEntry> entries) {
  final mailbox = mailboxFromFromHeader(fromHeader);
  if (mailbox == null || !mailbox.contains('@')) return false;
  final host = mailbox.split('@').last;
  for (final entry in entries) {
    switch (entry.kind) {
      case AllowlistKind.mailbox:
        if (mailbox == entry.value) return true;
      case AllowlistKind.domain:
        if (host == entry.value || host.endsWith('.${entry.value}')) {
          return true;
        }
    }
  }
  return false;
}

String _normalizeDomain(String value) {
  var domain = value.trim().toLowerCase();
  if (domain.startsWith('@')) domain = domain.substring(1);
  if (domain.startsWith('.')) domain = domain.substring(1);
  return domain;
}
