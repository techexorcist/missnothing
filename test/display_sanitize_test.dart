import 'package:missnothing/ui/text/display_sanitize.dart';
import 'package:test/test.dart';

void main() {
  test('display text strips urls, phones and bidi marks', () {
    expect(
      displayText('Call +91 98765 43210 now https://evil.example/x'),
      'Call now',
    );
    expect(displayText('Hat day\u200b'), 'Hat day');
  });

  test('headline is the item, not a circular title', () {
    expect(
      itemHeadline(
        'ethnic outfit in the tricolour theme (saffron, white, or green). More.',
      ),
      startsWith('ethnic outfit'),
    );
  });

  test('bagless copy is recognised', () {
    expect(looksBagless('Bagless Day. Snacks bag only.'), isTrue);
    expect(looksBagless('Bring a hat'), isFalse);
  });
}
