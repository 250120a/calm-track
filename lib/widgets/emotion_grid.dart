import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

import '../models/emotion_type.dart';
import '../utils/localized_texts.dart';
import 'glass_container.dart';

class EmotionGrid extends StatelessWidget {
  const EmotionGrid({
    super.key,
    required this.onSelected,
    this.emotions = EmotionType.values,
  });

  final List<EmotionType> emotions;
  final ValueChanged<EmotionType> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final items = emotions.take(9).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final emotion = items[index];
        return GlassContainer(
          borderRadius: BorderRadius.circular(22),
          // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          onTap: () => onSelected(emotion),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: emotion.color.withValues(alpha: 0.18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(emotion.asset, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                emotion.label(l10n),
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
