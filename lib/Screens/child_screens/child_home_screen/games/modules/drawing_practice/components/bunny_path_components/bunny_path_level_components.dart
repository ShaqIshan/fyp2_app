import 'package:flutter/material.dart';

class BunnyImage extends StatelessWidget {
  final Size screenSize;

  const BunnyImage({
    super.key,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (screenSize.width * 0.5) - 70,
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
      left: (screenSize.width * 0.4) - 20,
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
