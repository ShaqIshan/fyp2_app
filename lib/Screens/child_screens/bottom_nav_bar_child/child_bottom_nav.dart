import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const ChildBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width to calculate responsive values
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: screenWidth * 0.02, // Responsive horizontal padding
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              index: 0,
              icon: Icons.home_rounded,
              color: Colors.orange,
              label: 'Home',
              isSelected: selectedIndex == 0,
            ),
            _buildNavItem(
              context: context,
              index: 1,
              icon: Icons.games_rounded,
              color: Colors.purple,
              label: 'Games',
              isSelected: selectedIndex == 1,
            ),
            _buildNavItem(
              context: context,
              index: 2,
              icon: Icons.grid_view_rounded,
              color: Colors.green,
              label: 'AAC Board',
              isSelected: selectedIndex == 2,
            ),
            _buildNavItem(
              context: context,
              index: 3,
              icon: Icons.calendar_today_rounded,
              color: Colors.blue,
              label: 'Schedule',
              isSelected: selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required Color color,
    required String label,
    required bool isSelected,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth =
        screenWidth / 4.5; // Divide screen into 4.5 parts for each item

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        width: itemWidth,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? itemWidth * 0.1 : itemWidth * 0.05,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? color : Colors.grey,
                size: isSelected ? 32 : 28, // Restored original icon sizes
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: AppTheme.bodyMedium.copyWith(
                    color: isSelected ? color : Colors.grey,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
