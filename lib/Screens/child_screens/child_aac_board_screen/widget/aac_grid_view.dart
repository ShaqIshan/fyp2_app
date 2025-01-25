import 'package:flutter/material.dart';
import '../controller/aac_board_controller.dart';
import 'aac_card.dart';

class AACGridView extends StatelessWidget {
  final AACBoardController controller;

  const AACGridView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0), // Removed bottom margin
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE6F7FF),
          width: 2,
        ),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.currentCategoryCards.length,
        itemBuilder: (context, index) {
          final card = controller.currentCategoryCards[index];
          return ScaleTransition(
            scale: controller.selectedCards.contains(card)
                ? controller.bounceAnimation
                : const AlwaysStoppedAnimation(1.0),
            child: AACCard(
              text: card.text,
              icon: card.icon,
              iconColor: card.color,
              onTap: () => controller.handleCardTap(card),
              isSelected: controller.selectedCards.contains(card),
            ),
          );
        },
      ),
    );
  }
}
