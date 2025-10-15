import 'package:app1/l10n/app_localizations.dart';

import '../models/emotion_type.dart';
import '../models/practice_kind.dart';

extension EmotionTypeLocalization on EmotionType {
  String label(AppLocalizations l10n) {
    switch (this) {
      case EmotionType.joyful:
        return l10n.emotionJoyful;
      case EmotionType.pleasant:
        return l10n.emotionPleasant;
      case EmotionType.neutral:
        return l10n.emotionNeutral;
      case EmotionType.uncertain:
        return l10n.emotionUncertain;
      case EmotionType.angry:
        return l10n.emotionAngry;
      case EmotionType.sleepy:
        return l10n.emotionSleepy;
      case EmotionType.sad:
        return l10n.emotionSad;
      case EmotionType.excited:
        return l10n.emotionExcited;
      case EmotionType.peaceful:
        return l10n.emotionPeaceful;
    }
  }
}

extension PracticeKindLocalization on PracticeKind {
  String label(AppLocalizations l10n) {
    switch (this) {
      case PracticeKind.breathing:
        return l10n.practiceBreathing;
      case PracticeKind.timer:
        return l10n.practiceTimer;
      case PracticeKind.game:
        return l10n.practiceGame;
      case PracticeKind.custom:
        return l10n.practiceCustom;
    }
  }
}
