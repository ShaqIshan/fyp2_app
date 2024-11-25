// lib/shared/puzzle_components/two_piece_layout.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/puzzles/puzzle_piece_shared/base_puzzle.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// Extension of PiecePlacement for vertical stacking layout
class VerticalPiecePlacement extends PiecePlacement {
  final double dropZoneTop;
  final double heightRatio;

  VerticalPiecePlacement({
    required super.id,
    required super.image,
    required this.dropZoneTop,
    required this.heightRatio,
    required super.size,
  });
}

abstract class TwoPieceLayoutPuzzle extends BasePuzzle<VerticalPiecePlacement> {
  const TwoPieceLayoutPuzzle({
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
              .map((piece) => buildDropZone(piece as VerticalPiecePlacement)),
          ...pieces.where((piece) => placedPieces[piece.id] == true).map(
            (piece) {
              final vPiece = piece as VerticalPiecePlacement;
              return Positioned(
                top: vPiece.dropZoneTop * puzzleAreaSize,
                left: 0,
                right: 0,
                height: vPiece.heightRatio * puzzleAreaSize,
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
  Widget buildDropZone(VerticalPiecePlacement piece) {
    return Positioned(
      top: piece.dropZoneTop * puzzleAreaSize,
      left: 0,
      right: 0,
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
