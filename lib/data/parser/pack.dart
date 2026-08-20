import 'proposal.dart';

abstract class RulePack {
  String get id;

  /// Null means a true miss: no dated, undated or decision extract.
  Proposal? parse(ParseInput input);
}

class PackRegistry {
  PackRegistry(Iterable<RulePack> packs)
      : _byId = {for (final p in packs) p.id: p};

  final Map<String, RulePack> _byId;

  RulePack? operator [](String id) => _byId[id];

  Iterable<String> get ids => _byId.keys;
}
