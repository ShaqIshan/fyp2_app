// lib/shared/components/time_up_dialog.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class TimeUpDialog extends StatelessWidget {
  final VoidCallback onTryAgain;

  const TimeUpDialog({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: AppTheme.childCream,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                size: 64,
                color: Colors.amber,
              ),
              const SizedBox(height: 12),
              Text(
                'A for Effort!',
                style: AppTheme.childHeadingMedium.copyWith(
                  color: AppTheme.childTurquoise,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'ve got a star!\nLet\'s do faster to get more stars',
                textAlign: TextAlign.center,
                style: AppTheme.childBodyText.copyWith(
                  color: AppTheme.childTurquoise.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              _buildButton(
                'Play Now!',
                AppTheme.childSoftGreen,
                Icons.play_circle_rounded,
                onTryAgain, // Directly use onTryAgain without navigation
              ),
              const SizedBox(height: 12),
              _buildButton(
                'Later',
                AppTheme.childTurquoise,
                Icons.watch_later_rounded,
                () {
                  Navigator.of(context).pop(); // Pop the dialog
                  Navigator.of(context)
                      .pop(); // Pop the current level screen to go back to child home
                },
              ),
            ],
          ),
        ),
      ),
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
