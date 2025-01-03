import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'levels/cute_animals_level/cute_animals_level.dart';

class ColoringFunWrapper extends StatefulWidget {
  const ColoringFunWrapper({super.key});

  @override
  State<ColoringFunWrapper> createState() => _ColoringFunWrapperState();
}

class _ColoringFunWrapperState extends State<ColoringFunWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: CuteAnimalsLevel(
        onGameComplete: () {
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
                    'Amazing Work!',
                    style: AppTheme.childHeadingMedium.copyWith(
                      color: AppTheme.childTurquoise,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ve completed all the animals!\nYou\'ve earned 3 stars!',
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
}
