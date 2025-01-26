class ChildProfile {
  final String id;
  final String name;
  final bool textToSpeechEnabled;
  final String? communicationBoardGrid;

  ChildProfile({
    required this.id,
    required this.name,
    this.textToSpeechEnabled = true,
    this.communicationBoardGrid,
  });
}
