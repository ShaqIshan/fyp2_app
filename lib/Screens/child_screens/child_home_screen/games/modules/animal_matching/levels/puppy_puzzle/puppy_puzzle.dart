// lib/screens/child/games/modules/animal_matching/levels/puppy_puzzle/puppy_puzzle.dart

import 'package:flutter/material.dart';
import '../../../../shared/components/completion_overlay.dart';
import '../../../../shared/wrapper/game_level_wrapper.dart';
import '../../components/puzzle_components/concrete_puzzle.dart';
import '../../components/puzzle_components/three_piece_puzzle.dart';

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
  bool _isPaused = false; // Add at the top with other state variables

  Map<String, bool> placedPieces = {
    'head': false,
    'body': false,
    'tail': false,
  };

  void _resetPuzzle() {
    setState(() {
      placedPieces = {
        'head': false,
        'body': false,
        'tail': false,
      };
      showSuccess = false;
      _isPaused = false; // Add this line to unpause when resetting
    });
  }

  void _handleTimeUp() {
    if (!mounted) return;
    setState(() {
      _isPaused = true;
    });
    _resetPuzzle();
  }

  void _handlePiecePlaced(String pieceId, bool isPlaced) {
    setState(() {
      placedPieces[pieceId] = isPlaced;

      if (placedPieces.values.every((placed) => placed)) {
        showSuccess = true;
        widget.onScoreUpdate(3);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CompletionOverlay(
            data: CompletionData.fromType(CompletionType.puzzle,
                isLastPuzzle: true),
            onPrimaryAction: () {
              Navigator.pop(context);
              widget.onNext();
            },
            onSecondaryAction: () {
              Navigator.pop(context);
              _resetPuzzle();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    puzzleAreaSize = MediaQuery.of(context).size.height * puzzleAreaRatio;

    return GameLevelWrapper(
      title: 'Animal Puzzles',
      score: placedPieces.values.where((placed) => placed).length,
      isCompleted: showSuccess,
      onTimeUp: _handleTimeUp, // Add this
      isPaused: _isPaused, // Add this
      child: StandardThreePiecePuzzle(
        puzzleAreaSize: puzzleAreaSize,
        referenceImage: 'assets/puzzles/puppy_complete.png',
        pieces: [
          FlexiblePiecePlacement(
            id: 'head',
            image: 'assets/puzzles/puppy_head.png',
            dropZoneTop: 0.06,
            dropZoneLeft: 0.12,
            dropZoneWidth: 0.47,
            heightRatio: 0.51,
            size: Size(puzzleAreaSize * 0.5, puzzleAreaSize * 0.35),
            hitboxPadding: puzzleAreaSize * 0.05,
          ),
          FlexiblePiecePlacement(
            id: 'body',
            image: 'assets/puzzles/puppy_body.png',
            dropZoneTop: 0.35,
            dropZoneLeft: 0.11,
            dropZoneWidth: 0.82,
            heightRatio: 0.58,
            size: Size(puzzleAreaSize * 0.5, puzzleAreaSize * 0.45),
            hitboxPadding: puzzleAreaSize * 0.05,
          ),
          FlexiblePiecePlacement(
            id: 'tail',
            image: 'assets/puzzles/puppy_tail.png',
            dropZoneTop: 0.269,
            dropZoneLeft: 0.61,
            dropZoneWidth: 0.25,
            heightRatio: 0.19,
            size: Size(puzzleAreaSize * 0.2, puzzleAreaSize * 0.15),
            hitboxPadding: puzzleAreaSize * 0.05,
          ),
        ],
        placedPieces: placedPieces,
        onPiecePlaced: _handlePiecePlaced,
        showSuccess: showSuccess,
        onNext: widget.onNext,
        onReset: _resetPuzzle,
        isLastPuzzle: true,
      ),
    );
  }
}
