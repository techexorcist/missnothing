enum ProposalType { datedAction, undatedAction, decision }

enum ItemKind { dress, bring, attend, offer, other }

enum Urgency { none, actToday }

enum WhenHint {
  dispersal,
  pickup,
  homeTime,
  assembly,
  lunch,
  beforeSchool,
}

class ProposalItem {
  const ProposalItem({
    required this.kind,
    required this.textRaw,
    this.location,
  });

  final ItemKind kind;
  final String textRaw;
  final String? location;
}

class Proposal {
  const Proposal({
    required this.type,
    required this.from,
    required this.items,
    this.date,
    this.allDay,
    this.urgency = Urgency.none,
    this.whenHint,
    this.threadId,
  });

  final ProposalType type;
  /// Civil date `YYYY-MM-DD`, or null for undated/decision.
  final DateTime? date;
  final bool? allDay;
  final Urgency urgency;
  final WhenHint? whenHint;
  final String from;
  final String? threadId;
  final List<ProposalItem> items;
}

class ParseInput {
  const ParseInput({
    required this.from,
    required this.messageDate,
    required this.body,
    this.threadId,
  });

  final String from;
  final DateTime messageDate;
  final String body;
  final String? threadId;
}
