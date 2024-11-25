import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/puzzles/cat_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/puzzles/puppy_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/puzzles/rabbit_puzzle.dart';
import 'package:fyp2_app/shared/app_theme.dart';

enum PuzzleType {
  cat,
  rabbit,
  puppy,
}

class AnimalPuzzleWrapper extends StatefulWidget {
  const AnimalPuzzleWrapper({super.key});

  @override
  State<AnimalPuzzleWrapper> createState() => _AnimalPuzzleWrapperState();
}

class _AnimalPuzzleWrapperState extends State<AnimalPuzzleWrapper> {
  PuzzleType currentPuzzle = PuzzleType.cat;
  int score = 0;

  void updateScore(int newPoints) {
    setState(() {
      score += newPoints;
    });
  }

  void _nextPuzzle() {
    setState(() {
      currentPuzzle = PuzzleType
          .values[(currentPuzzle.index + 1) % PuzzleType.values.length];
    });
  }

  Widget _getCurrentPuzzle() {
    switch (currentPuzzle) {
      case PuzzleType.cat:
        return CatPuzzle(
          onScoreUpdate: updateScore,
          onNext: _nextPuzzle,
        );
      case PuzzleType.rabbit:
        return RabbitPuzzle(
          onScoreUpdate: updateScore,
          onNext: _nextPuzzle,
        );
      case PuzzleType.puppy:
        return PuppyPuzzle(
          onScoreUpdate: updateScore,
          onNext: _nextPuzzle,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _getCurrentPuzzle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.childTurquoise,
            iconSize: 32,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animal Puzzles',
                  style: AppTheme.childHeadingMedium.copyWith(
                    color: AppTheme.childTurquoise,
                  ),
                ),
                Text(
                  'Complete the ${currentPuzzle.name} puzzle!',
                  style: AppTheme.childBodyText.copyWith(
                    color: AppTheme.childTurquoise.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppTheme.childYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.stars,
                  color: AppTheme.childYellow,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  score.toString(),
                  style: AppTheme.childTitleLarge.copyWith(
                    color: AppTheme.childYellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
