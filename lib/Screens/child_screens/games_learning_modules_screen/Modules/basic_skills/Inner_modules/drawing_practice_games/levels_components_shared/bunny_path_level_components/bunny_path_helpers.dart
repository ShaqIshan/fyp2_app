// lib/screens/child_screens/child_games_screen/modules/everyday_basics/happy_helpers/helpers/bunny_path_helpers.dart

import 'package:flutter/material.dart';

class BunnyPathHelpers {
  static bool isNearBunny(
      Offset point, Size screenSize, BoxConstraints constraints) {
    // Calculate bunny position based on available space
    final bunnyCenter = Offset(
      constraints.maxWidth * 0.5,
      constraints.maxHeight * 0.85,
    );

    // Calculate distance from point to bunny center
    final distance = (point - bunnyCenter).distance;

    // Debug print to help verify positions
    print('Point: $point');
    print('Bunny center: $bunnyCenter');
    print('Distance: $distance');
    print('Screen size: $screenSize');
    print('Constraints: $constraints');

    // HACK: just made distance of touch bigger instead of lowering dotted line
    // NOTE: dont fix this until i want to
    // Use a more generous radius for touch detection (50 pixels)
    return distance < 80.0;
  }

  static bool isNearCarrot(
      Offset point, Size screenSize, BoxConstraints constraints) {
    // Calculate carrot position based on available space
    final carrotCenter = Offset(
      constraints.maxWidth * 0.5,
      constraints.maxHeight * 0.15,
    );

    // Calculate distance from point to carrot center
    final distance = (point - carrotCenter).distance;

    // Use a more generous radius for touch detection (40 pixels)
    return distance < 40.0;
  }
}
