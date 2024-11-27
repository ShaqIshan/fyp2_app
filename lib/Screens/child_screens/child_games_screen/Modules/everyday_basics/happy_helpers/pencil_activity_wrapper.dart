import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels/letter_tracing_level/letter_tracing_level.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels/bunny_path_level/bunny_path_level.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels/line_drawing_level/line_drawing_level.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels/matching_pairs_level.dart/matching_pairs_level.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/happy_helpers/levels/star_shapes_level/star_shapes_level.dart';
import 'package:fyp2_app/shared/app_theme.dart';

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
    final currentLevelData = levels[currentLevel];

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildHeader(currentLevelData),
                Expanded(
                  child: _buildCurrentLevel(currentLevelData),
                ),
              ],
            ),
          ),
          if (showSuccessOverlay && currentLevel == 0)
            Positioned.fill(
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
                          levels[currentLevel]['successMessage'] ??
                              'Level complete!',
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
