import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../models/childs_models/aac_board/aac_card_registry.dart';
import '../../../../models/childs_models/aac_board/aac_categories.dart';
import '../../../../models/childs_models/aac_board/base/aac_card_base_model.dart';

class AACBoardController with ChangeNotifier {
  late CategoryInfo _selectedCategory;
  final List<AACCardBaseModel> selectedCards = [];
  final Map<String, List<AACCardBaseModel>> _cardsByCategory =
      AACCardRegistry.getAllCards();
  final FlutterTts flutterTts = FlutterTts();

  final AnimationController bounceController;
  final AnimationController scaleController;
  late final Animation<double> bounceAnimation;
  late final Animation<double> scaleAnimation;
  bool isPlayingAnimation = false;
  final VoidCallback onStateChanged;

  AACBoardController({
    required TickerProvider vsync,
    required this.onStateChanged,
  })  : bounceController = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: vsync,
        ),
        scaleController = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: vsync,
        ) {
    _selectedCategory = AACCategories.categories.values.first;
    _initializeAnimations();
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    try {
      // Set handlers first
      flutterTts.setCompletionHandler(() {
        isPlayingAnimation = false;
        onStateChanged();
      });

      flutterTts.setErrorHandler((msg) {
        print("TTS error: $msg");
        isPlayingAnimation = false;
        onStateChanged();
      });

      // Initialize basic settings
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);

      // Check engine and language support
      var engines = await flutterTts.getEngines;
      print('Available engines: $engines');

      var languages = await flutterTts.getLanguages;
      print('Available languages: $languages');

      print('TTS initialized successfully');
    } catch (e) {
      print('Failed to initialize TTS: $e');
    }
  }

  CategoryInfo get selectedCategory => _selectedCategory;

  List<AACCardBaseModel> get currentCategoryCards =>
      _cardsByCategory[_selectedCategory.name.toLowerCase()] ?? [];

  void setSelectedCategory(CategoryInfo category) {
    if (_selectedCategory.name != category.name) {
      _selectedCategory = category;
      onStateChanged();
    }
  }

  void _initializeAnimations() {
    bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: bounceController,
      curve: Curves.easeInOut,
    ));

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> handleCardTap(AACCardBaseModel card) async {
    HapticFeedback.lightImpact();
    bounceController.forward().then((_) => bounceController.reset());

    if (!selectedCards.contains(card)) {
      selectedCards.add(card);
      onStateChanged();
    }
  }

  void clearSelectedCards() {
    HapticFeedback.mediumImpact();
    selectedCards.clear();
    scaleController.forward().then((_) => scaleController.reset());
    onStateChanged();
  }

  Future<void> playSelectedCards() async {
    if (isPlayingAnimation || selectedCards.isEmpty) return;

    try {
      isPlayingAnimation = true;
      onStateChanged();

      HapticFeedback.mediumImpact();

      // Construct the sentence from selected cards
      String sentence = selectedCards.map((card) => card.text).join(" ");

      print('Attempting to speak: $sentence');

      // Get engine status
      var engines = await flutterTts.getEngines;
      print('Available engines: $engines');

      // Speak the sentence
      var result = await flutterTts.speak(sentence);
      print('Speak result: $result');

      // Animate cards while speaking
      for (var card in selectedCards) {
        await bounceController.forward();
        await bounceController.reverse();
        await Future.delayed(const Duration(milliseconds: 200));
      }
    } catch (e) {
      print('TTS Error: $e');
      isPlayingAnimation = false;
      onStateChanged();
    }
  }

  Future<void> stopSpeaking() async {
    if (isPlayingAnimation) {
      await flutterTts.stop();
      isPlayingAnimation = false;
      onStateChanged();
    }
  }

  void dispose() {
    flutterTts.stop();
    bounceController.dispose();
    scaleController.dispose();
  }
}
