import 'package:flutter/material.dart';
import '../../../../shared/app_theme.dart';
import '../controller/aac_board_controller.dart';
import 'aac_card.dart';

class SelectedCardsView extends StatelessWidget {
  final AACBoardController controller;

  const SelectedCardsView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: const Color(0xFFF2E8D5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.childTurquoise.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: controller.selectedCards.isEmpty
          ? _buildEmptyState()
          : _buildSelectedCardsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app,
            size: 40,
            color: AppTheme.childTurquoise.withOpacity(0.8),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap cards to talk!',
            style: AppTheme.childHeadingMedium.copyWith(
              color: AppTheme.childTurquoise,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedCardsList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.selectedCards.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final card = controller.selectedCards[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ScaleTransition(
            scale: controller.bounceAnimation,
            child: AACCard(
              text: card.text,
              icon: card.icon,
              iconColor: card.color,
              onTap: () {},
              isCompact: true,
            ),
          ),
        );
      },
    );
  }
}
