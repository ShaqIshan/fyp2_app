class LevelProgress {
  final int levelId;
  final bool isCompleted;
  final bool isUnlocked;
  final int earnedStars;
  final DateTime lastPlayed;

  LevelProgress({
    required this.levelId,
    this.isCompleted = false,
    this.isUnlocked = false,
    this.earnedStars = 0,
    DateTime? lastPlayed,
  }) : lastPlayed = lastPlayed ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'levelId': levelId,
      'isCompleted': isCompleted,
      'isUnlocked': isUnlocked,
      'earnedStars': earnedStars,
      'lastPlayed': lastPlayed.toIso8601String(),
    };
  }

  factory LevelProgress.fromMap(Map<String, dynamic> map) {
    return LevelProgress(
      levelId: map['levelId'] ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      isUnlocked: map['isUnlocked'] ?? false,
      earnedStars: map['earnedStars'] ?? 0,
      lastPlayed:
          DateTime.parse(map['lastPlayed'] ?? DateTime.now().toIso8601String()),
    );
  }
}
