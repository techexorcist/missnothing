import 'package:flutter_test/flutter_test.dart';
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
  testWidgets('home shows connect and sync after vault skip', (tester) async {
    await tester.pumpWidget(MissNothingApp(session: TestSession()));
    await tester.pumpAndSettle();
    expect(find.text('Connect Gmail'), findsOneWidget);
    expect(find.text('Sync'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Review'), findsWidgets);
  });

  testWidgets('navigation destinations are labeled for TalkBack', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(MissNothingApp(session: TestSession()));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Review'), findsWidgets);
    expect(find.text('Agenda'), findsWidgets);
    expect(find.text('Settings'), findsWidgets);
    handle.dispose();
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
}
