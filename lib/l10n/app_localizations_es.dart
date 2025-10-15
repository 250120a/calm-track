// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SoulTrack';

  @override
  String get actionNext => 'Siguiente';

  @override
  String get actionStart => 'Comenzar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionAdd => 'Agregar';

  @override
  String get onboardingTitle1 => 'Registra tus emociones en tres toques';

  @override
  String get onboardingTitle2 => 'Reduce el estrés con juegos conscientes';

  @override
  String get onboardingTitle3 => 'Observa tu progreso crecer';

  @override
  String get onboardingToggleReminders => 'Recuérdame registrar mis emociones';

  @override
  String get onboardingDailyGoalLabel => 'Meta diaria de calma';

  @override
  String get onboardingDailyGoalSuffix => 'minutos';

  @override
  String onboardingInitialGoal(int minutes) {
    return 'Initial goal set to $minutes minutes';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navStats => 'Estadísticas';

  @override
  String get navCalmPlay => 'Calm Play';

  @override
  String get homeGreeting => 'Hola';

  @override
  String homeToday(String date) {
    return 'Hoy es $date';
  }

  @override
  String get homePracticeProgress => 'Minutos de calma';

  @override
  String get homeHowFeeling => '¿Cómo te sientes?';

  @override
  String get homeQuickPractice => 'Calma rápida';

  @override
  String get homeRecentEntries => 'Registro de hoy';

  @override
  String get homeAddNoteTitle => 'Añade una nota';

  @override
  String get homeAddNoteHint => '¿Qué influyó en esta emoción?';

  @override
  String get homePlayCta => 'Jugar para relajarse';

  @override
  String get homeCustomMinutes => 'Minutos personalizados';

  @override
  String get homeCustomMinutesHint => '¿Cuántos minutos?';

  @override
  String get homeNoEntries => 'Sin entradas todavía';

  @override
  String get homeViewLog => 'Ver registro';

  @override
  String homeGoalRemaining(int minutes) {
    return 'Quedan $minutes min';
  }

  @override
  String get emotionJoyful => 'Alegre';

  @override
  String get emotionPleasant => 'Contento';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionUncertain => 'Incierto';

  @override
  String get emotionAngry => 'Frustrado';

  @override
  String get emotionSleepy => 'Somnoliento';

  @override
  String get emotionSad => 'Bajo';

  @override
  String get emotionExcited => 'Entusiasmado';

  @override
  String get practiceBreathing => 'Respiración';

  @override
  String get practiceTimer => 'Temporizador';

  @override
  String get practiceGame => 'Wave dodge';

  @override
  String get practiceCustom => 'Personalizado';

  @override
  String get snackbarEmotionSaved => 'Emoción guardada';

  @override
  String get snackbarEmotionRemoved => 'Entrada eliminada';

  @override
  String get snackbarPracticeSaved => 'Práctica añadida';

  @override
  String get logTitle => 'Registro de emociones';

  @override
  String get logFilterLabel => 'Filtros';

  @override
  String get logFilterAll => 'Todo';

  @override
  String get logSearchHint => 'Buscar notas';

  @override
  String get logEmpty => 'No hay entradas para este filtro';

  @override
  String get statsTitle => 'Ideas';

  @override
  String get statsDistribution => 'Distribución de emociones';

  @override
  String get statsMoodTrend => 'Tendencia del ánimo';

  @override
  String get statsPracticeMinutes => 'Minutos de práctica';

  @override
  String get statsRange7 => '7 días';

  @override
  String get statsRange30 => '30 días';

  @override
  String get statsRange90 => '90 días';

  @override
  String get calmPlayBreathing => 'Respirar';

  @override
  String get calmPlayTimer => 'Temporizador';

  @override
  String get calmPlayGame => 'Mini-juego';

  @override
  String get calmPlayInhale => 'Inhala';

  @override
  String get calmPlayHold => 'Mantén';

  @override
  String get calmPlayExhale => 'Exhala';

  @override
  String get calmPlayStart => 'Iniciar';

  @override
  String get calmPlayPause => 'Pausar';

  @override
  String get calmPlayResume => 'Reanudar';

  @override
  String get calmPlayStop => 'Detener';

  @override
  String get calmPlayAddMinutesTitle => '¿Añadir minutos?';

  @override
  String calmPlayAddMinutesBody(int minutes) {
    return '¿Agregar $minutes minutos de calma a tu registro?';
  }

  @override
  String calmPlayElapsed(int minutes, int seconds) {
    return '$minutes min ${seconds}s';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsDailyGoal => 'Meta diaria de calma';

  @override
  String get settingsReminders => 'Recordatorios de emociones';

  @override
  String get settingsAddReminder => 'Añadir recordatorio';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsRateApp => 'Valorar SoulTrack';

  @override
  String get settingsPrivacy => 'Política de privacidad';

  @override
  String get settingsAbout => 'Acerca de SoulTrack';

  @override
  String get settingsRemindersDisabled => 'Recordatorios desactivados';

  @override
  String get settingsRemindersEnabled => 'Recordatorios activados';

  @override
  String get privacyTitle => 'Política de privacidad';

  @override
  String get privacyBody =>
      'SoulTrack guarda tus datos localmente en el dispositivo. Nunca salen de tu teléfono sin tu consentimiento.';

  @override
  String get aboutTitle => 'Acerca de SoulTrack';

  @override
  String aboutVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get aboutAuthor => 'Creado por Fazal';

  @override
  String get aboutContact => 'Soporte: fazalbinkaramat@gmail.com';

  @override
  String get aboutDisclaimer => 'SoulTrack no es un producto médico.';

  @override
  String get onboardingNameLabel => '¿Cómo debemos llamarte?';

  @override
  String get onboardingNameHint => 'Escribe tu nombre';

  @override
  String get onboardingNameValidation => 'Por favor, dinos tu nombre';

  @override
  String homeGreetingNamed(String name) {
    return 'Hola, $name';
  }

  @override
  String get settingsName => 'Tu nombre';

  @override
  String get settingsNameHint => '¿Cómo debe dirigirse SoulTrack a ti?';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Por defecto del sistema';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get emotionPeaceful => 'Tranquilo';

  @override
  String get settingsUsage => 'Condiciones de uso';

  @override
  String get trackingPermissionTitle => 'Ayúdanos a saber qué funciona';

  @override
  String get trackingPermissionBody =>
      'Usamos el identificador de tu dispositivo para entender qué anuncios llevan a las personas a CalmTrack. Esto mantiene la app gratuita y nos ayuda a centrarnos en las funciones que te gustan. Apple te preguntará ahora si permites el rastreo.';

  @override
  String get trackingPermissionButton => 'Continuar';

  @override
  String get trackingPermissionSettings =>
      'Puedes cambiarlo en cualquier momento en Ajustes > Privacidad > Seguimiento.';
}
