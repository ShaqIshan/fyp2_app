import 'package:flutter/material.dart';

class BasicActivity {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;
  final bool isLocked;
  final int totalStars;
  final int earnedStars;
  final int requiredStars;

  const BasicActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficulty,
    required this.isLocked,
    required this.totalStars,
    required this.earnedStars,
    required this.requiredStars,
  });

  // Add a copyWith method for easy modifications
  BasicActivity copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    String? difficulty,
    bool? isLocked,
    int? totalStars,
    int? earnedStars,
    int? requiredStars,
  }) {
    return BasicActivity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      difficulty: difficulty ?? this.difficulty,
      isLocked: isLocked ?? this.isLocked,
      totalStars: totalStars ?? this.totalStars,
      earnedStars: earnedStars ?? this.earnedStars,
      requiredStars: requiredStars ?? this.requiredStars,
    );
  }
}
