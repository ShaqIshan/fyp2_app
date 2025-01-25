import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class StarPathPainter extends CustomPainter {
  final List<Offset> points;
  final List<List<Offset>> completedLines;
  final bool showDebugGrid;
  final List<Offset> starPositions;
  final bool isValidConnection;

  StarPathPainter({
    required this.points,
    required this.completedLines,
    required this.starPositions,
    this.showDebugGrid = false,
    this.isValidConnection = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (showDebugGrid) {
      _drawDebugGrid(canvas, size);
    }

    _drawStars(canvas);
    _drawCompletedLines(canvas);

    if (points.length >= 2) {
      _drawCurrentLine(canvas);
    }
  }

  void _drawDebugGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += 50) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    for (double y = 0; y <= size.height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
  }

  void _drawStars(Canvas canvas) {
    final starPaint = Paint()
      ..color = AppTheme.childYellow
      ..style = PaintingStyle.fill;

    for (var position in starPositions) {
      // Draw star glow
      final glowPaint = Paint()
        ..color = AppTheme.childYellow.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(position, 15, glowPaint);
      canvas.drawCircle(position, 10, starPaint);
    }
  }

  void _drawCompletedLines(Canvas canvas) {
    final completedPaint = Paint()
      ..color = AppTheme.childSoftGreen
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (var line in completedLines) {
      for (int i = 0; i < line.length - 1; i++) {
        canvas.drawLine(line[i], line[i + 1], completedPaint);
      }
    }
  }

  void _drawCurrentLine(Canvas canvas) {
    final currentPaint = Paint()
      ..color = isValidConnection
          ? AppTheme.childTurquoise
          : Colors.red.withOpacity(0.5)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], currentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPathPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.completedLines != completedLines ||
        oldDelegate.starPositions != starPositions ||
        oldDelegate.isValidConnection != isValidConnection;
  }
}
