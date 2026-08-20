import 'package:missnothing/data/events/day_label.dart';
import 'package:test/test.dart';

void main() {
  test('short day and moved-from stay a visible flag', () {
    final day = DateTime(2026, 8, 21, 15, 30);
    expect(shortDay(day), 'Fri 21');
    expect(dayClock(day, allDay: true), 'Fri 21');
    expect(dayClock(day, allDay: false), 'Fri 21 · 15:30');
    expect(movedFromNote(day), 'moved from Fri 21');
    expect(movedFromCopy('moved from Fri 21'), 'moved from Fri 21');
    expect(movedFromCopy('just a note'), isNull);
  });
}
