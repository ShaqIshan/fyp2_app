import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/star_shapes_level_components/star_path_painter.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/star_shapes_level_components/star_shapes_components.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/star_shapes_level_components/star_shapes_helpers.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class StarShapesLevel extends StatefulWidget {
  final VoidCallback? onSuccess;

  const StarShapesLevel({
    super.key,
    this.onSuccess,
  });

  @override
  State<StarShapesLevel> createState() => _StarShapesLevelState();
}

class _StarShapesLevelState extends State<StarShapesLevel> {
  List<Offset> currentPoints = [];
  List<List<Offset>> completedLines = [];
  bool isDrawing = false;
  bool showSuccess = false;
  String currentShape = 'triangle';
  late List<Offset> starPositions;
  late List<List<Offset>> validConnections;
  bool isValidConnection = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        starPositions =
            StarShapesHelpers.getStarPositionsForShape(size, currentShape);
        validConnections = StarShapesHelpers.getValidConnectionsForShape(
            starPositions, currentShape);

        return Stack(
          children: [
            // Drawing Area
            GestureDetector(
              onPanStart: (details) => _handlePanStart(details, starPositions),
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

            // Instructions
            ShapeInstructions(shapeName: currentShape),

            // Success Overlay
            if (showSuccess)
              StarShapesSuccessOverlay(
                shapeName: currentShape,
                onNext: _nextShape,
              ),

            // Reset Button
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
    );
  }

  void _handlePanStart(DragStartDetails details, List<Offset> starPositions) {
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
    if (isDrawing) {
      setState(() {
        currentPoints.add(details.localPosition);

        // Update valid connection status in real-time
        List<Offset> connectedStars =
            StarShapesHelpers.findConnectedStars(currentPoints, starPositions);
        isValidConnection = connectedStars.length >= 2;
      });
    }
  }

  void _handlePanEnd(
    List<Offset> starPositions,
    List<List<Offset>> validConnections,
  ) {
    if (!isDrawing || currentPoints.isEmpty) {
      setState(() {
        isDrawing = false;
        currentPoints.clear();
        isValidConnection = false;
      });
      return;
    }

    // Find all stars that were connected in this drawing
    List<Offset> connectedStars =
        StarShapesHelpers.findConnectedStars(currentPoints, starPositions);

    // Validate the connections and get new valid lines
    List<List<Offset>> newConnections = StarShapesHelpers.validateConnections(
      connectedStars,
      validConnections,
      completedLines,
    );

    // Add all valid new connections
    if (newConnections.isNotEmpty) {
      setState(() {
        completedLines.addAll(newConnections);
        isValidConnection = true;

        // Check if shape is complete
        if (StarShapesHelpers.isShapeComplete(
            completedLines, validConnections)) {
          showSuccess = true;
          if (widget.onSuccess != null) {
            widget.onSuccess!();
          }
        }
      });
    }

    setState(() {
      isDrawing = false;
      currentPoints.clear();
    });
  }

  void _resetLevel() {
    setState(() {
      currentPoints.clear();
      completedLines.clear();
      isDrawing = false;
      showSuccess = false;
      isValidConnection = false;
    });
  }

  void _nextShape() {
    setState(() {
      currentShape = currentShape == 'triangle' ? 'square' : 'triangle';
      _resetLevel();
    });
  }
}
