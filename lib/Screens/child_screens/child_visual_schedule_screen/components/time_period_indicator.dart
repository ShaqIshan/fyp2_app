import 'package:flutter/material.dart';

import '../../../../shared/app_theme.dart';

class TimePeriodIndicator extends StatelessWidget {
  final AnimationController controller;
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const TimePeriodIndicator({
    super.key,
    required this.controller,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeIndicator(
            'Morning',
            Icons.wb_sunny_rounded,
            AppTheme.childOrange,
            0.0,
          ),
          _buildTimeIndicator(
            'Afternoon',
            Icons.wb_cloudy_rounded,
            AppTheme.childTurquoise,
            0.2,
          ),
          _buildTimeIndicator(
            'Night',
            Icons.nights_stay_rounded,
            AppTheme.childPurple,
            0.4,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeIndicator(
    String label,
    IconData icon,
    Color color,
    double delay,
  ) {
    final isSelected = selectedPeriod == label.toLowerCase();

    return GestureDetector(
      onTap: () => onPeriodSelected(label.toLowerCase()),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              delay,
              delay + 0.3,
              curve: Curves.elasticOut,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(isSelected ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(15),
                border: isSelected ? Border.all(color: color, width: 2) : null,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTheme.childBodyText.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
