import 'package:flutter/material.dart';

class ColoringHelpers {
  /// Creates a paint object with standard coloring properties
  static Paint createPaint({
    required Color color,
    required double strokeWidth,
  }) {
    return Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  /// Creates an optimized path from a series of points
  static Path createOptimizedPath(List<Offset> points) {
    if (points.isEmpty) return Path();

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    // Use quadratic bezier curves for smoother lines
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];

      // Calculate control point as midpoint
      final controlPoint = Offset(
        (p0.dx + p1.dx) / 2,
        (p0.dy + p1.dy) / 2,
      );

      path.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        p1.dx,
        p1.dy,
      );
    }

    return path;
  }

  /// Performs path simplification by removing redundant points
  static List<Offset> simplifyPoints(List<Offset> points,
      {double tolerance = 2.0}) {
    if (points.length <= 2) return points;

    final result = <Offset>[points.first];

    for (int i = 1; i < points.length - 1; i++) {
      final prev = points[i - 1];
      final current = points[i];
      final next = points[i + 1];

      final d1 = (current - prev).distance;
      final d2 = (next - current).distance;

      if (d1 >= tolerance || d2 >= tolerance) {
        result.add(current);
      }
    }

    result.add(points.last);
    return result;
  }
}
