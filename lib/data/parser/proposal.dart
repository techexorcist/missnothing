enum ProposalType {
  datedAction('dated_action'),
  undatedAction('undated_action'),
  decision('decision');

  const ProposalType(this.wire);
  final String wire;
}

enum ItemKind {
  dress('dress'),
  bring('bring'),
  attend('attend'),
  offer('offer'),
  other('other');

  const ItemKind(this.wire);
  final String wire;
}

enum Urgency {
  none('none'),
  actToday('act_today');

  const Urgency(this.wire);
  final String wire;
}

enum WhenHint {
  dispersal('dispersal'),
  pickup('pickup'),
  homeTime('home_time'),
  assembly('assembly'),
  lunch('lunch'),
  beforeSchool('before_school');

  const WhenHint(this.wire);
  final String wire;
}

class ProposalItem {
  const ProposalItem({
    required this.kind,
    required this.textRaw,
    this.location,
  });

  final ItemKind kind;
  final String textRaw;

  /// Where to go. Locked on the item, not only the card.
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

  static String fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Map<String, Object?> toJson() {
    final json = <String, Object?>{
      'type': type.wire,
      'date': date == null ? null : fmt(date!),
      'urgency': urgency.wire,
      'when_hint': whenHint?.wire,
      'location': location,
      'from': from,
      'thread_id': threadId,
      'items': [
        for (final item in items)
          {
            'kind': item.kind.wire,
            'text_raw': item.textRaw,
            if (item.location != null) 'location': item.location,
          },
      ],
    };
    if (date != null) json['all_day'] = allDay ?? true;
    return json;
  }
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
