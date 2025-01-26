import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

enum CompletionType { puzzle, drawing, shapes }

class CompletionData {
  final String title;
  final String message;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final IconData icon;
  final Color accentColor;
  final int? currentLevelId; // Added to track current level
  final bool isLastLevel; // Added to check if it's the last level

  CompletionData({
    required this.title,
    required this.message,
    required this.primaryButtonText,
    this.secondaryButtonText,
    this.icon = Icons.celebration,
    this.accentColor = const Color(0xFF4ECDC4),
    this.currentLevelId,
    this.isLastLevel = false,
  });

  factory CompletionData.fromType(
    CompletionType type, {
    bool isLastPuzzle = false,
  }) {
    switch (type) {
      case CompletionType.puzzle:
        return CompletionData(
          title: 'Amazing!',
          message: 'You completed the puzzle!',
          primaryButtonText: 'Next Puzzle',
          secondaryButtonText: 'Later',
          icon: Icons.celebration,
          accentColor: AppTheme.childSoftGreen,
        );
      case CompletionType.drawing:
        return CompletionData(
          title: 'Amazing!',
          message: 'You completed the path!',
          primaryButtonText: 'Next Activity',
          secondaryButtonText: 'Later',
          icon: Icons.celebration,
          accentColor: AppTheme.childSoftGreen,
        );
      case CompletionType.shapes:
        if (isLastPuzzle) {
          return CompletionData(
            title: 'Fantastic!',
            message: 'You\'ve completed all activities!',
            primaryButtonText: 'Complete!',
            secondaryButtonText: 'Later',
            icon: Icons.celebration,
            accentColor: AppTheme.childSoftGreen,
          );
        }
        return CompletionData(
          title: 'Amazing!',
          message: 'You made a perfect shape!',
          primaryButtonText: 'Next Shape',
          secondaryButtonText: 'Later',
          icon: Icons.auto_awesome,
          accentColor: AppTheme.childSoftGreen,
        );
    }
  }
}

class CompletionOverlay extends StatelessWidget {
  final CompletionData data;
  final VoidCallback onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  const CompletionOverlay({
    super.key,
    required this.data,
    required this.onPrimaryAction,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.childCream,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: data.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.icon,
                  size: 64,
                  color: data.accentColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.title,
                style: AppTheme.childHeadingMedium.copyWith(
                  color: data.accentColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data.message,
                style: AppTheme.childBodyText.copyWith(
                  color: data.accentColor.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: AppTheme.childYellow, size: 32),
                  Icon(Icons.star, color: AppTheme.childYellow, size: 32),
                  Icon(Icons.star, color: AppTheme.childYellow, size: 32),
                ],
              ),
              const SizedBox(height: 24),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          data.primaryButtonText,
          AppTheme.childSoftGreen,
          Icons.arrow_forward_rounded,
          () {
            Navigator.of(context).pop();
            if (data.isLastLevel) {
              // If it's the last level, navigate back to the journey screen
              Navigator.of(context).pop();
            } else {
              onPrimaryAction();
            }
          },
        ),
        if (data.secondaryButtonText != null && onSecondaryAction != null) ...[
          const SizedBox(height: 12),
          _buildButton(
            data.secondaryButtonText!,
            AppTheme.childTurquoise,
            Icons.watch_later_rounded,
            () {
              Navigator.of(context).pop(); // Pop dialog
              Navigator.of(context)
                  .pop(); // Pop level screen to go back to home
            },
          ),
        ],
      ],
    );
  }

  Widget _buildButton(
    String label,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.childBodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
