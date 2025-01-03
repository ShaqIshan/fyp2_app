import 'package:flutter/material.dart';

class ColoringTheme {
  static const double defaultBrushSize = 15.0;
  static const double eraserSize = 30.0;

  static const List<ColorChoice> basicColors = [
    ColorChoice(color: Colors.red, name: 'Red'),
    ColorChoice(color: Colors.blue, name: 'Blue'),
    ColorChoice(color: Colors.yellow, name: 'Yellow'),
    ColorChoice(color: Colors.green, name: 'Green'),
    ColorChoice(color: Colors.purple, name: 'Purple'),
    ColorChoice(color: Colors.orange, name: 'Orange'),
  ];
}

class ColorChoice {
  final Color color;
  final String name;

  const ColorChoice({required this.color, required this.name});
}
