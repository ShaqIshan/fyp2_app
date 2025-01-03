import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../../../../../../models/childs_models/child_learning_modules_games/basic_skills/basic_activity.dart';

final List<BasicActivity> activities = [
  // Animal Matching Module (existing)
  const BasicActivity(
    id: 'animal_matching',
    title: 'Animal Matching',
    description: 'Match animals with their shadows',
    icon: Icons.pets,
    color: AppTheme.childTurquoise,
    difficulty: 'Easy',
    isLocked: false,
    totalStars: 3,
    earnedStars: 0,
    requiredStars: 0,
  ),

  // Drawing Practice Module (existing)
  const BasicActivity(
    id: 'drawing_practice',
    title: 'Drawing Practice',
    description: 'Learn to draw shapes and lines',
    icon: Icons.edit,
    color: AppTheme.childPurple,
    difficulty: 'Easy',
    isLocked: false,
    totalStars: 3,
    earnedStars: 0,
    requiredStars: 0,
  ),

  // Coloring Fun Module (New)
  const BasicActivity(
    id: 'coloring_fun',
    title: 'Coloring Fun',
    description: 'Color different pictures and learn about them',
    icon: Icons.palette,
    color: AppTheme.childPink,
    difficulty: 'Easy',
    isLocked: false,
    totalStars: 3,
    earnedStars: 0,
    requiredStars: 0,
  ),

  // Creative Doodles Module (New)
  const BasicActivity(
    id: 'creative_doodles',
    title: 'Creative Doodles',
    description: 'Express yourself through fun drawing activities',
    icon: Icons.brush,
    color: AppTheme.childOrange,
    difficulty: 'Easy',
    isLocked: false,
    totalStars: 3,
    earnedStars: 0,
    requiredStars: 0,
  ),

  // Line Practice Module (New)
  const BasicActivity(
    id: 'line_practice',
    title: 'Line Practice',
    description: 'Learn to write by following the dots',
    icon: Icons.gesture,
    color: AppTheme.childYellow,
    difficulty: 'Easy',
    isLocked: false,
    totalStars: 3,
    earnedStars: 0,
    requiredStars: 0,
  ),
];
