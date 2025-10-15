import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/practice_kind.dart';
import '../../providers/practice_provider.dart';

class TimerTab extends StatefulWidget {
  const TimerTab({super.key});

  @override
  State<TimerTab> createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _running = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final minutes = _elapsed.inMinutes;
    final seconds = _elapsed.inSeconds % 60;
    final elapsedLabel = l10n.calmPlayElapsed(minutes, seconds);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            elapsedLabel,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: _running ? _pause : _start,
                child: Text(_running ? l10n.calmPlayPause : l10n.calmPlayStart),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: _elapsed > Duration.zero ? _stop : null,
                child: Text(l10n.calmPlayStop),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed += const Duration(seconds: 1);
        _running = true;
      });
    });
    setState(() {
      _running = true;
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _running = false;
    });
  }

  Future<void> _stop() async {
    _timer?.cancel();
    setState(() {
      _running = false;
    });
    final minutes = (_elapsed.inSeconds / 60).ceil();
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final practiceProvider = context.read<PracticeProvider>();
    final shouldLog = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.calmPlayAddMinutesTitle),
          content: Text(l10n.calmPlayAddMinutesBody(minutes)),
          actions: [
            TextButton(
              onPressed: () => navigator.pop(false),
              child: Text(l10n.actionCancel),
            ),
            TextButton(
              onPressed: () => navigator.pop(true),
              child: Text(l10n.actionAdd),
            ),
          ],
        );
      },
    );
    if (shouldLog == true && minutes > 0) {
      await practiceProvider.addPractice(
        kind: PracticeKind.timer,
        minutes: minutes,
      );
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _elapsed = Duration.zero;
    });
  }
}
