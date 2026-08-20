import 'package:flutter_test/flutter_test.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/ui/app.dart';
import 'package:missnothing/ui/session.dart';

class TestSession extends AppSession {
  TestSession() {
    vaultReady = true;
    signInReady = true;
    onboardingDone = true;
    vaultLabel = 'Vault skipped (test)';
  }

  @override
  Future<void> bootstrap() async {}
}

void main() {
  testWidgets('tomorrow tab shows kettle when nothing is out', (tester) async {
    await tester.pumpWidget(MissNothingApp(session: TestSession()));
    await tester.pumpAndSettle();
    expect(find.textContaining('Nothing'), findsOneWidget);
    expect(find.text('Tomorrow'), findsWidgets);
    expect(find.text('Sort'), findsWidgets);
  });

  testWidgets('navigation destinations are labeled for TalkBack', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(MissNothingApp(session: TestSession()));
    await tester.pumpAndSettle();
    expect(find.text('Tomorrow'), findsWidgets);
    expect(find.text('Sort'), findsWidgets);
    expect(find.text('Term'), findsWidgets);
    expect(find.text('Set'), findsWidgets);
    handle.dispose();
  });

  testWidgets('home asks to sort when cards arrive', (tester) async {
    final session = TestSession();
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();

    session.reviewCount = 5;
    session.notifyListeners();
    await tester.pump();

    expect(find.textContaining('5 LOOSE'), findsOneWidget);
    expect(find.text('SORT THEM'), findsOneWidget);
    expect(find.text('5'), findsWidgets);
  });

  testWidgets('onboarding starts when the vault is new', (tester) async {
    final session = TestSession()..onboardingDone = false;
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();
    expect(find.text('Circulars become alarms'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Mail stays on this phone'), findsOneWidget);
  });

  testWidgets('home opens misses when allowlisted mail could not be read', (
    tester,
  ) async {
    final session = TestSession()
      ..couldntRead = 1
      ..misses = const [
        GmailMiss(
          id: 'm1',
          status: 'nothing_found',
          subject: 'Sports day circular',
        ),
      ];
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();

    expect(find.textContaining("Couldn't read"), findsOneWidget);
    await tester.tap(find.textContaining("Couldn't read"));
    await tester.pumpAndSettle();

    expect(find.text("Couldn't read"), findsWidgets);
    expect(find.text('Sports day circular'), findsOneWidget);
    expect(find.text('nothing found'), findsOneWidget);
  });
}
