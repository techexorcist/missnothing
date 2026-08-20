import 'dart:convert';

/// On-device model output must be schema-valid JSON whose evidence is a
/// verbatim substring of the source body. Rule-pack results are never deleted.
class ModelProposalDraft {
  const ModelProposalDraft({
    required this.type,
    required this.items,
    required this.evidence,
  });

  final String type;
  final List<String> items;
  final String evidence;
}

class ProposalValidator {
  static const allowedTypes = {'dated_action', 'undated_action', 'decision'};

  static ModelProposalDraft? parse(String raw, {required String sourceBody}) {
    final Object decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (_) {
      return null;
    }
    if (decoded is! Map<String, dynamic>) return null;
    final type = decoded['type']?.toString();
    final evidence = decoded['evidence']?.toString();
    final items = decoded['items'];
    if (type == null || !allowedTypes.contains(type)) return null;
    if (evidence == null || evidence.trim().length < 8) return null;
    if (!sourceBody.contains(evidence)) return null;
    if (items is! List) return null;
    final texts = [
      for (final item in items)
        if (item.toString().trim().isNotEmpty) item.toString().trim(),
    ];
    if (texts.isEmpty) return null;
    return ModelProposalDraft(type: type, items: texts, evidence: evidence);
  }
}
