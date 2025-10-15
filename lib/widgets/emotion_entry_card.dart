import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

import '../models/emotion_entry.dart';
import '../models/emotion_type.dart';
import '../utils/localized_texts.dart';
import 'glass_container.dart';

class EmotionEntryCard extends StatelessWidget {
  const EmotionEntryCard({
    super.key,
    required this.entry,
  });

  final EmotionEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final time = TimeOfDay.fromDateTime(entry.timestamp).format(context);
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: entry.type.color.withValues(alpha: 0.15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(entry.type.asset, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.type.label(l10n),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                if (entry.note != null && entry.note!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    entry.note!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
