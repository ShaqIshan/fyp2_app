import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/animal_matching_games/levels_components_shared/concrete_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/animal_matching_games/levels_components_shared/three_piece_puzzle.dart';

class PuppyPuzzle extends StatefulWidget {
  final Function(int) onScoreUpdate;
  final VoidCallback onNext;

  const PuppyPuzzle({
    super.key,
    required this.onScoreUpdate,
    required this.onNext,
  });

  @override
  State<PuppyPuzzle> createState() => _PuppyPuzzleState();
}

class _PuppyPuzzleState extends State<PuppyPuzzle> {
  static const double puzzleAreaRatio = 0.45;
  late double puzzleAreaSize;
  bool showSuccess = false;
  Map<String, bool> placedPieces = {
    'head': false,
    'body': false,
    'tail': false,
  };
// TODO: abit of issue with tail placement to fix
  @override
  Widget build(BuildContext context) {
    puzzleAreaSize = MediaQuery.of(context).size.height * puzzleAreaRatio;

    return StandardThreePiecePuzzle(
      puzzleAreaSize: puzzleAreaSize,
      referenceImage: 'assets/puzzles/puppy_complete.png',
      pieces: [
        FlexiblePiecePlacement(
          id: 'head',
          image: 'assets/puzzles/puppy_head.png',
          dropZoneTop: 0.06,
          dropZoneLeft: 0.12,
          dropZoneWidth: 0.47, // Adjusted for new width
          heightRatio: 0.51,
          size: Size(puzzleAreaSize * 0.5, puzzleAreaSize * 0.35),
          hitboxPadding:
              puzzleAreaSize * 0.05, // Make padding relative to puzzle size
        ),
        FlexiblePiecePlacement(
          id: 'body',
          image: 'assets/puzzles/puppy_body.png',
          dropZoneTop: 0.35,
          dropZoneLeft: 0.11,
          dropZoneWidth: 0.82,
          heightRatio: 0.58,
          size: Size(puzzleAreaSize * 0.5, puzzleAreaSize * 0.45),
          hitboxPadding:
              puzzleAreaSize * 0.05, // Make padding relative to puzzle size
        ),
        FlexiblePiecePlacement(
          id: 'tail',
          image: 'assets/puzzles/puppy_tail.png',
          dropZoneTop: 0.269,
          dropZoneLeft: 0.61,
          dropZoneWidth: 0.25,
          heightRatio: 0.19,
          size: Size(puzzleAreaSize * 0.2, puzzleAreaSize * 0.15),
          hitboxPadding:
              puzzleAreaSize * 0.05, // Make padding relative to puzzle size
        ),
      ],
      placedPieces: placedPieces,
      onPiecePlaced: (String pieceId, bool isPlaced) {
        setState(() {
          placedPieces[pieceId] = isPlaced;
          if (placedPieces.values.every((placed) => placed)) {
            showSuccess = true;
            widget.onScoreUpdate(1);
          }
        });
      },
      showSuccess: showSuccess,
      onNext: widget.onNext,
      onReset: () {
        setState(() {
          placedPieces = {
            'head': false,
            'body': false,
            'tail': false,
          };
          showSuccess = false;
        });
      },
      isLastPuzzle: true,
    );
  }
}
