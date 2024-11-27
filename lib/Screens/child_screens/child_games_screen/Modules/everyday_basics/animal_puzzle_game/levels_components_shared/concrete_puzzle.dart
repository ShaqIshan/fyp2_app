import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/three_piece_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics/animal_puzzle_game/levels_components_shared/two_piece_puzzle.dart';

// NOTE:

class StandardTwoPiecePuzzle extends TwoPieceLayoutPuzzle {
  const StandardTwoPiecePuzzle({
    required super.puzzleAreaSize,
    required super.referenceImage,
    required super.pieces,
    required super.onPiecePlaced,
    required super.showSuccess,
    required super.onNext,
    required super.onReset,
    required super.placedPieces,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            buildReferenceImage(),
            buildPuzzleArea(),
            _buildPieceBank(),
          ],
        ),
        if (showSuccess) buildSuccessOverlay(),
      ],
    );
  }

  Widget _buildPieceBank() {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: pieces
            .where((piece) => !placedPieces[piece.id]!)
            .map((piece) => buildDraggablePiece(piece))
            .toList(),
      ),
    );
  }
}

class StandardThreePiecePuzzle extends ThreePieceLayoutPuzzle {
  const StandardThreePiecePuzzle({
    required super.puzzleAreaSize,
    required super.referenceImage,
    required super.pieces,
    required super.onPiecePlaced,
    required super.showSuccess,
    required super.onNext,
    required super.onReset,
    required super.placedPieces,
    super.isLastPuzzle, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              buildReferenceImage(),
              buildPuzzleArea(),
              _buildPieceBank(),
            ],
          ),
        ),
        if (showSuccess) buildSuccessOverlay(),
      ],
    );
  }

  Widget _buildPieceBank() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pieces
                    .where((piece) =>
                        !placedPieces[piece.id]! &&
                        (piece.id == 'head' || piece.id == 'body'))
                    .map((piece) => SizedBox(
                          width: piece.size.width * 0.4,
                          height: piece.size.height * 0.4,
                          child: buildDraggablePiece(piece),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pieces
                    .where((piece) =>
                        !placedPieces[piece.id]! && piece.id == 'tail')
                    .map((piece) => SizedBox(
                          width: piece.size.width * 0.4,
                          height: piece.size.height * 0.4,
                          child: buildDraggablePiece(piece),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
