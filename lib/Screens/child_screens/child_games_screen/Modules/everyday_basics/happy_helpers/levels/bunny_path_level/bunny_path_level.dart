// lib/screens/child_screens/child_games_screen/modules/everyday_basics/happy_helpers/levels/bunny_path_level.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/bunny_path_level_components/bunny_path_helpers.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/bunny_path_level_components/bunny_path_level_components.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels_components_shared/bunny_path_level_components/bunny_path_painter.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BunnyPathLevel extends StatefulWidget {
  final VoidCallback onSuccess;

  const BunnyPathLevel({
    super.key,
    required this.onSuccess,
  });

  @override
  State<BunnyPathLevel> createState() => _BunnyPathLevelState();
}

class _BunnyPathLevelState extends State<BunnyPathLevel> {
  List<Offset> userPath = [];
  bool isDrawing = false;
  bool pathCompleted = false;
  bool showSuccess = false;
  bool validStart = false;

  void _handlePathCompletion(BoxConstraints constraints) {
    if (!pathCompleted && userPath.isNotEmpty && validStart) {
      final endPoint = userPath.last;
      final screenSize = MediaQuery.of(context).size;

      if (BunnyPathHelpers.isNearCarrot(endPoint, screenSize, constraints)) {
        setState(() {
          pathCompleted = true;
        });
        widget.onSuccess(); // Call the callback when success happens
      }
    }
  }

  void _resetLevel() {
    setState(() {
      userPath.clear();
      pathCompleted = false;
      showSuccess = false;
      validStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Main game content
        Scaffold(
          backgroundColor: AppTheme.childSkyBlue,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Drawing Area
                  GestureDetector(
                    onPanStart: (details) {
                      final point = details.localPosition;
                      final isValid = BunnyPathHelpers.isNearBunny(
                        point,
                        screenSize,
                        constraints,
                      );

                      setState(() {
                        isDrawing = true;
                        validStart = isValid;
                        userPath = [point];
                      });
                    },
                    onPanUpdate: (details) {
                      if (isDrawing) {
                        setState(() {
                          userPath.add(details.localPosition);
                        });
                      }
                    },
                    onPanEnd: (_) {
                      setState(() {
                        isDrawing = false;
                        _handlePathCompletion(constraints);
                      });
                    },
                    child: CustomPaint(
                      painter: BunnyPathPainter(
                        userPath: userPath,
                        pathCompleted: pathCompleted,
                        validStart: validStart,
                      ),
                      size: Size.infinite,
                    ),
                  ),

                  // Game Elements
                  BunnyImage(screenSize: screenSize),
                  CarrotImage(screenSize: screenSize),

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
          ),
        ),

        // Success Overlay (now positioned over everything except the header)
        if (showSuccess)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(24),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.childSoftGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: AppTheme.childSoftGreen,
                          size: 64,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Great job!',
                        style: AppTheme.childHeadingMedium.copyWith(
                          color: AppTheme.childSoftGreen,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You helped bunny reach the carrot!',
                        style: AppTheme.childBodyText.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
