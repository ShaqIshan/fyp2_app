import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../../../../../../child_wrapper.dart';
import '../../../../shared/components/completion_overlay.dart';
import '../../../../shared/wrapper/game_level_wrapper.dart';
import '../../components/star_shapes_components/star_path_painter.dart';
import '../../components/star_shapes_components/star_shapes_components.dart';
import '../../components/star_shapes_components/star_shapes_helpers.dart';

class StarShapesLevel extends StatefulWidget {
  final VoidCallback? onSuccess;
  final VoidCallback? onGameComplete;
  final Function(int)? onScoreUpdate; // Add score update callback

  final String currentShape;

  const StarShapesLevel({
    super.key,
    this.onSuccess,
    this.onGameComplete,
    this.onScoreUpdate, // Add this parameter

    required this.currentShape,
  });

  @override
  State<StarShapesLevel> createState() => _StarShapesLevelState();
}

class _StarShapesLevelState extends State<StarShapesLevel> {
  List<Offset> currentPoints = [];
  List<List<Offset>> completedLines = [];
  bool isDrawing = false;
  bool showSuccess = false;
  late List<Offset> starPositions;
  late List<List<Offset>> validConnections;
  bool isValidConnection = false;

  void _handlePanStart(DragStartDetails details, List<Offset> starPositions) {
    if (!mounted || showSuccess) return;
    final point = details.localPosition;
    final nearestStar = StarShapesHelpers.findNearestStar(point, starPositions);
    if (nearestStar != null) {
      setState(() {
        isDrawing = true;
        currentPoints = [nearestStar];
      });
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!mounted || !isDrawing || showSuccess) return;
    setState(() {
      currentPoints.add(details.localPosition);
      final connectedStars =
          StarShapesHelpers.findConnectedStars(currentPoints, starPositions);
      isValidConnection = connectedStars.length >= 2;
    });
  }

  void _handlePanEnd(
      List<Offset> starPositions, List<List<Offset>> validConnections) {
    if (!mounted || !isDrawing || currentPoints.isEmpty || showSuccess) {
      setState(() {
        isDrawing = false;
        currentPoints.clear();
        isValidConnection = false;
      });
      return;
    }

    final connectedStars =
        StarShapesHelpers.findConnectedStars(currentPoints, starPositions);
    final newConnections = StarShapesHelpers.validateConnections(
      connectedStars,
      validConnections,
      completedLines,
    );

    if (newConnections.isNotEmpty) {
      setState(() {
        completedLines.addAll(newConnections);
        if (StarShapesHelpers.isShapeComplete(
            completedLines, validConnections)) {
          showSuccess = true;
          _handleShapeCompletion();
        }
      });
    }

    setState(() {
      isDrawing = false;
      currentPoints.clear();
    });
  }

  void _handleShapeCompletion() {
    if (!mounted) return;

    if (widget.onScoreUpdate != null) {
      widget.onScoreUpdate!(3);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CompletionOverlay(
        data: CompletionData.fromType(
          CompletionType.shapes,
          isLastPuzzle: widget.currentShape == 'square',
        ),
        onPrimaryAction: () {
          // Pop dialog first
          Navigator.pop(context);

          if (widget.currentShape == 'square') {
            // For square (last shape), handle completion first
            if (widget.onGameComplete != null) {
              widget.onGameComplete!();
            }
            // Navigate back to child home
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ChildWrapper()),
              (route) => false,
            );
          } else {
            if (widget.onSuccess != null) {
              widget.onSuccess!();
            }
          }
        },
        onSecondaryAction: () {
          Navigator.pop(context);
          _resetLevel();
        },
      ),
    );
  }

  void _resetLevel() {
    if (!mounted) return;
    setState(() {
      currentPoints.clear();
      completedLines.clear();
      isDrawing = false;
      showSuccess = false;
      isValidConnection = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameLevelWrapper(
      title: 'Drawing Practice',
      isCompleted: showSuccess,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          starPositions = StarShapesHelpers.getStarPositionsForShape(
              size, widget.currentShape);
          validConnections = StarShapesHelpers.getValidConnectionsForShape(
              starPositions, widget.currentShape);

          return Stack(
            children: [
              GestureDetector(
                onPanStart: (details) =>
                    _handlePanStart(details, starPositions),
                onPanUpdate: (details) => _handlePanUpdate(details),
                onPanEnd: (details) =>
                    _handlePanEnd(starPositions, validConnections),
                child: CustomPaint(
                  painter: StarPathPainter(
                    points: currentPoints,
                    completedLines: completedLines,
                    starPositions: starPositions,
                    isValidConnection: isValidConnection,
                  ),
                  size: Size.infinite,
                ),
              ),
              ShapeInstructions(shapeName: widget.currentShape),
              if (!showSuccess)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: _resetLevel,
                    backgroundColor: AppTheme.childTurquoise,
                    child: const Icon(Icons.refresh),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
