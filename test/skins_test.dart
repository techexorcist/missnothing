import 'package:missnothing/ui/skins/dawn_dusk.dart';
import 'package:test/test.dart';

void main() {
  test('06:15 is dawn and 20:00 is dusk', () {
    expect(tokensForClock(DateTime(2026, 8, 20, 6, 15)), same(dawn));
    expect(tokensForClock(DateTime(2026, 8, 20, 19, 59)), same(dawn));
    expect(tokensForClock(DateTime(2026, 8, 20, 20, 0)), same(dusk));
    expect(tokensForClock(DateTime(2026, 8, 20, 6, 14)), same(dusk));
  });
}
