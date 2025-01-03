import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels/letter_tracing_level/letter_tracing_level.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels/bunny_path_level/bunny_path_level.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels/line_drawing_level/line_drawing_level.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels/matching_pairs_level.dart/matching_pairs_level.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/drawing_practice_games/levels/star_shapes_level/star_shapes_level.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// TODO: might remove some code and seperate it
class PencilActivityWrapper extends StatefulWidget {
  const PencilActivityWrapper({super.key});

  @override
  State<PencilActivityWrapper> createState() => _PencilActivityWrapperState();
}

class _PencilActivityWrapperState extends State<PencilActivityWrapper> {
  int currentLevel = 0;
  int totalScore = 0;
  bool showSuccessOverlay = false;

  List<Map<String, dynamic>> get levels => [
        {
          'title': 'Help Bunny!',
          'description': 'Guide bunny to the carrot',
          'widget': BunnyPathLevel(
            onSuccess: () {
              setState(() {
                showSuccessOverlay = true;
                totalScore += 1;
              });
              // Add delay before transitioning to next level
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  setState(() {
                    showSuccessOverlay = false;
                    currentLevel++; // Move to next level
                  });
                }
              });
            },
          ),
          'maxScore': 3,
        },
        {
          'title': 'Make Shapes!',
          'description': 'Connect stars to make shapes',
          'widget': StarShapesLevel(
            onSuccess: () {
              setState(() {
                totalScore += 1;
              });
            },
          ),
          'maxScore': 3,
        },
        {
          'title': 'My Letters',
          'description': 'Trace the letters to spell "EMMA"',
          'widget': LetterTracingLevel(
            onSuccess: () => _handleLevelSuccess('You traced all the letters!'),
          ),
          'maxScore': 4,
        },
        {
          'title': 'Drawing Lines',
          'description': 'Practice drawing different lines',
          'widget': LineDrawingLevel(
            onSuccess: () => _handleLevelSuccess('You drew all the lines!'),
          ),
          'maxScore': 3,
        },
        {
          'title': 'Match & Connect',
          'description': 'Connect matching pairs',
          'widget': MatchingPairsLevel(
            onSuccess: () => _handleLevelSuccess('You matched all the pairs!'),
          ),
          'maxScore': 3,
        },
      ];

  void _handleLevelSuccess(String message) {
    setState(() {
      showSuccessOverlay = true;
      totalScore += 1;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showSuccessOverlay = false;
        });
        _goToNextLevel();
      }
    });
  }

  void _goToNextLevel() {
    if (currentLevel < levels.length - 1) {
      setState(() {
        currentLevel++;
      });
    } else {
      // TODO: Handle game completion
      print('All levels completed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppTheme.childTurquoise,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Fun with Drawing',
          style: AppTheme.childHeadingMedium.copyWith(
            color: AppTheme.childTurquoise,
          ),
        ),
      ),
      body: StarShapesLevel(
        onGameComplete: () {
          // Show completion dialog and return to wrapper
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.stars_rounded,
                    size: 64,
                    color: AppTheme.childYellow,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Amazing Job!',
                    style: AppTheme.childHeadingMedium.copyWith(
                      color: AppTheme.childTurquoise,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ve completed all the shapes!\nYou\'ve earned 3 stars!',
                    textAlign: TextAlign.center,
                    style: AppTheme.childBodyText,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Return to wrapper
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
                      'Continue',
                      style: AppTheme.childBodyText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> levelData) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppTheme.childTurquoise,
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  levelData['title'],
                  style: AppTheme.childHeadingMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.childYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppTheme.childYellow,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$totalScore/${levels[currentLevel]['maxScore']}',
                      style: AppTheme.childTitleLarge.copyWith(
                        color: AppTheme.childYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            levelData['description'],
            style: AppTheme.childBodyText.copyWith(
              color: AppTheme.childTurquoise.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLevel(Map<String, dynamic> levelData) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: levelData['widget'],
    );
  }
}
