// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'SoulTrack';

  @override
  String get actionNext => 'Suivant';

  @override
  String get actionStart => 'Commencer';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionAdd => 'Ajouter';

  @override
  String get onboardingTitle1 => 'Saisis tes émotions en trois tapes';

  @override
  String get onboardingTitle2 => 'Réduis le stress avec des mini-jeux';

  @override
  String get onboardingTitle3 => 'Observe ta progression';

  @override
  String get onboardingToggleReminders => 'Me rappeler de noter mes émotions';

  @override
  String get onboardingDailyGoalLabel => 'Objectif quotidien de calme';

  @override
  String get onboardingDailyGoalSuffix => 'minutes';

  @override
  String onboardingInitialGoal(int minutes) {
    return 'Initial goal set to $minutes minutes';
  }

  @override
  String get navHome => 'Accueil';

  @override
  String get navStats => 'Stats';

  @override
  String get navCalmPlay => 'Calm Play';

  @override
  String get homeGreeting => 'Salut';

  @override
  String homeToday(String date) {
    return 'Nous sommes le $date';
  }

  @override
  String get homePracticeProgress => 'Minutes de calme';

  @override
  String get homeHowFeeling => 'Comment te sens-tu ?';

  @override
  String get homeQuickPractice => 'Calme rapide';

  @override
  String get homeRecentEntries => 'Journal du jour';

  @override
  String get homeAddNoteTitle => 'Ajouter une note';

  @override
  String get homeAddNoteHint => 'Qu\'est-ce qui a influencé cette émotion ?';

  @override
  String get homePlayCta => 'Jouer pour se détendre';

  @override
  String get homeCustomMinutes => 'Minutes perso';

  @override
  String get homeCustomMinutesHint => 'Combien de minutes ?';

  @override
  String get homeNoEntries => 'Aucune entrée';

  @override
  String get homeViewLog => 'Voir le journal';

  @override
  String homeGoalRemaining(int minutes) {
    return 'Plus que $minutes min';
  }

  @override
  String get emotionJoyful => 'Joyeux';

  @override
  String get emotionPleasant => 'Content';

  @override
  String get emotionNeutral => 'Neutre';

  @override
  String get emotionUncertain => 'Incertain';

  @override
  String get emotionAngry => 'Agacé';

  @override
  String get emotionSleepy => 'Somnolent';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionExcited => 'Excité';

  @override
  String get practiceBreathing => 'Respiration';

  @override
  String get practiceTimer => 'Minuteur';

  @override
  String get practiceGame => 'Wave dodge';

  @override
  String get practiceCustom => 'Personnalisé';

  @override
  String get snackbarEmotionSaved => 'Émotion enregistrée';

  @override
  String get snackbarEmotionRemoved => 'Entrée supprimée';

  @override
  String get snackbarPracticeSaved => 'Pratique ajoutée';

  @override
  String get logTitle => 'Journal des émotions';

  @override
  String get logFilterLabel => 'Filtres';

  @override
  String get logFilterAll => 'Tout';

  @override
  String get logSearchHint => 'Rechercher dans les notes';

  @override
  String get logEmpty => 'Aucune entrée pour ce filtre';

  @override
  String get statsTitle => 'Aperçus';

  @override
  String get statsDistribution => 'Répartition des émotions';

  @override
  String get statsMoodTrend => 'Tendance de l\'humeur';

  @override
  String get statsPracticeMinutes => 'Minutes de pratique';

  @override
  String get statsRange7 => '7 jours';

  @override
  String get statsRange30 => '30 jours';

  @override
  String get statsRange90 => '90 jours';

  @override
  String get calmPlayBreathing => 'Respiration';

  @override
  String get calmPlayTimer => 'Minuteur';

  @override
  String get calmPlayGame => 'Mini-jeu';

  @override
  String get calmPlayInhale => 'Inspire';

  @override
  String get calmPlayHold => 'Bloque';

  @override
  String get calmPlayExhale => 'Expire';

  @override
  String get calmPlayStart => 'Démarrer';

  @override
  String get calmPlayPause => 'Pause';

  @override
  String get calmPlayResume => 'Reprendre';

  @override
  String get calmPlayStop => 'Arrêter';

  @override
  String get calmPlayAddMinutesTitle => 'Ajouter des minutes ?';

  @override
  String calmPlayAddMinutesBody(int minutes) {
    return 'Ajouter $minutes minutes de calme au journal ?';
  }

  @override
  String calmPlayElapsed(int minutes, int seconds) {
    return '$minutes min ${seconds}s';
  }

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsDailyGoal => 'Objectif quotidien de calme';

  @override
  String get settingsReminders => 'Rappels d\'émotions';

  @override
  String get settingsAddReminder => 'Ajouter un rappel';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsRateApp => 'Noter SoulTrack';

  @override
  String get settingsPrivacy => 'Politique de confidentialité';

  @override
  String get settingsAbout => 'À propos de SoulTrack';

  @override
  String get settingsRemindersDisabled => 'Rappels désactivés';

  @override
  String get settingsRemindersEnabled => 'Rappels activés';

  @override
  String get settingsDeleteAccountTitle => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountDescription =>
      'Supprimez définitivement votre profil et toutes les données enregistrées de cet appareil.';

  @override
  String get settingsDeleteAccountButton => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Supprimer le compte ?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Cela supprimera votre nom, vos objectifs, vos rappels ainsi que tout l’historique des émotions et des pratiques de cet appareil. Cette action est irréversible.';

  @override
  String get settingsDeleteAccountConfirmAction => 'Supprimer';

  @override
  String get settingsDeleteAccountSuccess => 'Les données de votre compte ont été supprimées.';

  @override
  String get privacyTitle => 'Politique de confidentialité';

  @override
  String get privacyBody =>
      'SoulTrack stocke tes données localement sur l\'appareil. Rien ne sort sans ton accord.';

  @override
  String get aboutTitle => 'À propos de SoulTrack';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutAuthor => 'Créé par Fazal';

  @override
  String get aboutContact => 'Support : fazalbinkaramat@gmail.com';

  @override
  String get aboutDisclaimer => 'SoulTrack n\'est pas un dispositif médical.';

  @override
  String get onboardingNameLabel => 'Comment devons-nous t\'appeler ?';

  @override
  String get onboardingNameHint => 'Entre ton prénom';

  @override
  String get onboardingNameValidation => 'Merci d\'indiquer ton prénom';

  @override
  String homeGreetingNamed(String name) {
    return 'Salut, $name';
  }

  @override
  String get settingsName => 'Ton prénom';

  @override
  String get settingsNameHint => 'Comment SoulTrack doit-il t\'appeler ?';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Par défaut système';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get emotionPeaceful => 'Paisible';

  @override
  String get settingsUsage => 'Conditions d\'utilisation';

  @override
  String get trackingPermissionTitle =>
      'Aidez-nous à comprendre ce qui fonctionne';

  @override
  String get trackingPermissionBody =>
      'Nous utilisons l’identifiant de votre appareil pour comprendre quelles publicités amènent des personnes vers CalmTrack. Cela nous permet de garder l’app gratuite et de nous concentrer sur les fonctionnalités que vous appréciez. Apple va maintenant vous demander si vous autorisez le suivi.';

  @override
  String get trackingPermissionButton => 'Continuer';

  @override
  String get trackingPermissionSettings =>
      'Vous pouvez modifier ce choix à tout moment dans Réglages > Confidentialité > Suivi.';
}
