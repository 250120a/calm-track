import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

import '../../models/emotion_type.dart';
import '../../style/app_colors.dart';

class EmotionDistributionChart extends StatelessWidget {
  const EmotionDistributionChart({
    super.key,
    required this.data,
  });

  final Map<EmotionType, int> data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = data.values.fold<int>(0, (sum, value) => sum + value);
    if (total == 0) {
      return Center(
        child: Text(
          l10n.homeNoEntries,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return Column(
      children: data.entries.map((entry) {
        final percent = entry.value / total;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                child: Image.asset(
                  entry.key.asset,
                  height: 32,
                  width: 32,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.wave,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percent,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: entry.key.color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 48,
                child: Text('${(percent * 100).round()}%', textAlign: TextAlign.end),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
