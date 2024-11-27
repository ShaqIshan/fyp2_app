import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BunnyPathSuccessOverlay extends StatelessWidget {
  const BunnyPathSuccessOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppTheme.childSoftGreen,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Great job!',
                style: AppTheme.childHeadingMedium.copyWith(
                  color: AppTheme.childSoftGreen,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You helped bunny reach the carrot!',
                style: AppTheme.childBodyText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
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
