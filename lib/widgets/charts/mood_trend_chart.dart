import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app1/l10n/app_localizations.dart';

import '../../providers/emotion_provider.dart';
import '../../style/app_colors.dart';

class MoodTrendChart extends StatelessWidget {
  const MoodTrendChart({
    super.key,
    required this.points,
  });

  final List<DailyMoodPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context).homeNoEntries),
      );
    }
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8, right: 16),
        child: CustomPaint(
          painter: _MoodTrendPainter(points),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _MoodTrendPainter extends CustomPainter {
  _MoodTrendPainter(this.points);

  final List<DailyMoodPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    final sorted = List<DailyMoodPoint>.of(points)
      ..sort((a, b) => a.date.compareTo(b.date));
    final minScore = sorted.fold<double>(double.infinity, (value, element) => min(value, element.score));
    final maxScore = sorted.fold<double>(-double.infinity, (value, element) => max(value, element.score));
    final range = (maxScore - minScore).clamp(1.0, double.infinity);
    final minDate = sorted.first.date;
    final maxDate = sorted.last.date;
    final totalDays = max(1, maxDate.difference(minDate).inDays);
    final path = Path();
    for (var i = 0; i < sorted.length; i++) {
      final point = sorted[i];
      final x = size.width * (point.date.difference(minDate).inDays / totalDays);
      final normalized = (point.score - minScore) / range;
      final y = size.height - normalized * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      final dotPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);
    final baselinePaint = Paint()
      ..color = AppColors.wave
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), baselinePaint);
  }

  @override
  bool shouldRepaint(covariant _MoodTrendPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
