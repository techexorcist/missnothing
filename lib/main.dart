import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';

import 'config/app_config.dart';
import 'data/db/vault.dart';
import 'data/gmail/gmail_readonly.dart';
import 'data/reminders/one_shot_alarm.dart';

const _pasteWebClientId =
    'Copy secrets.json.example to secrets.json, paste the Web OAuth '
    'client ID, then: flutter run --dart-define-from-file=secrets.json';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MissNothingApp());
}

class MissNothingApp extends StatelessWidget {
  const MissNothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MissNothing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB45309),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const SkeletonPage(),
    );
  }
}

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({super.key});

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  GoogleSignInAccount? _user;
  String _log =
      'Unlock the vault (device PIN), then Connect Gmail. 90s is a smoke '
      'test. 5h is the OEM test: swipe out of recents, lock, leave it.';
  String _vault = 'Vault: unlocking…';
  bool _busy = false;
  bool _signInReady = false;
  bool _vaultReady = false;

  @override
  void initState() {
    super.initState();
    unawaited(_unlockThenSignIn());
  }

  Future<void> _unlockThenSignIn() async {
    await _unlockVault();
    await _initSignIn();
  }

  Future<void> _unlockVault() async {
    try {
      final opened = await unlockVault();
      if (!mounted) return;
      setState(() {
        _vaultReady = true;
        _vault =
            'Vault open · SQLCipher ${opened.cipherVersion} · ${opened.lastUnlock}';
      });
    } on MissingPluginException {
      if (!mounted) return;
      setState(() {
        _vaultReady = true;
        _vault = 'Vault skipped (no Keystore on this platform)';
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _vaultReady = false;
        _vault = 'Vault locked: ${e.code} ${e.message}';
        _log = e.message ?? e.code;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _vaultReady = false;
        _vault = 'Vault locked: $e';
        _log = '$e';
      });
    }
  }

  Future<void> _initSignIn() async {
    try {
      final signIn = GoogleSignIn.instance;
      await signIn.initialize(
        serverClientId: AppConfig.googleServerClientId.isEmpty
            ? null
            : AppConfig.googleServerClientId,
      );
      signIn.authenticationEvents.listen((event) {
        if (!mounted) return;
        setState(() {
          _user = switch (event) {
            GoogleSignInAuthenticationEventSignIn() => event.user,
            GoogleSignInAuthenticationEventSignOut() => null,
          };
        });
      });
      if (AppConfig.googleServerClientId.isNotEmpty) {
        signIn.attemptLightweightAuthentication();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _log = 'Sign-in init failed: $e');
      }
    } finally {
      if (mounted) setState(() => _signInReady = true);
    }
  }

  Future<void> _connect() async {
    if (AppConfig.googleServerClientId.isEmpty) {
      setState(() => _log = _pasteWebClientId);
      return;
    }
    setState(() {
      _busy = true;
      _log = 'Signing in…';
    });
    try {
      final user = await GoogleSignIn.instance.authenticate(
        scopeHint: const [GmailApi.gmailReadonlyScope],
      );
      setState(() {
        _user = user;
        _log = 'Signed in as ${user.email}';
      });
    } on GoogleSignInException catch (e) {
      setState(() => _log = 'Sign-in failed: ${e.code.name} ${e.description}');
    } catch (e) {
      setState(() => _log = 'Sign-in failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<GoogleSignInClientAuthorization?> _gmailAuth(
    GoogleSignInAccount user,
  ) async {
    const scopes = [GmailApi.gmailReadonlyScope];
    var authz = await user.authorizationClient.authorizationForScopes(scopes);
    authz ??= await user.authorizationClient.authorizeScopes(scopes);
    return authz;
  }

  Future<void> _sync() async {
    final user = _user;
    if (user == null) {
      setState(() => _log = 'Connect Gmail first.');
      return;
    }
    if (AppConfig.googleServerClientId.isEmpty) {
      setState(() => _log = _pasteWebClientId);
      return;
    }
    setState(() {
      _busy = true;
      _log = 'Syncing ${AppConfig.allowlistedFrom}…';
    });
    try {
      final authz = await _gmailAuth(user);
      if (authz == null) {
        setState(() {
          _log =
              'Gmail scope missing (authorizationForScopes was null). Tap Connect Gmail again.';
        });
        return;
      }
      final gmail = gmailApiForToken(authz.accessToken);
      final fetched = await fetchAllowlistedCircular(gmail);
      final notes = fetched.notes.join('\n');
      final hit = fetched.hit;
      if (hit == null) {
        setState(() {
          _log =
              'No parsable circular from ${AppConfig.allowlistedFrom} '
              'in the last 30 days (Spam included).\n$notes';
        });
        return;
      }
      final when = await scheduleParsedCircular(hit.proposal);
      setState(() {
        _log = 'Parsed ${hit.subject}\n'
            'type=${hit.proposal.type.name} date=${hit.proposal.date}\n'
            'items=${hit.proposal.items.length}\n'
            '90s smoke at ${when.near}\n'
            '5h OEM at ${when.far}\n'
            'Swipe out of recents, lock, leave it. 90s firing proves nothing.\n'
            '$notes';
      });
    } catch (e) {
      setState(() => _log = 'Sync failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  bool get _actionsOn => _signInReady && _vaultReady && !_busy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MissNothing skeleton')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _user == null ? 'Not connected' : 'Gmail: ${_user!.email}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(_vault, style: Theme.of(context).textTheme.bodySmall),
            Text(
              'Allowlist: ${AppConfig.allowlistedFrom}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _vaultReady || _busy
                  ? null
                  : () => unawaited(_unlockVault()),
              child: const Text('Unlock vault'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: !_actionsOn ? null : _connect,
              child: const Text('Connect Gmail'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: !_actionsOn ? null : _sync,
              child: const Text('Sync'),
            ),
            const SizedBox(height: 24),
            if (_busy) const LinearProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_log),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
