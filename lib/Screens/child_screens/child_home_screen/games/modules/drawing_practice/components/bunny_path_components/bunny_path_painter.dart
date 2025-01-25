import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BunnyPathPainter extends CustomPainter {
  final List<Offset> userPath;
  final bool pathCompleted;
  final bool validStart;

  BunnyPathPainter({
    required this.userPath,
    this.pathCompleted = false,
    this.validStart = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawGuidePath(canvas, size);
    _drawUserPath(canvas);
  }

  void _drawGuidePath(Canvas canvas, Size size) {
    final guidePath = Path();
    guidePath.moveTo(size.width * 0.5, size.height * 0.85);
    guidePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.15,
    );

    // Draw main guide path
    final guidePathPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 40
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(guidePath, guidePathPaint);

    // Draw dots along the path
    final dotPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4;

    final metric = guidePath.computeMetrics().first;
    final length = metric.length;
    final spacing = 20.0;

    for (double i = 0; i < length; i += spacing) {
      final pos = metric.getTangentForOffset(i)?.position;
      if (pos != null) {
        canvas.drawCircle(pos, 2, dotPaint);
      }
    }
  }

  void _drawUserPath(Canvas canvas) {
    if (userPath.length > 1) {
      final paint = Paint()
        ..color = pathCompleted
            ? AppTheme.childSoftGreen
            : (validStart
                ? AppTheme.childTurquoise
                : Colors.red.withOpacity(0.5))
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < userPath.length - 1; i++) {
        canvas.drawLine(userPath[i], userPath[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BunnyPathPainter oldDelegate) {
    return oldDelegate.userPath != userPath ||
        oldDelegate.pathCompleted != pathCompleted ||
        oldDelegate.validStart != validStart;
  }
}
