// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'SoulTrack';

  @override
  String get actionNext => 'Weiter';

  @override
  String get actionStart => 'Starten';

  @override
  String get actionSave => 'Speichern';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionAdd => 'Hinzufügen';

  @override
  String get onboardingTitle1 => 'Erfasse Emotionen in drei Sekunden';

  @override
  String get onboardingTitle2 => 'Baue Stress mit Minispielen ab';

  @override
  String get onboardingTitle3 => 'Sieh deinen Fortschritt';

  @override
  String get onboardingToggleReminders => 'An das Eintragen erinnern';

  @override
  String get onboardingDailyGoalLabel => 'Tägliches Ruhe-Ziel';

  @override
  String get onboardingDailyGoalSuffix => 'Minuten';

  @override
  String onboardingInitialGoal(int minutes) {
    return 'Initial goal set to $minutes minutes';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Statistiken';

  @override
  String get navCalmPlay => 'Calm Play';

  @override
  String get homeGreeting => 'Hallo';

  @override
  String homeToday(String date) {
    return 'Heute ist $date';
  }

  @override
  String get homePracticeProgress => 'Ruhe-Minuten';

  @override
  String get homeHowFeeling => 'Wie fühlst du dich?';

  @override
  String get homeQuickPractice => 'Schnelle Ruhe';

  @override
  String get homeRecentEntries => 'Heutige Einträge';

  @override
  String get homeAddNoteTitle => 'Notiz hinzufügen';

  @override
  String get homeAddNoteHint => 'Was hat die Emotion beeinflusst?';

  @override
  String get homePlayCta => 'Zum Entspannen spielen';

  @override
  String get homeCustomMinutes => 'Eigene Minuten';

  @override
  String get homeCustomMinutesHint => 'Wie viele Minuten?';

  @override
  String get homeNoEntries => 'Noch keine Einträge';

  @override
  String get homeViewLog => 'Protokoll ansehen';

  @override
  String homeGoalRemaining(int minutes) {
    return '$minutes Min übrig';
  }

  @override
  String get emotionJoyful => 'Freudig';

  @override
  String get emotionPleasant => 'Zufrieden';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionUncertain => 'Unsicher';

  @override
  String get emotionAngry => 'Verärgert';

  @override
  String get emotionSleepy => 'Müde';

  @override
  String get emotionSad => 'Niedergeschlagen';

  @override
  String get emotionExcited => 'Aufgeregt';

  @override
  String get practiceBreathing => 'Atmung';

  @override
  String get practiceTimer => 'Timer';

  @override
  String get practiceGame => 'Wave dodge';

  @override
  String get practiceCustom => 'Eigen';

  @override
  String get snackbarEmotionSaved => 'Emotion gespeichert';

  @override
  String get snackbarEmotionRemoved => 'Eintrag gelöscht';

  @override
  String get snackbarPracticeSaved => 'Übung hinzugefügt';

  @override
  String get logTitle => 'Emotionsprotokoll';

  @override
  String get logFilterLabel => 'Filter';

  @override
  String get logFilterAll => 'Alle';

  @override
  String get logSearchHint => 'Notizen durchsuchen';

  @override
  String get logEmpty => 'Keine Einträge für diesen Filter';

  @override
  String get statsTitle => 'Einblicke';

  @override
  String get statsDistribution => 'Emotionsverteilung';

  @override
  String get statsMoodTrend => 'Stimmungstrend';

  @override
  String get statsPracticeMinutes => 'Übungsminuten';

  @override
  String get statsRange7 => '7 Tage';

  @override
  String get statsRange30 => '30 Tage';

  @override
  String get statsRange90 => '90 Tage';

  @override
  String get calmPlayBreathing => 'Atmung';

  @override
  String get calmPlayTimer => 'Timer';

  @override
  String get calmPlayGame => 'Minispiel';

  @override
  String get calmPlayInhale => 'Einatmen';

  @override
  String get calmPlayHold => 'Halten';

  @override
  String get calmPlayExhale => 'Ausatmen';

  @override
  String get calmPlayStart => 'Start';

  @override
  String get calmPlayPause => 'Pause';

  @override
  String get calmPlayResume => 'Fortsetzen';

  @override
  String get calmPlayStop => 'Stopp';

  @override
  String get calmPlayAddMinutesTitle => 'Minuten hinzufügen?';

  @override
  String calmPlayAddMinutesBody(int minutes) {
    return '$minutes Ruhe-Minuten zum Protokoll hinzufügen?';
  }

  @override
  String calmPlayElapsed(int minutes, int seconds) {
    return '$minutes Min ${seconds}s';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsDailyGoal => 'Tägliches Ruhe-Ziel';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsAddReminder => 'Erinnerung hinzufügen';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsRateApp => 'SoulTrack bewerten';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsAbout => 'Über SoulTrack';

  @override
  String get settingsRemindersDisabled => 'Erinnerungen aus';

  @override
  String get settingsRemindersEnabled => 'Erinnerungen an';

  @override
  String get settingsDeleteAccountTitle => 'Konto löschen';

  @override
  String get settingsDeleteAccountDescription =>
      'Entfernt dauerhaft dein Profil und alle gespeicherten Daten von diesem Gerät.';

  @override
  String get settingsDeleteAccountButton => 'Konto löschen';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Konto löschen?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Dadurch werden dein Name, Ziele, Erinnerungen sowie dein gesamtes Emotions- und Übungsprotokoll von diesem Gerät entfernt. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get settingsDeleteAccountConfirmAction => 'Löschen';

  @override
  String get settingsDeleteAccountSuccess => 'Deine Kontodaten wurden gelöscht.';

  @override
  String get privacyTitle => 'Datenschutz';

  @override
  String get privacyBody =>
      'SoulTrack speichert Einträge lokal auf dem Gerät. Daten verlassen das Telefon nur mit deiner Zustimmung.';

  @override
  String get aboutTitle => 'Über SoulTrack';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutAuthor => 'Erstellt von Fazal';

  @override
  String get aboutContact => 'Support: fazalbinkaramat@gmail.com';

  @override
  String get aboutDisclaimer => 'SoulTrack ist kein Medizinprodukt.';

  @override
  String get onboardingNameLabel => 'Wie sollen wir dich nennen?';

  @override
  String get onboardingNameHint => 'Name eingeben';

  @override
  String get onboardingNameValidation => 'Bitte gib deinen Namen ein';

  @override
  String homeGreetingNamed(String name) {
    return 'Hallo, $name';
  }

  @override
  String get settingsName => 'Dein Name';

  @override
  String get settingsNameHint => 'Wie sollen wir dich ansprechen?';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Systemsprache';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get emotionPeaceful => 'Gelassen';

  @override
  String get settingsUsage => 'Nutzungsbedingungen';

  @override
  String get trackingPermissionTitle =>
      'Hilf uns zu verstehen, was funktioniert';

  @override
  String get trackingPermissionBody =>
      'Wir verwenden deine Gerätekennung, um zu verstehen, welche Anzeigen Menschen zu CalmTrack bringen. So bleibt die App kostenlos und wir können uns auf Funktionen konzentrieren, die dir wichtig sind. Apple wird dich nun fragen, ob du das Tracking erlaubst.';

  @override
  String get trackingPermissionButton => 'Weiter';

  @override
  String get trackingPermissionSettings =>
      'Du kannst dies jederzeit unter Einstellungen > Datenschutz > Tracking ändern.';
}
