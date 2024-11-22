// lib/screens/child_screens/child_aac_board/child_aac_board.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildAACBoard extends StatelessWidget {
  const ChildAACBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock categories - will be replaced with actual data later
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'I Want',
        'icon': Icons.favorite_outline,
        'color': AppTheme.childPurple,
      },
      {
        'name': 'I Feel',
        'icon': Icons.emoji_emotions_outlined,
        'color': AppTheme.childOrange,
      },
      {
        'name': 'Activities',
        'icon': Icons.sports_basketball_outlined,
        'color': AppTheme.childTurquoise,
      },
      {
        'name': 'Food',
        'icon': Icons.restaurant_outlined,
        'color': AppTheme.childSoftGreen,
      },
      {
        'name': 'Help',
        'icon': Icons.help_outline,
        'color': AppTheme.childPink,
      },
      {
        'name': 'Yes/No',
        'icon': Icons.check_circle_outline,
        'color': AppTheme.childYellow,
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My AAC Board',
          style: AppTheme.childHeadingLarge,
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(
            name: category['name'],
            icon: category['icon'],
            color: category['color'],
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to specific category board
            print('Selected category: $name');
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: AppTheme.childTitleLarge.copyWith(
                    color: color,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
