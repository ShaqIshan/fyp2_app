import 'package:flutter/material.dart';

abstract class HeadBaseCanvas extends StatefulWidget {
  final double width;
  final double height;
  final Color currentColor;
  final double strokeWidth;
  final VoidCallback? onComplete;

  const HeadBaseCanvas({
    super.key,
    required this.width,
    required this.height,
    required this.currentColor,
    required this.strokeWidth,
    this.onComplete,
  });

  @override
  HeadBaseCanvasState createState();
}

abstract class HeadBaseCanvasState<T extends HeadBaseCanvas> extends State<T> {
  final List<List<Offset>> paths = [];
  final List<Paint> paints = [];
  List<Offset>? currentPath;
  Paint? currentPaint;

  void onPanStart(DragStartDetails details) {
    setState(() {
      currentPath = [details.localPosition];
      currentPaint = Paint()
        ..color = widget.currentColor
        ..strokeWidth = widget.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      currentPath?.add(details.localPosition);
    });
  }

  void onPanEnd(DragEndDetails details) {
    if (currentPath != null && currentPaint != null) {
      setState(() {
        paths.add(currentPath!);
        paints.add(currentPaint!);
        currentPath = null;
        currentPaint = null;
      });
    }
  }

  CustomPainter createPainter();

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
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          child: CustomPaint(
            painter: createPainter(),
            size: Size(widget.width, widget.height),
          ),
        ),
      ),
    );
  }
}

abstract class BaseAnimalPainter extends CustomPainter {
  final List<List<Offset>> paths;
  final List<Paint> paints;
  final List<Offset>? currentPath;
  final Paint? currentPaint;

  BaseAnimalPainter({
    required this.paths,
    required this.paints,
    this.currentPath,
    this.currentPaint,
  });

  void drawOutline(Canvas canvas, Size size, Paint paint);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the animal outline
    drawOutline(canvas, size, paint);

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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
