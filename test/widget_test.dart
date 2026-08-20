import 'package:flutter_test/flutter_test.dart';
import 'package:missnothing/main.dart';

void main() {
  testWidgets('skeleton shows connect and sync', (tester) async {
    await tester.pumpWidget(const MissNothingApp());
    await tester.pump();
    expect(find.text('Connect Gmail'), findsOneWidget);
    expect(find.text('Sync'), findsOneWidget);
  });
}
