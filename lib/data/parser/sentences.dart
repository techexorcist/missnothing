/// Offset-preserving sentence split.
library;

class Sentence {
  const Sentence(this.start, this.end, this.text);

  final int start;
  final int end;
  final String text;
}

bool _isUpperOrDigit(String c) {
  final code = c.codeUnitAt(0);
  final isUpper = code >= 0x41 && code <= 0x5a;
  final isDigit = code >= 0x30 && code <= 0x39;
  return isUpper || isDigit;
}

List<Sentence> splitSentences(String body) {
  final out = <Sentence>[];
  var start = 0;
  var i = 0;

  void emit(int end) {
    final raw = body.substring(start, end);
    if (raw.trim().isNotEmpty) {
      final leading = raw.length - raw.trimLeft().length;
      final trimmed = raw.trim();
      out.add(
        Sentence(
          start + leading,
          start + leading + trimmed.length,
          trimmed,
        ),
      );
    }
  }

  while (i < body.length) {
    final ch = body[i];

    if (ch == '\n') {
      emit(i);
      i += 1;
      start = i;
      continue;
    }

    if (ch == '.' || ch == '!' || ch == '?') {
      var j = i + 1;
      while (j < body.length && (body[j] == ' ' || body[j] == '\t')) {
        j += 1;
      }
      final boundary = j >= body.length ||
          body[j] == '\n' ||
          (j > i + 1 && _isUpperOrDigit(body[j]));
      if (boundary) {
        emit(i + 1);
        i = j;
        start = i;
        continue;
      }
    }

    i += 1;
  }

  if (start < body.length) emit(body.length);
  return out;
}
