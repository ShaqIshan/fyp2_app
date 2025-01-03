import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BunnyPathCompletionDialog extends StatelessWidget {
  final VoidCallback onSuccess;

  const BunnyPathCompletionDialog({
    super.key,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.celebration,
            size: 64,
            color: AppTheme.childYellow,
          ),
          const SizedBox(height: 16),
          Text(
            'Wonderful Job!',
            style: AppTheme.childHeadingMedium.copyWith(
              color: AppTheme.childTurquoise,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You helped Bunny reach the carrot!\nLet\'s try drawing shapes next!',
            textAlign: TextAlign.center,
            style: AppTheme.childBodyText,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              onSuccess(); // Move to next level
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
              'Next Activity',
              style: AppTheme.childBodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BunnyImage extends StatelessWidget {
  final Size screenSize;

  const BunnyImage({
    super.key,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (screenSize.width * 0.5) - 90,
      bottom: screenSize.height * 0.0,
      child: IgnorePointer(
        child: Image.asset(
          'assets/pencil_activities/bunny_path/bunny.png',
          width: 160,
          height: 160,
        ),
      ),
    );
  }
}

class CarrotImage extends StatelessWidget {
  final Size screenSize;

  const CarrotImage({
    super.key,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (screenSize.width * 0.4) - 35,
      top: screenSize.height * 0.06 - 50,
      child: IgnorePointer(
        child: Image.asset(
          'assets/pencil_activities/bunny_path/carrot.png',
          width: 100,
          height: 160,
        ),
      ),
    );
  }
}
