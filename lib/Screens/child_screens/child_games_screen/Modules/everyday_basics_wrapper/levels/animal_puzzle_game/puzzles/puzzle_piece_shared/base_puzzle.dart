// lib/shared/puzzle_components/base_puzzle.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// Base class for all puzzle pieces
class PiecePlacement {
  final String id;
  final String image;
  final Size size;

  PiecePlacement({
    required this.id,
    required this.image,
    required this.size,
  });
}

abstract class BasePuzzle<T extends PiecePlacement> extends StatelessWidget {
  final double puzzleAreaSize;
  final String referenceImage;
  final List<T> pieces;
  final Function(String, bool) onPiecePlaced;
  final bool showSuccess;
  final VoidCallback onNext;
  final VoidCallback onReset;
  final Map<String, bool> placedPieces;

  const BasePuzzle({
    super.key,
    required this.puzzleAreaSize,
    required this.referenceImage,
    required this.pieces,
    required this.onPiecePlaced,
    required this.showSuccess,
    required this.onNext,
    required this.onReset,
    required this.placedPieces,
  });

  // Shared methods that don't depend on piece layout
  Widget buildReferenceImage() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: puzzleAreaSize * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          referenceImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildSuccessOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.celebration,
                color: AppTheme.childYellow,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Great Job! 🎉',
                style: AppTheme.childHeadingLarge.copyWith(
                  color: AppTheme.childTurquoise,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSuccessButton(
                    'Try Again',
                    AppTheme.childTurquoise,
                    onReset,
                  ),
                  const SizedBox(width: 8),
                  buildSuccessButton(
                    'Next Puzzle',
                    AppTheme.childPurple,
                    onNext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuccessButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: AppTheme.childBodyText.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDraggablePiece(T piece) {
    return Draggable<String>(
      data: piece.id,
      feedback: Image.asset(
        piece.image,
        width: piece.size.width,
        height: piece.size.height,
        fit: BoxFit.contain,
      ),
      childWhenDragging: const SizedBox(),
      child: Image.asset(
        piece.image,
        width: piece.size.width * 0.5,
        height: piece.size.height * 0.5,
        fit: BoxFit.contain,
      ),
    );
  }

  // Abstract methods to be implemented by specific layouts
  Widget buildPuzzleArea();
  Widget buildDropZone(T piece);
}
