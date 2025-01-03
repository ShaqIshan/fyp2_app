// lib/models/childs_models/level_data.dart

import 'package:flutter/material.dart';

class LevelData {
  final int id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isUnlocked;

  LevelData({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.isUnlocked = false,
  });
}
