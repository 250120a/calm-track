// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SoulTrack';

  @override
  String get actionNext => 'Next';

  @override
  String get actionStart => 'Get Started';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionAdd => 'Add';

  @override
  String get onboardingTitle1 => 'Track emotions in three taps';

  @override
  String get onboardingTitle2 => 'Ease stress with mindful play';

  @override
  String get onboardingTitle3 => 'See your progress grow';

  @override
  String get onboardingToggleReminders => 'Remind me to check in';

  @override
  String get onboardingDailyGoalLabel => 'Daily calming goal';

  @override
  String get onboardingDailyGoalSuffix => 'minutes';

  @override
  String onboardingInitialGoal(int minutes) {
    return 'Initial goal set to $minutes minutes';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Stats';

  @override
  String get navCalmPlay => 'Calm Play';

  @override
  String get homeGreeting => 'Hi there';

  @override
  String homeToday(String date) {
    return 'Today is $date';
  }

  @override
  String get homePracticeProgress => 'Calm minutes';

  @override
  String get homeHowFeeling => 'How are you feeling?';

  @override
  String get homeQuickPractice => 'Quick calming';

  @override
  String get homeRecentEntries => 'Today’s log';

  @override
  String get homeAddNoteTitle => 'Add a note';

  @override
  String get homeAddNoteHint => 'What influenced this emotion?';

  @override
  String get homePlayCta => 'Play to relax';

  @override
  String get homeCustomMinutes => 'Custom minutes';

  @override
  String get homeCustomMinutesHint => 'How many minutes?';

  @override
  String get homeNoEntries => 'No entries yet';

  @override
  String get homeViewLog => 'View log';

  @override
  String homeGoalRemaining(int minutes) {
    return '$minutes min left';
  }

  @override
  String get emotionJoyful => 'Joyful';

  @override
  String get emotionPleasant => 'Pleasant';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionUncertain => 'Uncertain';

  @override
  String get emotionAngry => 'Frustrated';

  @override
  String get emotionSleepy => 'Sleepy';

  @override
  String get emotionSad => 'Low';

  @override
  String get emotionExcited => 'Energized';

  @override
  String get practiceBreathing => 'Breathing';

  @override
  String get practiceTimer => 'Calm timer';

  @override
  String get practiceGame => 'Wave dodge';

  @override
  String get practiceCustom => 'Custom';

  @override
  String get snackbarEmotionSaved => 'Emotion logged';

  @override
  String get snackbarEmotionRemoved => 'Entry removed';

  @override
  String get snackbarPracticeSaved => 'Practice added';

  @override
  String get logTitle => 'Emotion log';

  @override
  String get logFilterLabel => 'Filters';

  @override
  String get logFilterAll => 'All';

  @override
  String get logSearchHint => 'Search notes';

  @override
  String get logEmpty => 'No entries for this filter';

  @override
  String get statsTitle => 'Insights';

  @override
  String get statsDistribution => 'Emotion distribution';

  @override
  String get statsMoodTrend => 'Mood trend';

  @override
  String get statsPracticeMinutes => 'Practice minutes';

  @override
  String get statsRange7 => '7 days';

  @override
  String get statsRange30 => '30 days';

  @override
  String get statsRange90 => '90 days';

  @override
  String get calmPlayBreathing => 'Breathing';

  @override
  String get calmPlayTimer => 'Calm timer';

  @override
  String get calmPlayGame => 'Mini-game';

  @override
  String get calmPlayInhale => 'Inhale';

  @override
  String get calmPlayHold => 'Hold';

  @override
  String get calmPlayExhale => 'Exhale';

  @override
  String get calmPlayStart => 'Start';

  @override
  String get calmPlayPause => 'Pause';

  @override
  String get calmPlayResume => 'Resume';

  @override
  String get calmPlayStop => 'Stop';

  @override
  String get calmPlayAddMinutesTitle => 'Add minutes?';

  @override
  String calmPlayAddMinutesBody(int minutes) {
    return 'Add $minutes calming minutes to your log?';
  }

  @override
  String calmPlayElapsed(int minutes, int seconds) {
    return '$minutes min ${seconds}s';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDailyGoal => 'Daily calming goal';

  @override
  String get settingsReminders => 'Emotion reminders';

  @override
  String get settingsAddReminder => 'Add reminder';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsRateApp => 'Rate SoulTrack';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsAbout => 'About SoulTrack';

  @override
  String get settingsRemindersDisabled => 'Reminders disabled';

  @override
  String get settingsRemindersEnabled => 'Reminders enabled';

  @override
  String get privacyTitle => 'Privacy policy';

  @override
  String get privacyBody =>
      'SoulTrack stores your entries locally on device. Data never leaves your phone without your consent.';

  @override
  String get aboutTitle => 'About SoulTrack';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutAuthor => 'Created by Fazal';

  @override
  String get aboutContact => 'Support: fazalbinkaramat@gmail.com';

  @override
  String get aboutDisclaimer => 'SoulTrack is not a medical product.';

  @override
  String get onboardingNameLabel => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Enter your name';

  @override
  String get onboardingNameValidation => 'Please tell us your name';

  @override
  String homeGreetingNamed(String name) {
    return 'Hi, $name';
  }

  @override
  String get settingsName => 'Your name';

  @override
  String get settingsNameHint => 'How should SoulTrack address you?';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageFrench => 'French';

  @override
  String get languageGerman => 'German';

  @override
  String get emotionPeaceful => 'Peaceful';

  @override
  String get settingsUsage => 'Usage guidelines';

  @override
  String get trackingPermissionTitle => 'Help us measure what works';

  @override
  String get trackingPermissionBody =>
      'We use your device identifier to understand which ads lead people to CalmTrack. This keeps the app free and helps us focus on features you love. Apple will now ask if you allow tracking.';

  @override
  String get trackingPermissionButton => 'Continue';

  @override
  String get trackingPermissionSettings =>
      'You can change this anytime in Settings > Privacy > Tracking.';
}
