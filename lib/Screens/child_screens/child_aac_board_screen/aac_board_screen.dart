import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/app_theme.dart';
import '../../../models/childs_models/aac_board/aac_categories.dart';
import 'controller/aac_board_controller.dart';
import 'widget/aac_controls.dart';
import 'widget/aac_grid_view.dart';
import 'widget/category_selector.dart';
import 'widget/selected_cards_view.dart';

class ChildAACBoard extends StatefulWidget {
  const ChildAACBoard({Key? key}) : super(key: key);

  @override
  State<ChildAACBoard> createState() => _ChildAACBoardState();
}

class _ChildAACBoardState extends State<ChildAACBoard>
    with TickerProviderStateMixin {
  late AACBoardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AACBoardController(
      vsync: this,
      onStateChanged: () => setState(() {}),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF9EC),
                    Color(0xFFFFEFD5),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SelectedCardsView(
                      controller: _controller,
                    ),
                    const SizedBox(height: 16),
                    AACControls(
                      onClear: _controller.clearSelectedCards,
                      onPlay: _controller.playSelectedCards,
                      isPlaying: _controller.isPlayingAnimation,
                    ),
                  ],
                ),
              ),
            ),
            CategorySelector(
              selectedCategory: _controller.selectedCategory,
              onCategorySelected: _controller.setSelectedCategory,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20), // Space for navbar
                child: AACGridView(
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
