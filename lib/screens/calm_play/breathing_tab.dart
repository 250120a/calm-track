import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

class BreathingTab extends StatefulWidget {
  const BreathingTab({super.key});

  @override
  State<BreathingTab> createState() => _BreathingTabState();
}

class _BreathingTabState extends State<BreathingTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 14));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final phase = _phaseLabel(l10n, _controller.value);
                final radius = _circleScale(_controller.value);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200 * radius,
                      height: 200 * radius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                          ],
                          stops: const [0.4, 1],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          phase,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _toggle,
            icon: Icon(_playing ? Icons.stop : Icons.play_arrow),
            label: Text(_playing ? l10n.calmPlayStop : l10n.calmPlayStart),
          ),
        ],
      ),
    );
  }

  void _toggle() {
    if (_playing) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
    setState(() {
      _playing = !_playing;
    });
  }

  String _phaseLabel(AppLocalizations l10n, double value) {
    const inhale = 4 / 14;
    const hold = 8 / 14;
    if (value < inhale) {
      return l10n.calmPlayInhale;
    }
    if (value < hold) {
      return l10n.calmPlayHold;
    }
    return l10n.calmPlayExhale;
  }

  double _circleScale(double value) {
    const inhaleEnd = 4 / 14;
    const holdEnd = 8 / 14;
    if (value < inhaleEnd) {
      return 0.6 + 0.4 * (value / inhaleEnd);
    }
    if (value < holdEnd) {
      return 1;
    }
    final progress = (value - holdEnd) / (1 - holdEnd);
    return max(0.6, 1 - 0.4 * progress);
  }
}
