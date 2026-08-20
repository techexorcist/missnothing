import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';

import '../config/app_config.dart';
import '../data/db/database.dart';
import '../data/db/vault.dart';
import '../data/events/event_repository.dart';
import '../data/gmail/from_header.dart';
import '../data/gmail/gmail_readonly.dart';
import '../data/gmail/live_mailbox.dart';
import '../data/parser/proposal.dart' as school;
import '../data/reminders/alarm_planner.dart';
import '../data/reminders/alarm_repository.dart';
import '../data/reminders/notifications.dart';
import '../data/reminders/one_shot_alarm.dart';
import '../data/review/proposal_repository.dart';
import '../data/settings/settings_repository.dart';
import '../data/sources/source_repository.dart';
import '../data/sync/account_sync.dart';
import '../data/sync/background_sync.dart';
import '../data/widgets/glance_state.dart';

class AppSession extends ChangeNotifier {
  GoogleSignInAccount? user;
  MissNothingVault? vault;
  String vaultLabel = 'Vault: unlocking…';
  String log =
      'Unlock the vault, connect Gmail, then review school circulars before '
      'any alarm is kept.';
  bool busy = false;
  bool signInReady = false;
  bool vaultReady = false;
  bool onboardingDone = false;
  int reviewCount = 0;
  int eventCount = 0;
  String lastSyncLabel = 'Not synced yet';
  String? pendingEventId;
  String? lastUndoProposalId;
  List<ProposalRecord> inbox = const [];
  List<Event> agenda = const [];
  List<SourceAllowlistEntry> allowlist = const [];
  List<AppAccount> accounts = const [];

  bool get actionsOn => signInReady && vaultReady && !busy;

  String get accountId {
    final email = user?.email;
    if (email == null || email.isEmpty) return 'acct_local';
    return 'acct_${email.toLowerCase()}';
  }

  Future<void> bootstrap() async {
    await unlockVaultInteractive();
    await initSignIn();
  }

  Future<void> unlockVaultInteractive() async {
    try {
      final opened = await unlockVault();
      vault = opened.vault;
      vaultReady = true;
      vaultLabel =
          'Vault open · SQLCipher ${opened.cipherVersion} · ${opened.lastUnlock}';
      try {
        await const BackgroundSyncScheduler().initialize();
      } catch (_) {}
      await _afterVaultOpen();
    } on MissingPluginException {
      vaultReady = true;
      onboardingDone = true;
      vaultLabel = 'Vault skipped (no Keystore on this platform)';
    } on PlatformException catch (error) {
      vaultReady = false;
      vaultLabel = 'Vault locked: ${error.code} ${error.message}';
      log = error.message ?? error.code;
    } catch (error) {
      vaultReady = false;
      vaultLabel = 'Vault locked: $error';
      log = '$error';
    }
    notifyListeners();
  }

  Future<void> _afterVaultOpen() async {
    final opened = vault;
    if (opened == null) return;
    await opened.use((db) async {
      onboardingDone = await SettingsRepository(db).onboardingDone();
      await SourceRepository(db).seedDefault(
        accountId: accountId,
        accountEmail: user?.email ?? 'pending@local',
        mailbox: AppConfig.allowlistedFrom,
      );
    });
    try {
      await initNotifications(onResponse: _onNotification);
      await EventAlarms.reconcile(opened);
    } catch (_) {}
    await refreshFromVault();
  }

  Future<void> refreshFromVault() async {
    final opened = vault;
    if (opened == null) {
      notifyListeners();
      return;
    }
    await opened.use((db) async {
      inbox = await ProposalRepository(db).unreviewedRecords();
      agenda = await EventRepository(db).active();
      allowlist = await SourceRepository(db).allowlistRows();
      accounts = await db.select(db.appAccounts).get();
      reviewCount = inbox.length;
      eventCount = agenda.length;
      try {
        await GlanceState(db).publish();
      } catch (_) {}
    });
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    onboardingDone = true;
    await vault?.use((db) => SettingsRepository(db).setOnboardingDone());
    notifyListeners();
  }

  Future<void> initSignIn() async {
    try {
      final signIn = GoogleSignIn.instance;
      await signIn.initialize(
        serverClientId: AppConfig.googleServerClientId.isEmpty
            ? null
            : AppConfig.googleServerClientId,
      );
      signIn.authenticationEvents.listen((event) {
        user = switch (event) {
          GoogleSignInAuthenticationEventSignIn() => event.user,
          GoogleSignInAuthenticationEventSignOut() => null,
        };
        notifyListeners();
      });
      if (AppConfig.googleServerClientId.isNotEmpty) {
        signIn.attemptLightweightAuthentication();
      }
    } catch (error) {
      log = 'Sign-in init failed: $error';
    } finally {
      signInReady = true;
      notifyListeners();
    }
  }

  Future<void> connect() async {
    if (AppConfig.googleServerClientId.isEmpty) {
      log =
          'Copy secrets.json.example to secrets.json, paste the Web OAuth '
          'client ID, then: flutter run --dart-define-from-file=secrets.json';
      notifyListeners();
      return;
    }
    busy = true;
    log = 'Signing in…';
    notifyListeners();
    try {
      user = await GoogleSignIn.instance.authenticate(
        scopeHint: const [GmailApi.gmailReadonlyScope],
      );
      log = 'Signed in as ${user!.email}';
      await vault?.use((db) {
        return SourceRepository(db).seedDefault(
          accountId: accountId,
          accountEmail: user!.email,
          mailbox: AppConfig.allowlistedFrom,
        );
      });
      await refreshFromVault();
    } on GoogleSignInException catch (error) {
      log = 'Sign-in failed: ${error.code.name} ${error.description}';
    } catch (error) {
      log = 'Sign-in failed: $error';
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  Future<void> sync() async {
    final currentUser = user;
    final opened = vault;
    if (currentUser == null) {
      log = 'Connect Gmail first.';
      notifyListeners();
      return;
    }
    if (opened == null) {
      log = 'Unlock the encrypted vault first.';
      notifyListeners();
      return;
    }
    busy = true;
    log = 'Syncing allowlisted circulars…';
    notifyListeners();
    try {
      const scopes = [GmailApi.gmailReadonlyScope];
      var authz = await currentUser.authorizationClient.authorizationForScopes(
        scopes,
      );
      authz ??= await currentUser.authorizationClient.authorizeScopes(scopes);
      final token = authz.accessToken;
      await opened.use((db) async {
        final sources = SourceRepository(db);
        await sources.seedDefault(
          accountId: accountId,
          accountEmail: currentUser.email,
          mailbox: AppConfig.allowlistedFrom,
        );
        final snapshots = await sources.forAccount(accountId);
        final entries = [
          for (final snapshot in snapshots) ...snapshot.allowlist,
        ];
        if (entries.isEmpty) {
          entries.add(AllowlistEntry.mailbox(AppConfig.allowlistedFrom));
        }
        final outcome = await AccountSync(
          db: db,
          mailbox: LiveGmailMailbox(gmailApiForToken(token)),
        ).run(accountId: accountId, allowlist: entries);
        if (outcome.result.failure != null) {
          lastSyncLabel = 'Sync failed · ${outcome.result.failure!.code.name}';
          log =
              '${outcome.result.failure!.message}\n'
              '${outcome.result.notes.join('\n')}';
          return;
        }
        lastSyncLabel =
            'Last sync ${DateTime.now().toLocal().toString().split('.').first}';
        log =
            'Ready to review: ${outcome.result.parsed.length} circulars.\n'
            'Gmail=${outcome.result.listedIds.length} '
            '${outcome.balanced ? "OK" : "MISMATCH"}\n'
            '${outcome.result.notes.join('\n')}';
      });
      await refreshFromVault();
    } catch (error) {
      lastSyncLabel = 'Sync failed';
      log = 'Sync failed: $error';
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  Future<void> confirmProposal(
    ProposalRecord card, {
    DateTime? date,
    String? location,
    String? title,
  }) async {
    final opened = vault;
    if (opened == null) return;
    busy = true;
    notifyListeners();
    try {
      await opened.use((db) async {
        final event = await ProposalRepository(db).confirmAsEvent(
          proposalId: card.row.id,
          title: title,
          startsAt: date ?? card.row.proposedDate,
          location: location ?? card.row.location,
        );
        final night = await SettingsRepository(
          db,
        ).hour(SettingKey.nightBeforeHour, 20);
        final morning = await SettingsRepository(
          db,
        ).hour(SettingKey.morningOfHour, 7);
        final plans = AlarmPlanner(
          nightBefore: ClockTime(night, 0),
          morningOf: ClockTime(morning, 0),
        ).forEvent(startsAt: event.startsAt, allDay: event.allDay);
        await AlarmRepository(
          db,
        ).replaceForEvent(eventId: event.id, plans: plans);
      });
      await EventAlarms.reconcile(opened);
      log = 'Added to agenda. Reminders schedule after you confirm, not sync.';
    } catch (error) {
      log = 'Could not add: $error';
    } finally {
      busy = false;
      await refreshFromVault();
    }
  }

  Future<void> skipProposal(ProposalRecord card) async {
    lastUndoProposalId = card.row.id;
    await vault?.use((db) {
      return ProposalRepository(
        db,
      ).decide(proposalId: card.row.id, status: ProposalStatus.skipped);
    });
    log = 'Skipped. Undo from Review if that was a mistake.';
    await refreshFromVault();
  }

  Future<void> maybeProposal(ProposalRecord card) async {
    await vault?.use((db) {
      return ProposalRepository(
        db,
      ).decide(proposalId: card.row.id, status: ProposalStatus.maybe);
    });
    await refreshFromVault();
  }

  Future<void> undoSkip() async {
    final id = lastUndoProposalId;
    if (id == null) return;
    await vault?.use((db) {
      return ProposalRepository(
        db,
      ).decide(proposalId: id, status: ProposalStatus.unreviewed);
    });
    lastUndoProposalId = null;
    await refreshFromVault();
  }

  Future<void> markEventDone(String eventId) async {
    final opened = vault;
    if (opened == null) return;
    await opened.use((db) async {
      await EventRepository(db).markDone(eventId);
      final alarms = await AlarmRepository(db).forEvent(eventId);
      await AlarmRepository(db).markDoneForEvent(eventId);
      await EventAlarms.cancel(alarms.map((row) => row.notificationId));
    });
    await refreshFromVault();
  }

  Future<void> snoozeAlarm(String alarmId) async {
    final opened = vault;
    if (opened == null) return;
    await opened.use((db) async {
      final child = await AlarmRepository(db).snooze(alarmId: alarmId);
      await EventAlarms.scheduleRow(child);
    });
  }

  Future<void> addAllowlistValue(String raw) async {
    final value = raw.trim();
    if (value.isEmpty || vault == null) return;
    await vault!.use((db) async {
      await SourceRepository(db).seedDefault(
        accountId: accountId,
        accountEmail: user?.email ?? 'pending@local',
        mailbox: AppConfig.allowlistedFrom,
      );
      await SourceRepository(db).addAllowlist(
        sourceId: SourceRepository.defaultSourceId,
        entry: value.contains('@')
            ? AllowlistEntry.mailbox(value)
            : AllowlistEntry.domain(value),
      );
    });
    await refreshFromVault();
  }

  Future<void> removeAllowlistValue(String id) async {
    await vault?.use((db) => SourceRepository(db).removeAllowlist(id));
    await refreshFromVault();
  }

  Future<void> setAlarmHour(String key, int hour) async {
    await vault?.use((db) => SettingsRepository(db).set(key, '$hour'));
  }

  Future<void> scheduleSmokeAlarms() async {
    try {
      await scheduleParsedCircular(
        school.Proposal(
          type: school.ProposalType.datedAction,
          from: 'diagnostics',
          date: DateTime.now(),
          items: const [
            school.ProposalItem(
              kind: school.ItemKind.other,
              textRaw: 'Diagnostics smoke alarm',
            ),
          ],
        ),
      );
      log = 'Scheduled 90-second and 5-hour diagnostic alarms.';
    } catch (error) {
      log = 'Could not schedule diagnostics: $error';
    }
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    try {
      await requestReminderPermissions();
      log = 'Notification and exact-alarm prompts were shown.';
    } catch (error) {
      log = 'Permission prompt failed: $error';
    }
    notifyListeners();
  }

  Future<void> wipeLocalData() async {
    await vault?.use((db) async {
      await db.delete(db.alarmSchedules).go();
      await db.delete(db.eventItems).go();
      await db.delete(db.events).go();
      await db.delete(db.proposalItems).go();
      await db.delete(db.proposals).go();
    });
    log = 'Events, cards, and alarms deleted from this phone.';
    await refreshFromVault();
  }

  void setLog(String value) {
    log = value;
    notifyListeners();
  }

  void consumePendingEvent() {
    pendingEventId = null;
  }

  void _onNotification(NotificationResponse response) {
    final payload = NotificationPayload.parse(response.payload);
    pendingEventId = payload?.eventId;
    if (response.actionId == 'done' && payload?.eventId != null) {
      markEventDone(payload!.eventId!);
    } else if (response.actionId == 'snooze' && payload?.alarmId != null) {
      snoozeAlarm(payload!.alarmId!);
    }
    notifyListeners();
  }
}
