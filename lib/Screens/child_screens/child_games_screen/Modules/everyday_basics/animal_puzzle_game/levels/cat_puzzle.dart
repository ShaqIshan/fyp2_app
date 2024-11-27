import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/concrete_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/two_piece_puzzle.dart';

class CatPuzzle extends StatefulWidget {
  final Function(int) onScoreUpdate;
  final VoidCallback onNext;

  const CatPuzzle({
    super.key,
    required this.onScoreUpdate,
    required this.onNext,
  });

  @override
  State<CatPuzzle> createState() => _CatPuzzleState();
}

class _CatPuzzleState extends State<CatPuzzle> {
  static const double puzzleAreaRatio = 0.45;
  late double puzzleAreaSize;
  bool showSuccess = false;
  Map<String, bool> placedPieces = {
    'head': false,
    'body': false,
  };

  @override
  Widget build(BuildContext context) {
    puzzleAreaSize = MediaQuery.of(context).size.height * puzzleAreaRatio;

    return StandardTwoPiecePuzzle(
      puzzleAreaSize: puzzleAreaSize,
      referenceImage: 'assets/puzzles/cat_complete.png',
      pieces: [
        VerticalPiecePlacement(
          id: 'head',
          image: 'assets/puzzles/cat_head.png',
          dropZoneTop: 0.1,
          heightRatio: 0.5,
          size: Size(puzzleAreaSize * 0.8, puzzleAreaSize * 0.45),
        ),
        VerticalPiecePlacement(
          id: 'body',
          image: 'assets/puzzles/cat_body.png',
          dropZoneTop: 0.45,
          heightRatio: 0.55,
          size: Size(puzzleAreaSize * 0.8, puzzleAreaSize * 0.55),
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
          };
          showSuccess = false;
        });
      },
    );
  }
}