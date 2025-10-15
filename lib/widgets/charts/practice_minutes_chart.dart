import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../style/app_colors.dart';

class PracticeMinutesChart extends StatelessWidget {
  const PracticeMinutesChart({
    super.key,
    required this.data,
  });

  final Map<DateTime, int> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context).homeNoEntries),
      );
    }
    final formatter = DateFormat.Md();
    final maxMinutes = data.values.isEmpty ? 0 : data.values.reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.entries.map((entry) {
          final heightFactor = maxMinutes == 0 ? 0.1 : entry.value / maxMinutes;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 140 * heightFactor,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatter.format(entry.key),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
