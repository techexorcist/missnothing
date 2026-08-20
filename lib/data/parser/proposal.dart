enum ProposalType { datedAction, undatedAction, decision }

enum ItemKind { dress, bring, attend, offer, other }

enum Urgency { none, actToday }

enum WhenHint { dispersal, pickup, homeTime, assembly, lunch, beforeSchool }

class ProposalItem {
  const ProposalItem({
    required this.kind,
    required this.textRaw,
    this.location,
  });

  final ItemKind kind;
  final String textRaw;

  /// Where to go. Locked on the item, not the card.
  final String? location;
}

class Proposal {
  const Proposal({
    required this.type,
    required this.from,
    required this.items,
    this.date,
    this.allDay,
    this.location,
    this.urgency = Urgency.none,
    this.whenHint,
    this.threadId,
    this.dateCandidates = const [],
  });

  final ProposalType type;
  final DateTime? date;
  final bool? allDay;
  final Urgency urgency;
  final WhenHint? whenHint;
  final String from;
  final String? threadId;
  final List<ProposalItem> items;

  /// Also stored on offer items. Kept here so a card can name a place.
  final String? location;
  final List<DateTime> dateCandidates;
}

class ParseInput {
  const ParseInput({
    required this.from,
    required this.messageDate,
    required this.body,
    this.threadId,
    this.subject = '',
    this.hasAttachments = false,
  });

  final String from;
  final DateTime messageDate;
  DateTime get headerDate => messageDate;
  final String body;
  final String? threadId;
  final String subject;
  final bool hasAttachments;
}
