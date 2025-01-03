import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels_components_shared/bunny_path_level_components/bunny_path_helpers.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels_components_shared/bunny_path_level_components/bunny_path_level_components.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels_components_shared/bunny_path_level_components/bunny_path_painter.dart';
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
  bool showInstructions = true; // New state variable

  void _handlePathCompletion(BoxConstraints constraints) {
    if (!pathCompleted && userPath.isNotEmpty && validStart) {
      final endPoint = userPath.last;
      final screenSize = MediaQuery.of(context).size;

      if (BunnyPathHelpers.isNearCarrot(endPoint, screenSize, constraints)) {
        setState(() {
          pathCompleted = true;
        });

        // Delay showing completion dialog
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => BunnyPathCompletionDialog(
              onSuccess: widget.onSuccess,
            ),
          );
        });
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

  Widget _buildInstructionsOverlay() {
    return Container(
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
              Image.asset(
                'assets/pencil_activities/bunny_path/bunny.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 16),
              Text(
                'Help Bunny!',
                style: AppTheme.childHeadingMedium.copyWith(
                  color: AppTheme.childTurquoise,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Draw a path from the bunny to the carrot.\nStart from the bunny and follow the dotted line!',
                style: AppTheme.childBodyText.copyWith(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showInstructions = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.childTurquoise,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Let\'s Start!',
                  style: AppTheme.childBodyText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.childSkyBlue,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
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
                  BunnyImage(screenSize: screenSize),
                  CarrotImage(screenSize: screenSize),
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
        if (showInstructions) _buildInstructionsOverlay(),
      ],
    );
  }
}
