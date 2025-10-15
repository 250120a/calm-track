import 'dart:math';

import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class ProgressWaveIndicator extends StatelessWidget {
  const ProgressWaveIndicator({
    super.key,
    required this.progress,
    required this.title,
    required this.valueText,
    this.size = 160,
  });

  final double progress;
  final String title;
  final String valueText;
  final double size;

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? Colors.white : AppColors.textPrimary;
    final textSecondary = isDark ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondary;
    final background = isDark ? Colors.white.withValues(alpha: 0.14) : Colors.white.withValues(alpha: 0.85);
    final waveColor = isDark ? AppColors.secondary.withValues(alpha: 0.25) : AppColors.wave.withValues(alpha: 0.8);
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.35) : AppColors.primary.withValues(alpha: 0.7);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _WavePainter(
              clampedProgress,
              background: background,
              waveColor: waveColor,
              borderColor: borderColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valueText,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter(
    this.progress, {
    required this.background,
    required this.waveColor,
    required this.borderColor,
  });

  final double progress;
  final Color background;
  final Color waveColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final circle = Paint()
      ..color = background
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circle);
    final clipPath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.save();
    canvas.clipPath(clipPath);
    final waveHeight = size.height * (1 - progress);
    final wavePaint = Paint()..color = waveColor;
    final path = Path();
    const waveCount = 1.5;
    path.moveTo(0, waveHeight);
    for (double x = 0; x <= size.width; x++) {
      final y = waveHeight + sin((x / size.width) * waveCount * 2 * pi) * 12;
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, wavePaint);
    canvas.restore();
    final border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius - 1.5, border);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
