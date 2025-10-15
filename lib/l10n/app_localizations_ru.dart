// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SoulTrack';

  @override
  String get actionNext => 'Далее';

  @override
  String get actionStart => 'Начать';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get actionAdd => 'Добавить';

  @override
  String get onboardingTitle1 => 'Отмечайте эмоции за три секунды';

  @override
  String get onboardingTitle2 => 'Снимайте стресс мини-играми';

  @override
  String get onboardingTitle3 => 'Наблюдайте свой прогресс';

  @override
  String get onboardingToggleReminders => 'Напоминать отмечать эмоции';

  @override
  String get onboardingDailyGoalLabel => 'Дневная цель спокойствия';

  @override
  String get onboardingDailyGoalSuffix => 'минут';

  @override
  String onboardingInitialGoal(int minutes) {
    return 'Initial goal set to $minutes minutes';
  }

  @override
  String get navHome => 'Домой';

  @override
  String get navStats => 'Статистика';

  @override
  String get navCalmPlay => 'Calm Play';

  @override
  String get homeGreeting => 'Привет';

  @override
  String homeToday(String date) {
    return 'Сегодня $date';
  }

  @override
  String get homePracticeProgress => 'Минуты спокойствия';

  @override
  String get homeHowFeeling => 'Как ты себя чувствуешь?';

  @override
  String get homeQuickPractice => 'Быстрая практика';

  @override
  String get homeRecentEntries => 'Записи за сегодня';

  @override
  String get homeAddNoteTitle => 'Добавить заметку';

  @override
  String get homeAddNoteHint => 'Что повлияло на эмоцию?';

  @override
  String get homePlayCta => 'Поиграть, чтобы расслабиться';

  @override
  String get homeCustomMinutes => 'Свои минуты';

  @override
  String get homeCustomMinutesHint => 'Сколько минут?';

  @override
  String get homeNoEntries => 'Записей пока нет';

  @override
  String get homeViewLog => 'Открыть журнал';

  @override
  String homeGoalRemaining(int minutes) {
    return 'Осталось $minutes мин';
  }

  @override
  String get emotionJoyful => 'Радостно';

  @override
  String get emotionPleasant => 'Приятно';

  @override
  String get emotionNeutral => 'Нейтрально';

  @override
  String get emotionUncertain => 'Неуверенно';

  @override
  String get emotionAngry => 'Раздраженно';

  @override
  String get emotionSleepy => 'Сонно';

  @override
  String get emotionSad => 'Грустно';

  @override
  String get emotionExcited => 'Взволнованно';

  @override
  String get practiceBreathing => 'Дыхание';

  @override
  String get practiceTimer => 'Таймер';

  @override
  String get practiceGame => 'Wave dodge';

  @override
  String get practiceCustom => 'Своя';

  @override
  String get snackbarEmotionSaved => 'Эмоция сохранена';

  @override
  String get snackbarEmotionRemoved => 'Запись удалена';

  @override
  String get snackbarPracticeSaved => 'Практика добавлена';

  @override
  String get logTitle => 'Журнал эмоций';

  @override
  String get logFilterLabel => 'Фильтры';

  @override
  String get logFilterAll => 'Все';

  @override
  String get logSearchHint => 'Поиск по заметкам';

  @override
  String get logEmpty => 'Нет записей для такого фильтра';

  @override
  String get statsTitle => 'Аналитика';

  @override
  String get statsDistribution => 'Распределение эмоций';

  @override
  String get statsMoodTrend => 'Динамика настроения';

  @override
  String get statsPracticeMinutes => 'Минуты практик';

  @override
  String get statsRange7 => '7 дней';

  @override
  String get statsRange30 => '30 дней';

  @override
  String get statsRange90 => '90 дней';

  @override
  String get calmPlayBreathing => 'Дыхание';

  @override
  String get calmPlayTimer => 'Таймер';

  @override
  String get calmPlayGame => 'Мини-игра';

  @override
  String get calmPlayInhale => 'Вдох';

  @override
  String get calmPlayHold => 'Задержка';

  @override
  String get calmPlayExhale => 'Выдох';

  @override
  String get calmPlayStart => 'Старт';

  @override
  String get calmPlayPause => 'Пауза';

  @override
  String get calmPlayResume => 'Продолжить';

  @override
  String get calmPlayStop => 'Стоп';

  @override
  String get calmPlayAddMinutesTitle => 'Добавить минуты?';

  @override
  String calmPlayAddMinutesBody(int minutes) {
    return 'Добавить $minutes минут спокойствия в журнал?';
  }

  @override
  String calmPlayElapsed(int minutes, int seconds) {
    return '$minutes мин $secondsс';
  }

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsDailyGoal => 'Дневная цель спокойствия';

  @override
  String get settingsReminders => 'Напоминания';

  @override
  String get settingsAddReminder => 'Добавить напоминание';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSystem => 'Системная';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsRateApp => 'Оценить SoulTrack';

  @override
  String get settingsPrivacy => 'Политика конфиденциальности';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsRemindersDisabled => 'Напоминания выключены';

  @override
  String get settingsRemindersEnabled => 'Напоминания включены';

  @override
  String get privacyTitle => 'Политика конфиденциальности';

  @override
  String get privacyBody =>
      'SoulTrack хранит записи локально на устройстве. Данные не покидают телефон без твоего согласия.';

  @override
  String get aboutTitle => 'О SoulTrack';

  @override
  String aboutVersion(String version) {
    return 'Версия $version';
  }

  @override
  String get aboutAuthor => 'Создано Fazal';

  @override
  String get aboutContact => 'Поддержка: fazalbinkaramat@gmail.com';

  @override
  String get aboutDisclaimer => 'SoulTrack не является медицинским изделием.';

  @override
  String get onboardingNameLabel => 'Как тебя называть?';

  @override
  String get onboardingNameHint => 'Введите имя';

  @override
  String get onboardingNameValidation => 'Пожалуйста, укажите имя';

  @override
  String homeGreetingNamed(String name) {
    return 'Привет, $name';
  }

  @override
  String get settingsName => 'Твоё имя';

  @override
  String get settingsNameHint => 'Как обращаться к тебе?';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'Как в системе';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get emotionPeaceful => 'Спокойно';

  @override
  String get settingsUsage => 'Правила использования';

  @override
  String get trackingPermissionTitle => 'Помогите нам понять, что работает';

  @override
  String get trackingPermissionBody =>
      'Мы используем идентификатор устройства, чтобы понимать, какие объявления приводят пользователей в CalmTrack. Это помогает оставаться приложению бесплатным и развивать нужные функции. Сейчас Apple попросит разрешить отслеживание.';

  @override
  String get trackingPermissionButton => 'Продолжить';

  @override
  String get trackingPermissionSettings =>
      'Вы можете изменить решение в любой момент: Настройки > Конфиденциальность > Отслеживание.';
}
