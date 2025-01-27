import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../games/modules/animal_matching/levels/cat_puzzle/cat_puzzle.dart';
import '../../games/modules/animal_matching/levels/puppy_puzzle/puppy_puzzle.dart';
import '../../games/modules/animal_matching/levels/rabbit_puzzle/rabbit_puzzle.dart';
import '../../games/modules/drawing_practice/levels/bunny_path/bunny_path_level.dart';
import '../../games/modules/drawing_practice/levels/star_shapes/star_shapes_level.dart';

enum GameType {
  puzzle,
  drawing,
}

class LevelData {
  final int id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isUnlocked;
  final int maxStars;
  final int earnedStars;
  final GameType gameType;
  final String? assetReference;

  const LevelData({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.gameType,
    this.assetReference,
    this.isCompleted = false,
    this.isUnlocked = false,
    this.maxStars = 3,
    this.earnedStars = 0,
  });

  bool get isLastLevel => id == 6; // Square Stars is level 6

  Widget getGameScreen({
    required Function(int) onComplete,
    required VoidCallback onNext,
    required String childId, // Add this
  }) {
    switch (id) {
      case 1: // Cat Puzzle
        return CatPuzzle(
          onScoreUpdate: onComplete,
          onNext: onNext,
          childId: childId, // Add this
        );
      case 2: // Bunny Path
        return BunnyPathLevel(
          onScoreUpdate: onComplete, // Add this parameter
          onSuccess: () {
            onNext();
          },
          childId: childId, // Add this
        );
      case 3: // Rabbit Puzzle
        return RabbitPuzzle(
          onScoreUpdate: onComplete,
          onNext: onNext,
          childId: childId, // Add this
        );
      case 4: // Triangle Stars
        return StarShapesLevel(
          currentShape: 'triangle',
          onScoreUpdate: onComplete,
          onSuccess: () {
            onComplete(3);
            onNext();
          },
          onGameComplete: () {
            onComplete(3);
            onNext();
          },
          childId: childId, // Add this
        );
      case 5: // Puppy Puzzle
        return PuppyPuzzle(
          onScoreUpdate: onComplete,
          onNext: onNext,
          childId: childId, // Add this
        );
      case 6: // Square Stars
        return StarShapesLevel(
          currentShape: 'square',
          onScoreUpdate: onComplete,
          onSuccess: () {
            onComplete(3);
            onNext();
          },
          onGameComplete: () => onComplete(3),
          childId: childId, // Add this
        );
      default:
        return const Placeholder();
    }
  }

  LevelData copyWith({
    bool? isCompleted,
    bool? isUnlocked,
    int? earnedStars,
  }) {
    return LevelData(
      id: id,
      name: name,
      description: description,
      icon: icon,
      color: color,
      gameType: gameType,
      assetReference: assetReference,
      isCompleted: isCompleted ?? this.isCompleted,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      maxStars: maxStars,
      earnedStars: earnedStars ?? this.earnedStars,
    );
  }

  static List<LevelData> getLevels() {
    return [
      LevelData(
        id: 1,
        name: 'Cat Puzzle',
        description: 'Complete the cute cat puzzle',
        icon: Icons.pets,
        color: AppTheme.childTurquoise,
        gameType: GameType.puzzle,
        assetReference: 'assets/puzzles/cat_complete.png',
        isUnlocked: true,
      ),
      LevelData(
        id: 2,
        name: 'Help Bunny',
        description: 'Guide bunny to the carrot',
        icon: Icons.edit,
        color: AppTheme.childPurple,
        gameType: GameType.drawing,
        assetReference: 'assets/pencil_activities/bunny_path/bunny.png',
      ),
      LevelData(
        id: 3,
        name: 'Rabbit Puzzle',
        description: 'Put together the rabbit pieces',
        icon: Icons.pets,
        color: AppTheme.childTurquoise,
        gameType: GameType.puzzle,
        assetReference: 'assets/puzzles/rabbit_complete.png',
      ),
      LevelData(
        id: 4,
        name: 'Triangle Stars',
        description: 'Connect stars to make a triangle',
        icon: Icons.edit,
        color: AppTheme.childPurple,
        gameType: GameType.drawing,
      ),
      LevelData(
        id: 5,
        name: 'Puppy Puzzle',
        description: 'Complete the playful puppy',
        icon: Icons.pets,
        color: AppTheme.childTurquoise,
        gameType: GameType.puzzle,
        assetReference: 'assets/puzzles/puppy_complete.png',
      ),
      LevelData(
        id: 6,
        name: 'Square Stars',
        description: 'Connect stars to make a square',
        icon: Icons.edit,
        color: AppTheme.childPurple,
        gameType: GameType.drawing,
      ),
    ];
  }
}
