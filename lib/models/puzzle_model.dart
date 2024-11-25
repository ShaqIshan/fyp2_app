class PuzzlePiece {
  final String id;
  final String label;
  final double dropZoneTop;
  final double heightRatio;

  PuzzlePiece({
    required this.id,
    required this.label,
    required this.dropZoneTop,
    required this.heightRatio,
  });
}

class PuzzleData {
  final String name;
  final List<PuzzlePiece> pieces;
  final int totalPieces;
  final String imageAsset;
  final String difficulty;

  PuzzleData({
    required this.name,
    required this.pieces,
    required this.totalPieces,
    required this.imageAsset,
    required this.difficulty,
  });
}
