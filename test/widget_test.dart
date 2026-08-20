import 'package:flutter_test/flutter_test.dart';
import 'package:missnothing/data/db/database.dart';
import 'package:missnothing/data/db/gmail_message_index.dart';
import 'package:missnothing/data/events/event_repository.dart';
import 'package:missnothing/ui/app.dart';
import 'package:missnothing/ui/screens/home_screen.dart';
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
    expect(find.text('Week'), findsWidgets);
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

  testWidgets('revoked Gmail access is a full-screen block', (tester) async {
    final session = TestSession()..needsReconnect = true;
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();
    expect(find.text('Reconnect Gmail'), findsWidgets);
    expect(find.textContaining('gmail.readonly'), findsOneWidget);
  });

  testWidgets('week ledger flags a moved date', (tester) async {
    final now = DateTime(2026, 8, 20);
    final event = Event(
      id: 'e1',
      title: 'Hat day',
      startsAt: DateTime(2026, 8, 21),
      allDay: true,
      status: 'active',
      notes: 'moved from Wed 19',
      createdAt: now,
      updatedAt: now,
    );
    final session = TestSession()
      ..agenda = [event]
      ..weekLedger = [
        LedgerRow(
          event: event,
          headline: 'Please bring a hat.',
          movedFrom: 'moved from Wed 19',
        ),
      ];
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Week'));
    await tester.pumpAndSettle();
    expect(find.text('Please bring a hat'), findsOneWidget);
    expect(find.text('moved from Wed 19'), findsOneWidget);
    await tester.tap(find.text('Please bring a hat'));
    await tester.pumpAndSettle();
    expect(find.text('Hat day'), findsWidgets);
    expect(find.text('moved from Wed 19'), findsWidgets);
  });

  testWidgets('inbox notification opens Sort', (tester) async {
    final session = TestSession();
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();
    session.pendingReview = true;
    session.notifyListeners();
    await tester.pumpAndSettle();
    expect(find.text('Nothing loose'), findsOneWidget);
    expect(session.pendingReview, isFalse);
  });

  testWidgets('home names tomorrow as objects and opens incompletes', (
    tester,
  ) async {
    final session = TestSession()
      ..tomorrowSlots = const [
        LayoutSlot(
          itemId: 'i1',
          eventId: 'e1',
          headline: 'ethnic outfit',
          subtitle: '',
          kind: 'dress',
          laidOut: false,
          leaveAtHome: false,
        ),
        LayoutSlot(
          itemId: 'i2',
          eventId: 'e1',
          headline: 'snacks bag',
          subtitle: '',
          kind: 'bring',
          laidOut: true,
          leaveAtHome: true,
        ),
      ]
      ..syncIncomplete = 2
      ..incompletes = const [
        GmailMiss(id: 'm9', status: 'listed', subject: 'Sports day PDF'),
      ];
    await tester.pumpWidget(MissNothingApp(session: session));
    await tester.pumpAndSettle();

    expect(find.text(tomorrowStatement(session.tomorrowSlots)), findsOneWidget);
    expect(find.textContaining('1 of 2 out'), findsOneWidget);
    expect(find.text('STOP ASKING'), findsWidgets);

    await tester.tap(find.textContaining('still downloading'));
    await tester.pumpAndSettle();
    expect(find.text('Still downloading'), findsWidgets);
    expect(find.text('Sports day PDF'), findsOneWidget);
  });
}
