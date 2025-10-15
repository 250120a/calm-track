import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/emotion_type.dart';
import '../models/practice_kind.dart';
import '../providers/emotion_provider.dart';
import '../providers/prefs_provider.dart';
import '../providers/practice_provider.dart';
import '../widgets/emotion_entry_card.dart';
import '../widgets/emotion_grid.dart';
import '../widgets/glass_container.dart';
import '../widgets/practice_quick_actions.dart';
import '../widgets/progress_wave_indicator.dart';
import 'log.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onOpenCalmPlay});

  final VoidCallback onOpenCalmPlay;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = context.watch<PrefsProvider>();
    final practice = context.watch<PracticeProvider>();
    final emotionProvider = context.watch<EmotionProvider>();
    final userName = prefs.userName;
    final greeting = userName.isNotEmpty ? l10n.homeGreetingNamed(userName) : l10n.homeGreeting;
    final today = DateTime.now();
    final dateLabel = DateFormat.MMMMEEEEd().format(today);
    final minutesToday = practice.minutesForDay(today);
    final goal = prefs.dailyGoalMinutes;
    final progress = goal == 0 ? 0.0 : minutesToday / goal;
    final remaining = ((goal - minutesToday).clamp(0, goal)).toInt();
    final todaysEntries = emotionProvider.entriesForDay(today);
    return Scaffold(
      appBar: AppBar(
        title: Text(greeting),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await emotionProvider.load();
          await practice.load();
          await prefs.load();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            GlassContainer(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          l10n.homeToday(dateLabel),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton.filledTonal(
                        visualDensity: VisualDensity.compact,
                        tooltip: l10n.homeViewLog,
                        onPressed: _openLog,
                        icon: const Icon(Icons.subject),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProgressWaveIndicator(
                    progress: progress,
                    title: l10n.homePracticeProgress,
                    valueText: '$minutesToday/${prefs.dailyGoalMinutes}',
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.homeGoalRemaining(remaining),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeHowFeeling,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  EmotionGrid(
                    onSelected: (emotion) => _openNoteSheet(context, emotion),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeQuickPractice,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  PracticeQuickActions(
                    onAddMinutes: (minutes) => _addPractice(minutes),
                    onCustomTapped: () => _showCustomMinutesDialog(context),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: widget.onOpenCalmPlay,
                    icon: const Icon(Icons.spa_rounded),
                    label: Text(l10n.homePlayCta),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.homeRecentEntries,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EmotionLogScreen()),
                  ),
                  child: Text(l10n.homeViewLog),
                ),
              ],
            ),
            if (todaysEntries.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(l10n.homeNoEntries),
              )
            else
              ...todaysEntries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Dismissible(
                    key: ValueKey(entry.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _deleteEmotion(entry.id),
                    child: EmotionEntryCard(entry: entry),
                  ),
                ),
              ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  void _openLog() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EmotionLogScreen()),
    );
  }

  Future<void> _openNoteSheet(BuildContext context, EmotionType emotion) async {
    final l10n = AppLocalizations.of(context);
    final emotionProvider = context.read<EmotionProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final controller = TextEditingController();
    final note = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.homeAddNoteTitle,
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.homeAddNoteHint,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(sheetContext).pop(null),
                      child: Text(l10n.actionCancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.of(sheetContext).pop(controller.text.trim().isEmpty ? null : controller.text.trim()),
                      child: Text(l10n.actionSave),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    if (!mounted) {
      return;
    }
    await emotionProvider.addEmotion(type: emotion, note: note);
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.snackbarEmotionSaved)),
    );
  }

  Future<void> _deleteEmotion(String id) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final emotionProvider = context.read<EmotionProvider>();
    await emotionProvider.removeEmotion(id);
    if (!mounted) {
      return;
    }
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.snackbarEmotionRemoved)),
    );
  }

  Future<void> _addPractice(int minutes) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final practiceProvider = context.read<PracticeProvider>();
    await practiceProvider.addPractice(
      kind: PracticeKind.custom,
      minutes: minutes,
    );
    if (!mounted) {
      return;
    }
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.snackbarPracticeSaved)),
    );
  }

  Future<void> _showCustomMinutesDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final minutes = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.homeCustomMinutes),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: l10n.homeCustomMinutesHint),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.actionCancel),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                Navigator.of(context).pop(value);
              },
              child: Text(l10n.actionAdd),
            ),
          ],
        );
      },
    );
    if (minutes == null || minutes <= 0) {
      return;
    }
    await _addPractice(minutes);
  }
}
