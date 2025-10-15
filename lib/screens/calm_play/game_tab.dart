import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/practice_kind.dart';
import '../../providers/practice_provider.dart';

class GameTab extends StatefulWidget {
  const GameTab({super.key});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;
  int _elapsed = 0;
  bool _holding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final goalSeconds = 90;
    final remaining = max(0, goalSeconds - _elapsed);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text('${(remaining / 60).floor()}m ${(remaining % 60).toString().padLeft(2, '0')}s'),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = min(constraints.maxWidth, constraints.maxHeight);
                final radius = size / 2;
                return Center(
                  child: GestureDetector(
                    onPanStart: (details) => _handlePointer(details.localPosition, radius),
                    onPanUpdate: (details) => _handlePointer(details.localPosition, radius),
                    onPanEnd: (_) => _stopHolding(),
                    onPanCancel: _stopHolding,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          size: Size.square(size),
                          painter: _WaveGamePainter(_controller.value, holding: _holding),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.calmPlayGame),
        ],
      ),
    );
  }

  void _handlePointer(Offset position, double radius) {
    final distance = (position - Offset(radius, radius)).distance;
    if (distance <= radius * 0.6) {
      if (!_holding) {
        _startHolding();
      }
    } else {
      _stopHolding();
    }
  }

  void _startHolding() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      setState(() {
        _elapsed += 1;
      });
      if (_elapsed >= 90) {
        await _completeSession();
      }
    });
    setState(() {
      _holding = true;
    });
  }

  void _stopHolding() {
    _timer?.cancel();
    setState(() {
      _holding = false;
      _elapsed = 0;
    });
  }

  Future<void> _completeSession() async {
    _timer?.cancel();
    setState(() {
      _holding = false;
    });
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final practiceProvider = context.read<PracticeProvider>();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.calmPlayAddMinutesTitle),
          content: Text(l10n.calmPlayAddMinutesBody(3)),
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
    if (!mounted) {
      return;
    }
    if (result == true) {
      await practiceProvider.addPractice(
        kind: PracticeKind.game,
        minutes: 3,
      );
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _elapsed = 0;
    });
  }
}

class _WaveGamePainter extends CustomPainter {
  _WaveGamePainter(this.value, {required this.holding});

  final double value;
  final bool holding;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final basePaint = Paint()
      ..color = Colors.blueGrey.shade50
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 2, basePaint);
    final ringPaint = Paint()
      ..color = Colors.blueAccent.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    final waves = 3;
    for (var i = 1; i <= waves; i++) {
      final progress = (value + i / waves) % 1;
      final radius = (size.width / 2) * progress;
      canvas.drawCircle(center, radius, ringPaint);
    }
    if (holding) {
      final glowPaint = Paint()
        ..color = Colors.deepPurpleAccent.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, size.width * 0.3, glowPaint);
    }
    final targetPaint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width * 0.08, targetPaint);
  }

  @override
  bool shouldRepaint(covariant _WaveGamePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.holding != holding;
  }
}
