import 'package:flutter/material.dart';

class BunnyPathHelpers {
  static bool isNearBunny(
      Offset point, Size screenSize, BoxConstraints constraints) {
    final bunnyCenter = Offset(
      constraints.maxWidth * 0.5,
      constraints.maxHeight * 0.85,
    );

    final distance = (point - bunnyCenter).distance;
    return distance < 80.0;
  }

  static bool isNearCarrot(
      Offset point, Size screenSize, BoxConstraints constraints) {
    final carrotCenter = Offset(
      constraints.maxWidth * 0.5,
      constraints.maxHeight * 0.15,
    );

    final distance = (point - carrotCenter).distance;
    return distance < 40.0;
  }
}
