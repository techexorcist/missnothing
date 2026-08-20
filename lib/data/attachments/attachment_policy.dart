class AttachmentDecision {
  const AttachmentDecision._({required this.accepted, this.reason});

  const AttachmentDecision.accept() : this._(accepted: true);
  const AttachmentDecision.reject(String reason)
    : this._(accepted: false, reason: reason);

  final bool accepted;
  final String? reason;
}

/// MIME/size gate before any attachment bytes are written to the vault.
class AttachmentPolicy {
  static const maxBytes = 8 * 1024 * 1024;
  static const allowedMimes = {
    'application/pdf',
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/webp',
  };

  static AttachmentDecision decide({
    required String mimeType,
    int? sizeBytes,
    String fileName = '',
  }) {
    final mime = mimeType.trim().toLowerCase();
    if (sizeBytes != null && sizeBytes > maxBytes) {
      return const AttachmentDecision.reject('too_large');
    }
    if (allowedMimes.contains(mime)) {
      return const AttachmentDecision.accept();
    }
    final lower = fileName.toLowerCase();
    if (lower.endsWith('.pdf') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp')) {
      return const AttachmentDecision.accept();
    }
    return const AttachmentDecision.reject('mime');
  }
}
