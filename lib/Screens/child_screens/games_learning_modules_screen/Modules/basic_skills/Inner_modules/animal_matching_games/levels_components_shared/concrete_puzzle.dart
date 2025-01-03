import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/animal_matching_games/levels_components_shared/three_piece_puzzle.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/animal_matching_games/levels_components_shared/two_piece_puzzle.dart';

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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 600;

    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  buildReferenceImage(),
                  buildPuzzleArea(),
                  _buildPieceBank(context, isSmallScreen),
                ],
              ),
            );
          },
        ),
        if (showSuccess) buildSuccessOverlay(),
      ],
    );
  }

  Widget _buildPieceBank(BuildContext context, bool isSmallScreen) {
    return Container(
      height:
          MediaQuery.of(context).size.height * (isSmallScreen ? 0.12 : 0.15),
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isSmallScreen ? 4 : 8,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: pieces
            .where((piece) => !placedPieces[piece.id]!)
            .map((piece) => SizedBox(
                  width: piece.size.width * (isSmallScreen ? 0.4 : 0.45),
                  height: piece.size.height * (isSmallScreen ? 0.4 : 0.45),
                  child: buildDraggablePiece(piece),
                ))
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
