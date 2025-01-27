import 'package:flutter/material.dart';
import '../../../../../../../../services/report_progress_service.dart';
import '../../../../shared/components/completion_overlay.dart';
import '../../../../shared/wrapper/game_level_wrapper.dart';
import '../../components/puzzle_components/concrete_puzzle.dart';
import '../../components/puzzle_components/two_piece_puzzle.dart';

class RabbitPuzzle extends StatefulWidget {
  final Function(int) onScoreUpdate;
  final VoidCallback onNext;
  final String childId;

  const RabbitPuzzle({
    super.key,
    required this.onScoreUpdate,
    required this.onNext,
    required this.childId,
  });

  @override
  State<RabbitPuzzle> createState() => _RabbitPuzzleState();
}

class _RabbitPuzzleState extends State<RabbitPuzzle> {
  static const double puzzleAreaRatio = 0.45;
  late double puzzleAreaSize;
  bool showSuccess = false;
  bool _isPaused = false; // Add at the top with other state variables

  Map<String, bool> placedPieces = {
    'head': false,
    'body': false,
  };

  void _resetPuzzle() {
    setState(() {
      placedPieces = {
        'head': false,
        'body': false,
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
        final starsEarned = 3; // Define starsEarned before using it
        widget.onScoreUpdate(starsEarned);

        final progressService = ProgressService();
        progressService.updateProgress(
          childId: widget.childId,
          starsCollected: starsEarned,
          minutesPlayed: null, // We'll handle time separately
        );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CompletionOverlay(
            data: CompletionData.fromType(CompletionType.puzzle),
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
      childId: widget.childId, // Add this
      child: StandardTwoPiecePuzzle(
        puzzleAreaSize: puzzleAreaSize,
        referenceImage: 'assets/puzzles/rabbit_complete.png',
        pieces: [
          VerticalPiecePlacement(
            id: 'head',
            image: 'assets/puzzles/rabbit_head.png',
            dropZoneTop: 0.1,
            heightRatio: 0.5,
            size: Size(puzzleAreaSize * 0.8, puzzleAreaSize * 0.5),
          ),
          VerticalPiecePlacement(
            id: 'body',
            image: 'assets/puzzles/rabbit_body.png',
            dropZoneTop: 0.4,
            heightRatio: 0.5,
            size: Size(puzzleAreaSize * 0.8, puzzleAreaSize * 0.5),
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
