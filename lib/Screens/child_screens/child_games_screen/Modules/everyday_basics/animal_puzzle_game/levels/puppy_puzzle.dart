import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/concrete_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/three_piece_puzzle.dart';

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

  @override
  Widget build(BuildContext context) {
    puzzleAreaSize = MediaQuery.of(context).size.height * puzzleAreaRatio;

    // TODO: fix the layout placement for dog puzzles, the widgth of the actual picture is weird, when you put the head the tail cant be put because i changed the dropbox for it to strech trough
    // TODO: maybe change image size of tail to not have same width
    return StandardThreePiecePuzzle(
      puzzleAreaSize: puzzleAreaSize,
      referenceImage: 'assets/puzzles/puppy_complete.png',
      pieces: [
        FlexiblePiecePlacement(
          id: 'head',
          image: 'assets/puzzles/puppy_head.png',
          dropZoneTop: 0.1,
          dropZoneLeft: -0.53,
          dropZoneWidth: 2,
          heightRatio: 0.45,
          size: Size(puzzleAreaSize * 0.8, puzzleAreaSize * 0.4),
        ),
        FlexiblePiecePlacement(
          id: 'body',
          image: 'assets/puzzles/puppy_body.png',
          dropZoneTop: 0.337,
          dropZoneLeft: 0,
          dropZoneWidth: 0.935,
          heightRatio: 0.6,
          size: Size(puzzleAreaSize * 0.6, puzzleAreaSize * 0.6),
        ),
        FlexiblePiecePlacement(
          id: 'tail',
          image: 'assets/puzzles/puppy_tail.png',
          dropZoneTop: 0.23,
          dropZoneLeft: 0.03,
          dropZoneWidth: 0.9,
          heightRatio: 0.3,
          size: Size(puzzleAreaSize * 0.25, puzzleAreaSize * 0.3),
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
      isLastPuzzle: true, // Add this line to indicate it's the last puzzle
    );
  }
}
