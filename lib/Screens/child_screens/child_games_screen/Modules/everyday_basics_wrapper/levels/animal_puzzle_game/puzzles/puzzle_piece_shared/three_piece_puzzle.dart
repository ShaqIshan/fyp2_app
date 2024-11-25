// lib/shared/puzzle_components/three_piece_layout.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/puzzles/puzzle_piece_shared/base_puzzle.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// Extension of PiecePlacement for flexible positioning
class FlexiblePiecePlacement extends PiecePlacement {
  final double dropZoneTop;
  final double dropZoneLeft;
  final double dropZoneWidth;
  final double heightRatio;

  FlexiblePiecePlacement({
    required super.id,
    required super.image,
    required this.dropZoneTop,
    required this.dropZoneLeft,
    required this.dropZoneWidth,
    required this.heightRatio,
    required super.size,
  });
}

abstract class ThreePieceLayoutPuzzle
    extends BasePuzzle<FlexiblePiecePlacement> {
  const ThreePieceLayoutPuzzle({
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
  Widget buildPuzzleArea() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: puzzleAreaSize,
      height: puzzleAreaSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                referenceImage,
                width: puzzleAreaSize,
                height: puzzleAreaSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
          ...pieces
              .map((piece) => buildDropZone(piece as FlexiblePiecePlacement)),
          ...pieces.where((piece) => placedPieces[piece.id] == true).map(
            (piece) {
              final fPiece = piece as FlexiblePiecePlacement;
              return Positioned(
                top: fPiece.dropZoneTop * puzzleAreaSize,
                left: fPiece.dropZoneLeft * puzzleAreaSize,
                width: fPiece.dropZoneWidth * puzzleAreaSize,
                height: fPiece.heightRatio * puzzleAreaSize,
                child: Image.asset(
                  piece.image,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildDropZone(FlexiblePiecePlacement piece) {
    return Positioned(
      top: piece.dropZoneTop * puzzleAreaSize,
      left: piece.dropZoneLeft * puzzleAreaSize,
      width: piece.dropZoneWidth * puzzleAreaSize,
      height: piece.heightRatio * puzzleAreaSize,
      child: DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              color: candidateData.isNotEmpty
                  ? AppTheme.childSoftGreen.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
        onWillAcceptWithDetails: (details) => details.data == piece.id,
        onAcceptWithDetails: (details) {
          onPiecePlaced(piece.id, true);
        },
      ),
    );
  }
}
