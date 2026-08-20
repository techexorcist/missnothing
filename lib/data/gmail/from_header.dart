/// Mailbox from an RFC 5322 From header. Display-name is ignored.
String? mailboxFromFromHeader(String from) {
  final trimmed = from.trim();
  if (trimmed.isEmpty) return null;
  final angle = RegExp(r'<([^<>]+)>').firstMatch(trimmed);
  final raw = angle != null ? angle.group(1)! : trimmed;
  return raw.trim().toLowerCase();
}

bool fromMatchesAllowlist(String fromHeader, String allowlisted) {
  final mailbox = mailboxFromFromHeader(fromHeader);
  if (mailbox == null) return false;
  return mailbox == allowlisted.trim().toLowerCase();
}
