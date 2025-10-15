import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/emotion_provider.dart';
import 'providers/practice_provider.dart';
import 'providers/prefs_provider.dart';
import 'screens/onboarding.dart';
import 'config/app_config.dart';
import 'screens/shell.dart';
import 'services/notifications/notification_service.dart';
import 'services/storage/storage_service.dart';
import 'style/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  final firebaseReady = await _initFirebase();
  await AppConfig.instance.load(useRemote: firebaseReady);
  await NotificationService.instance.init();
  runApp(const CalmTrackApp());
}

Future<bool> _initFirebase() async {
  try {
    await Firebase.initializeApp();
    return true;
  } catch (err) {
    debugPrint('Firebase initialization failed: $err');
    return false;
  }
}

class CalmTrackApp extends StatelessWidget {
  const CalmTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PrefsProvider(StorageService.instance)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmotionProvider(StorageService.instance)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => PracticeProvider(StorageService.instance)..load(),
        ),
      ],
      child: Consumer<PrefsProvider>(
        builder: (context, prefs, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConfig.instance.gameName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: prefs.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: prefs.locale,
            home: prefs.isLoaded
                ? (prefs.onboardingComplete
                      ? const CalmShell()
                      : const OnboardingScreen())
                : const _SplashScreen(),
          );
        },
      ),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
