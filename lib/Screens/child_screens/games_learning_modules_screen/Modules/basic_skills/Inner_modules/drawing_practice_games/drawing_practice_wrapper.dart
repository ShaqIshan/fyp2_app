import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'levels/bunny_path_level/bunny_path_level.dart';
import 'levels/star_shapes_level/star_shapes_level.dart';

class DrawingPracticeWrapper extends StatefulWidget {
  const DrawingPracticeWrapper({super.key});

  @override
  State<DrawingPracticeWrapper> createState() => _DrawingPracticeWrapperState();
}

class _DrawingPracticeWrapperState extends State<DrawingPracticeWrapper> {
  bool showBunnyPath = true;

  // TODO: Implement star reward system in future PR
  void _handleBunnyPathComplete() {
    setState(() {
      showBunnyPath = false;
    });
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
          'Drawing Practice',
          style: AppTheme.childHeadingMedium.copyWith(
            color: AppTheme.childTurquoise,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: showBunnyPath
            ? BunnyPathLevel(
                onSuccess: _handleBunnyPathComplete,
              )
            : StarShapesLevel(
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
                          const Icon(
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
                            'You\'ve completed all the drawing activities!',
                            textAlign: TextAlign.center,
                            style: AppTheme.childBodyText,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              Navigator.pop(context, 3); // Return with 3 stars
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
      ),
    );
  }
}
