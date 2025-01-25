import 'package:flutter/material.dart';

import '../../../../shared/components/completion_overlay.dart';
import '../../../../shared/wrapper/game_level_wrapper.dart';
import '../../components/puzzle_components/concrete_puzzle.dart';
import '../../components/puzzle_components/two_piece_puzzle.dart';

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

  void _resetPuzzle() {
    if (!mounted) return;
    setState(() {
      placedPieces = {
        'head': false,
        'body': false,
      };
      showSuccess = false;
    });
  }

  void _handlePiecePlaced(String pieceId, bool isPlaced) {
    if (!mounted) return;
    setState(() {
      placedPieces[pieceId] = isPlaced;

      if (placedPieces.values.every((placed) => placed)) {
        showSuccess = true;
        widget.onScoreUpdate(3);

        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CompletionOverlay(
              data: CompletionData.fromType(CompletionType.puzzle),
              onPrimaryAction: () {
                if (mounted) {
                  Navigator.pop(context);
                  widget.onNext();
                }
              },
              onSecondaryAction: () {
                if (mounted) {
                  Navigator.pop(context);
                  _resetPuzzle();
                }
              },
            ),
          );
        }
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
      child: StandardTwoPiecePuzzle(
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
        onPiecePlaced: _handlePiecePlaced,
        showSuccess: showSuccess,
        onNext: widget.onNext,
        onReset: _resetPuzzle,
      ),
    );
  }
}
