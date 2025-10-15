import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/emotion_provider.dart';
import '../providers/practice_provider.dart';
import '../widgets/charts/emotion_distribution_chart.dart';
import '../widgets/charts/mood_trend_chart.dart';
import '../widgets/charts/practice_minutes_chart.dart';
import '../widgets/glass_container.dart';
import '../widgets/range_selector.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _range = 7;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emotionProvider = context.watch<EmotionProvider>();
    final practiceProvider = context.watch<PracticeProvider>();
    final start = DateTime.now().subtract(Duration(days: _range - 1));
    final distribution = emotionProvider.distributionSince(start);
    final moodPoints = emotionProvider.moodTrendSince(start);
    final practiceData = practiceProvider.minutesByDaySince(start);
    final labels = {
      7: l10n.statsRange7,
      30: l10n.statsRange30,
      90: l10n.statsRange90,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          RangeSelector(
            selected: _range,
            labels: labels,
            onChanged: (value) => setState(() => _range = value),
          ),
          const SizedBox(height: 24),
          _StatsCard(
            title: l10n.statsDistribution,
            child: EmotionDistributionChart(data: distribution),
          ),
          const SizedBox(height: 16),
          _StatsCard(
            title: l10n.statsMoodTrend,
            child: MoodTrendChart(points: moodPoints),
          ),
          const SizedBox(height: 16),
          _StatsCard(
            title: l10n.statsPracticeMinutes,
            child: PracticeMinutesChart(data: practiceData),
          ),
           const SizedBox(height: 120),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
