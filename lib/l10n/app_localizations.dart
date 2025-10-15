import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SoulTrack'**
  String get appTitle;

  /// No description provided for @actionNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get actionNext;

  /// No description provided for @actionStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get actionStart;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Track emotions in three taps'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Ease stress with mindful play'**
  String get onboardingTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'See your progress grow'**
  String get onboardingTitle3;

  /// No description provided for @onboardingToggleReminders.
  ///
  /// In en, this message translates to:
  /// **'Remind me to check in'**
  String get onboardingToggleReminders;

  /// No description provided for @onboardingDailyGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily calming goal'**
  String get onboardingDailyGoalLabel;

  /// No description provided for @onboardingDailyGoalSuffix.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get onboardingDailyGoalSuffix;

  /// No description provided for @onboardingInitialGoal.
  ///
  /// In en, this message translates to:
  /// **'Initial goal set to {minutes} minutes'**
  String onboardingInitialGoal(int minutes);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navCalmPlay.
  ///
  /// In en, this message translates to:
  /// **'Calm Play'**
  String get navCalmPlay;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi there'**
  String get homeGreeting;

  /// No description provided for @homeToday.
  ///
  /// In en, this message translates to:
  /// **'Today is {date}'**
  String homeToday(String date);

  /// No description provided for @homePracticeProgress.
  ///
  /// In en, this message translates to:
  /// **'Calm minutes'**
  String get homePracticeProgress;

  /// No description provided for @homeHowFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get homeHowFeeling;

  /// No description provided for @homeQuickPractice.
  ///
  /// In en, this message translates to:
  /// **'Quick calming'**
  String get homeQuickPractice;

  /// No description provided for @homeRecentEntries.
  ///
  /// In en, this message translates to:
  /// **'Today’s log'**
  String get homeRecentEntries;

  /// No description provided for @homeAddNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get homeAddNoteTitle;

  /// No description provided for @homeAddNoteHint.
  ///
  /// In en, this message translates to:
  /// **'What influenced this emotion?'**
  String get homeAddNoteHint;

  /// No description provided for @homePlayCta.
  ///
  /// In en, this message translates to:
  /// **'Play to relax'**
  String get homePlayCta;

  /// No description provided for @homeCustomMinutes.
  ///
  /// In en, this message translates to:
  /// **'Custom minutes'**
  String get homeCustomMinutes;

  /// No description provided for @homeCustomMinutesHint.
  ///
  /// In en, this message translates to:
  /// **'How many minutes?'**
  String get homeCustomMinutesHint;

  /// No description provided for @homeNoEntries.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get homeNoEntries;

  /// No description provided for @homeViewLog.
  ///
  /// In en, this message translates to:
  /// **'View log'**
  String get homeViewLog;

  /// No description provided for @homeGoalRemaining.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min left'**
  String homeGoalRemaining(int minutes);

  /// No description provided for @emotionJoyful.
  ///
  /// In en, this message translates to:
  /// **'Joyful'**
  String get emotionJoyful;

  /// No description provided for @emotionPleasant.
  ///
  /// In en, this message translates to:
  /// **'Pleasant'**
  String get emotionPleasant;

  /// No description provided for @emotionNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get emotionNeutral;

  /// No description provided for @emotionUncertain.
  ///
  /// In en, this message translates to:
  /// **'Uncertain'**
  String get emotionUncertain;

  /// No description provided for @emotionAngry.
  ///
  /// In en, this message translates to:
  /// **'Frustrated'**
  String get emotionAngry;

  /// No description provided for @emotionSleepy.
  ///
  /// In en, this message translates to:
  /// **'Sleepy'**
  String get emotionSleepy;

  /// No description provided for @emotionSad.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get emotionSad;

  /// No description provided for @emotionExcited.
  ///
  /// In en, this message translates to:
  /// **'Energized'**
  String get emotionExcited;

  /// No description provided for @practiceBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get practiceBreathing;

  /// No description provided for @practiceTimer.
  ///
  /// In en, this message translates to:
  /// **'Calm timer'**
  String get practiceTimer;

  /// No description provided for @practiceGame.
  ///
  /// In en, this message translates to:
  /// **'Wave dodge'**
  String get practiceGame;

  /// No description provided for @practiceCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get practiceCustom;

  /// No description provided for @snackbarEmotionSaved.
  ///
  /// In en, this message translates to:
  /// **'Emotion logged'**
  String get snackbarEmotionSaved;

  /// No description provided for @snackbarEmotionRemoved.
  ///
  /// In en, this message translates to:
  /// **'Entry removed'**
  String get snackbarEmotionRemoved;

  /// No description provided for @snackbarPracticeSaved.
  ///
  /// In en, this message translates to:
  /// **'Practice added'**
  String get snackbarPracticeSaved;

  /// No description provided for @logTitle.
  ///
  /// In en, this message translates to:
  /// **'Emotion log'**
  String get logTitle;

  /// No description provided for @logFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get logFilterLabel;

  /// No description provided for @logFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get logFilterAll;

  /// No description provided for @logSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search notes'**
  String get logSearchHint;

  /// No description provided for @logEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entries for this filter'**
  String get logEmpty;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get statsTitle;

  /// No description provided for @statsDistribution.
  ///
  /// In en, this message translates to:
  /// **'Emotion distribution'**
  String get statsDistribution;

  /// No description provided for @statsMoodTrend.
  ///
  /// In en, this message translates to:
  /// **'Mood trend'**
  String get statsMoodTrend;

  /// No description provided for @statsPracticeMinutes.
  ///
  /// In en, this message translates to:
  /// **'Practice minutes'**
  String get statsPracticeMinutes;

  /// No description provided for @statsRange7.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get statsRange7;

  /// No description provided for @statsRange30.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get statsRange30;

  /// No description provided for @statsRange90.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get statsRange90;

  /// No description provided for @calmPlayBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get calmPlayBreathing;

  /// No description provided for @calmPlayTimer.
  ///
  /// In en, this message translates to:
  /// **'Calm timer'**
  String get calmPlayTimer;

  /// No description provided for @calmPlayGame.
  ///
  /// In en, this message translates to:
  /// **'Mini-game'**
  String get calmPlayGame;

  /// No description provided for @calmPlayInhale.
  ///
  /// In en, this message translates to:
  /// **'Inhale'**
  String get calmPlayInhale;

  /// No description provided for @calmPlayHold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get calmPlayHold;

  /// No description provided for @calmPlayExhale.
  ///
  /// In en, this message translates to:
  /// **'Exhale'**
  String get calmPlayExhale;

  /// No description provided for @calmPlayStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get calmPlayStart;

  /// No description provided for @calmPlayPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get calmPlayPause;

  /// No description provided for @calmPlayResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get calmPlayResume;

  /// No description provided for @calmPlayStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get calmPlayStop;

  /// No description provided for @calmPlayAddMinutesTitle.
  ///
  /// In en, this message translates to:
  /// **'Add minutes?'**
  String get calmPlayAddMinutesTitle;

  /// No description provided for @calmPlayAddMinutesBody.
  ///
  /// In en, this message translates to:
  /// **'Add {minutes} calming minutes to your log?'**
  String calmPlayAddMinutesBody(int minutes);

  /// No description provided for @calmPlayElapsed.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min {seconds}s'**
  String calmPlayElapsed(int minutes, int seconds);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsDailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily calming goal'**
  String get settingsDailyGoal;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Emotion reminders'**
  String get settingsReminders;

  /// No description provided for @settingsAddReminder.
  ///
  /// In en, this message translates to:
  /// **'Add reminder'**
  String get settingsAddReminder;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate SoulTrack'**
  String get settingsRateApp;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About SoulTrack'**
  String get settingsAbout;

  /// No description provided for @settingsRemindersDisabled.
  ///
  /// In en, this message translates to:
  /// **'Reminders disabled'**
  String get settingsRemindersDisabled;

  /// No description provided for @settingsRemindersEnabled.
  ///
  /// In en, this message translates to:
  /// **'Reminders enabled'**
  String get settingsRemindersEnabled;

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeleteAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your profile and all saved data from this device.'**
  String get settingsDeleteAccountDescription;

  /// No description provided for @settingsDeleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDeleteAccountButton;

  /// No description provided for @settingsDeleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get settingsDeleteAccountConfirmTitle;

  /// No description provided for @settingsDeleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove your name, goals, reminders, and all emotion and practice history from this device. This cannot be undone.'**
  String get settingsDeleteAccountConfirmMessage;

  /// No description provided for @settingsDeleteAccountConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settingsDeleteAccountConfirmAction;

  /// No description provided for @settingsDeleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your account data has been deleted.'**
  String get settingsDeleteAccountSuccess;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'SoulTrack stores your entries locally on device. Data never leaves your phone without your consent.'**
  String get privacyBody;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About SoulTrack'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutVersion(String version);

  /// No description provided for @aboutAuthor.
  ///
  /// In en, this message translates to:
  /// **'Created by Fazal'**
  String get aboutAuthor;

  /// No description provided for @aboutContact.
  ///
  /// In en, this message translates to:
  /// **'Support: fazalbinkaramat@gmail.com'**
  String get aboutContact;

  /// No description provided for @aboutDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'SoulTrack is not a medical product.'**
  String get aboutDisclaimer;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get onboardingNameHint;

  /// No description provided for @onboardingNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please tell us your name'**
  String get onboardingNameValidation;

  /// No description provided for @homeGreetingNamed.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String homeGreetingNamed(String name);

  /// No description provided for @settingsName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settingsName;

  /// No description provided for @settingsNameHint.
  ///
  /// In en, this message translates to:
  /// **'How should SoulTrack address you?'**
  String get settingsNameHint;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @emotionPeaceful.
  ///
  /// In en, this message translates to:
  /// **'Peaceful'**
  String get emotionPeaceful;

  /// No description provided for @settingsUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage guidelines'**
  String get settingsUsage;

  /// No description provided for @trackingPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Help us measure what works'**
  String get trackingPermissionTitle;

  /// No description provided for @trackingPermissionBody.
  ///
  /// In en, this message translates to:
  /// **'We use your device identifier to understand which ads lead people to CalmTrack. This keeps the app free and helps us focus on features you love. Apple will now ask if you allow tracking.'**
  String get trackingPermissionBody;

  /// No description provided for @trackingPermissionButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get trackingPermissionButton;

  /// No description provided for @trackingPermissionSettings.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in Settings > Privacy > Tracking.'**
  String get trackingPermissionSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
