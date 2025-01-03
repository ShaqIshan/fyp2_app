import 'package:flutter/material.dart';

/// Class to hold both a Path and its associated Paint style
class PathWithStyle {
  final Path path;
  final Paint paint;

  PathWithStyle({
    required this.path,
    required this.paint,
  });
}

class HeadColoringHelpers {
  /// Creates a basic Paint object for coloring
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

  /// Creates a PathWithStyle object from a point and paint settings
  static PathWithStyle createPathWithStyle({
    required Offset point,
    required Color color,
    required double strokeWidth,
  }) {
    final path = Path()..moveTo(point.dx, point.dy);
    final paint = createPaint(
      color: color,
      strokeWidth: strokeWidth,
    );

    return PathWithStyle(path: path, paint: paint);
  }

  /// Updates a PathWithStyle with a new point
  static void addPointToPath(PathWithStyle pathWithStyle, Offset point) {
    pathWithStyle.path.lineTo(point.dx, point.dy);
  }

  /// Simplifies a list of points to reduce unnecessary points
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

  /// Creates a smooth path from a list of points using Bezier curves
  static Path createSmoothPath(List<Offset> points) {
    if (points.isEmpty) return Path();
    if (points.length == 1) {
      return Path()..moveTo(points[0].dx, points[0].dy);
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      if (i == points.length - 2) {
        path.lineTo(next.dx, next.dy);
      } else {
        final controlPoint = Offset(
          (current.dx + next.dx) / 2,
          (current.dy + next.dy) / 2,
        );
        path.quadraticBezierTo(
          current.dx,
          current.dy,
          controlPoint.dx,
          controlPoint.dy,
        );
      }
    }

    return path;
  }

  /// Creates a PathWithStyle with a smooth path from points
  static PathWithStyle createSmoothPathWithStyle({
    required List<Offset> points,
    required Color color,
    required double strokeWidth,
  }) {
    return PathWithStyle(
      path: createSmoothPath(points),
      paint: createPaint(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }

  /// Helper method to draw a PathWithStyle on a Canvas
  static void drawPathWithStyle(Canvas canvas, PathWithStyle pathWithStyle) {
    canvas.drawPath(pathWithStyle.path, pathWithStyle.paint);
  }

  /// Helper method to check if a point is near a path
  static bool isPointNearPath(Path path, Offset point, double threshold) {
    final bounds = path.getBounds();
    if (!bounds.inflate(threshold).contains(point)) return false;

    for (double t = 0; t <= 1; t += 0.01) {
      final metric = path.computeMetrics().first;
      final tangent = metric.getTangentForOffset(metric.length * t);
      if (tangent != null) {
        final distance = (tangent.position - point).distance;
        if (distance < threshold) return true;
      }
    }
    return false;
  }

  /// Helper method to get the bounding box of a path
  static Rect getPathBounds(Path path) {
    return path.getBounds();
  }
}
