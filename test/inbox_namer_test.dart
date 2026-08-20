import 'package:missnothing/data/review/inbox_namer.dart';
import 'package:test/test.dart';

void main() {
  test('names the items, never a circular title', () {
    expect(namedItems(['hat']), 'hat');
    expect(namedItems(['hat', 'no school bag']), 'hat. And no school bag.');
    expect(namedItems(['hat', 'bag', 'form']), 'hat. And 2 more.');
    expect(namedItems(['', '  ']), isEmpty);
  });
}
