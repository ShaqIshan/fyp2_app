import 'dart:math';

import 'package:flutter/material.dart';

class CuteAnimalsCanvas extends StatefulWidget {
  final String animal;
  final double width;
  final double height;
  final Color currentColor;
  final double strokeWidth;
  final VoidCallback? onComplete;

  const CuteAnimalsCanvas({
    Key? key,
    required this.animal,
    required this.width,
    required this.height,
    required this.currentColor,
    required this.strokeWidth,
    this.onComplete,
  }) : super(key: key);

  @override
  State<CuteAnimalsCanvas> createState() => _CuteAnimalsCanvasState();
}

class _CuteAnimalsCanvasState extends State<CuteAnimalsCanvas> {
  final List<List<Offset>> _paths = [];
  final List<Paint> _paints = [];
  List<Offset>? _currentPath;
  Paint? _currentPaint;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _currentPath = [details.localPosition];
      _currentPaint = Paint()
        ..color = widget.currentColor
        ..strokeWidth = widget.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentPath?.add(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentPath != null && _currentPaint != null) {
      setState(() {
        _paths.add(_currentPath!);
        _paints.add(_currentPaint!);
        _currentPath = null;
        _currentPaint = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: CustomPaint(
            painter: AnimalPainter(
              animal: widget.animal,
              paths: _paths,
              paints: _paints,
              currentPath: _currentPath,
              currentPaint: _currentPaint,
            ),
            size: Size(widget.width, widget.height),
          ),
        ),
      ),
    );
  }
}

class AnimalPainter extends CustomPainter {
  final String animal;
  final List<List<Offset>> paths;
  final List<Paint> paints;
  final List<Offset>? currentPath;
  final Paint? currentPaint;

  AnimalPainter({
    required this.animal,
    required this.paths,
    required this.paints,
    this.currentPath,
    this.currentPaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the base animal outline
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the cat outline (you can add more animals later)
    if (animal == 'cat') {
      _drawCat(canvas, size, paint);
    }

    // Draw all completed paths
    for (int i = 0; i < paths.length; i++) {
      final path = Path();
      if (paths[i].isEmpty) continue;

      path.moveTo(paths[i].first.dx, paths[i].first.dy);
      for (int j = 1; j < paths[i].length; j++) {
        path.lineTo(paths[i][j].dx, paths[i][j].dy);
      }
      canvas.drawPath(path, paints[i]);
    }

    // Draw current path if it exists
    if (currentPath != null &&
        currentPath!.isNotEmpty &&
        currentPaint != null) {
      final path = Path();
      path.moveTo(currentPath!.first.dx, currentPath!.first.dy);
      for (int i = 1; i < currentPath!.length; i++) {
        path.lineTo(currentPath![i].dx, currentPath![i].dy);
      }
      canvas.drawPath(path, currentPaint!);
    }
  }

  void _drawCat(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    // Head oval shape
    final headCenter = Offset(size.width * 0.5, size.height * 0.4);
    final headWidth = size.width * 0.5;
    final headHeight = size.width * 0.45;
    final headRect = Rect.fromCenter(
      center: headCenter,
      width: headWidth,
      height: headHeight,
    );
    canvas.drawOval(headRect, paint);

    // Triangular ears
    final leftEar = Path()
      ..moveTo(size.width * 0.35, size.height * 0.2)
      ..lineTo(size.width * 0.45, size.height * 0.2)
      ..lineTo(size.width * 0.4, size.height * 0.1)
      ..close();
    canvas.drawPath(leftEar, paint);

    final rightEar = Path()
      ..moveTo(size.width * 0.55, size.height * 0.2)
      ..lineTo(size.width * 0.65, size.height * 0.2)
      ..lineTo(size.width * 0.6, size.height * 0.1)
      ..close();
    canvas.drawPath(rightEar, paint);

    // Eyes
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(headCenter.dx - headWidth * 0.2, headCenter.dy),
      headWidth * 0.12,
      paint,
    );
    canvas.drawCircle(
      Offset(headCenter.dx + headWidth * 0.2, headCenter.dy),
      headWidth * 0.12,
      paint,
    );

    // Eye highlights
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(
          headCenter.dx - headWidth * 0.17, headCenter.dy - headHeight * 0.1),
      headWidth * 0.04,
      highlightPaint,
    );
    canvas.drawCircle(
      Offset(
          headCenter.dx + headWidth * 0.17, headCenter.dy - headHeight * 0.1),
      headWidth * 0.04,
      highlightPaint,
    );

    // Whiskers
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;

    // Left whiskers
    canvas.drawLine(
      Offset(headCenter.dx - headWidth * 0.5, headCenter.dy + headHeight * 0.1),
      Offset(headCenter.dx - headWidth * 0.2, headCenter.dy + headHeight * 0.1),
      paint,
    );
    canvas.drawLine(
      Offset(headCenter.dx - headWidth * 0.5, headCenter.dy + headHeight * 0.2),
      Offset(headCenter.dx - headWidth * 0.2, headCenter.dy + headHeight * 0.2),
      paint,
    );

    // Right whiskers
    canvas.drawLine(
      Offset(headCenter.dx + headWidth * 0.5, headCenter.dy + headHeight * 0.1),
      Offset(headCenter.dx + headWidth * 0.2, headCenter.dy + headHeight * 0.1),
      paint,
    );
    canvas.drawLine(
      Offset(headCenter.dx + headWidth * 0.5, headCenter.dy + headHeight * 0.2),
      Offset(headCenter.dx + headWidth * 0.2, headCenter.dy + headHeight * 0.2),
      paint,
    );

    // Simple smile
    paint.strokeWidth = 4.0;
    final smile = Path()
      ..moveTo(
          headCenter.dx - headWidth * 0.1, headCenter.dy + headHeight * 0.2)
      ..quadraticBezierTo(
        headCenter.dx,
        headCenter.dy + headHeight * 0.3,
        headCenter.dx + headWidth * 0.1,
        headCenter.dy + headHeight * 0.2,
      );
    canvas.drawPath(smile, paint);

    // Body
    final bodyPath = Path()
      // Start wider at top, just below head
      ..moveTo(headCenter.dx - (headWidth * .3), headCenter.dy + headHeight / 2)
      // Straight line across top, keeping width
      ..lineTo(headCenter.dx + (headWidth * .3), headCenter.dy + headHeight / 2)
      // Right curved side that comes in
      ..quadraticBezierTo(
          headCenter.dx + (headWidth * 1.2),
          headCenter.dy + (headHeight * 2),
          headCenter.dx + (headWidth * 0.5),
          headCenter.dy + (headHeight * 2))
      // Bottom curve
      ..quadraticBezierTo(headCenter.dx, headCenter.dy + (headHeight * 2),
          headCenter.dx - (headWidth * 0.5), headCenter.dy + (headHeight * 2))
      // Left curved side
      ..quadraticBezierTo(
          headCenter.dx - (headWidth * 1),
          headCenter.dy + (headHeight * 2),
          headCenter.dx - (headWidth * .3),
          headCenter.dy + headHeight / 2);
    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
