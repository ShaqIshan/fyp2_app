import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'base_puzzle.dart';

class FlexiblePiecePlacement extends PiecePlacement {
  final double dropZoneTop;
  final double dropZoneLeft;
  final double dropZoneWidth;
  final double heightRatio;
  final double hitboxPadding;

  FlexiblePiecePlacement({
    required super.id,
    required super.image,
    required this.dropZoneTop,
    required this.dropZoneLeft,
    required this.dropZoneWidth,
    required this.heightRatio,
    required super.size,
    this.hitboxPadding = 20.0,
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
    super.isLastPuzzle,
  });

  @override
  Widget buildPuzzleArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth - 40;
        final maxHeight = constraints.maxHeight - 20;
        final size = _calculatePuzzleSize(maxWidth, maxHeight);

        return Center(
          child: Container(
            width: size,
            height: size,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        referenceImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  ...pieces.map((piece) => buildDropZone(piece)),
                  ...pieces
                      .where((piece) => placedPieces[piece.id] == true)
                      .map(
                    (piece) {
                      return Positioned(
                        top: piece.dropZoneTop * size,
                        left: piece.dropZoneLeft * size,
                        width: piece.dropZoneWidth * size,
                        height: piece.heightRatio * size,
                        child: Image.asset(
                          piece.image,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _calculatePuzzleSize(double maxWidth, double maxHeight) {
    return maxWidth < maxHeight ? maxWidth : maxHeight;
  }

  @override
  Widget buildDropZone(FlexiblePiecePlacement piece) {
    return Builder(
      builder: (context) {
        final size = _calculatePuzzleSize(
          MediaQuery.of(context).size.width - 40,
          MediaQuery.of(context).size.height - 20,
        );

        final expandedTop = (piece.dropZoneTop * size) - piece.hitboxPadding;
        final expandedLeft = (piece.dropZoneLeft * size) - piece.hitboxPadding;
        final expandedWidth =
            (piece.dropZoneWidth * size) + (piece.hitboxPadding * 2);
        final expandedHeight =
            (piece.heightRatio * size) + (piece.hitboxPadding * 2);

        return Positioned(
          top: expandedTop,
          left: expandedLeft,
          width: expandedWidth,
          height: expandedHeight,
          child: IgnorePointer(
            ignoring: placedPieces[piece.id] == true,
            child: DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  decoration: BoxDecoration(
                    color: candidateData.isNotEmpty
                        ? AppTheme.childSoftGreen.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                );
              },
              onWillAcceptWithDetails: (details) {
                if (details.data != piece.id) return false;
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localPosition = box.globalToLocal(details.offset);
                final relativeX = localPosition.dx / expandedWidth;

                if (piece.id == 'tail') {
                  return relativeX > 0.3;
                }
                if (piece.id == 'head') {
                  return relativeX < 0.7;
                }
                return true;
              },
              onAcceptWithDetails: (details) {
                onPiecePlaced(piece.id, true);
              },
            ),
          ),
        );
      },
    );
  }
}
