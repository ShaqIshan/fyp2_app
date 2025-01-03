import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class StarShapesDebugInfo extends StatelessWidget {
  final bool isDrawing;
  final int pointCount;
  final bool isValidConnection;
  final int completedLines;

  const StarShapesDebugInfo({
    super.key,
    required this.isDrawing,
    required this.pointCount,
    required this.isValidConnection,
    required this.completedLines,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.black.withOpacity(0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Drawing: $isDrawing',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Points: $pointCount',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Valid Connection: $isValidConnection',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Completed Lines: $completedLines',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class StarShapesSuccessOverlay extends StatelessWidget {
  final String shapeName;
  final VoidCallback onNext;

  const StarShapesSuccessOverlay({
    super.key,
    required this.shapeName,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/pencil_activities/star_shapes/success_star.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 16),
              Text(
                'Amazing!',
                style: AppTheme.childHeadingMedium.copyWith(
                  color: AppTheme.childSoftGreen,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You made a perfect $shapeName!',
                style: AppTheme.childBodyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.childSoftGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Next Shape',
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
}

class ShapeInstructions extends StatelessWidget {
  final String shapeName;

  const ShapeInstructions({
    super.key,
    required this.shapeName,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
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
              // Larger shape icon
              Image.asset(
                'assets/pencil_activities/star_shapes/${shapeName.toLowerCase()}_icon.png',
                width: 64, // Increased from 32 to 64
                height: 64, // Increased from 32 to 64
              ),
              const SizedBox(height: 16),
              // Text below the shape
              Text(
                'Connect the stars to make a $shapeName!',
                style: AppTheme.childBodyText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
