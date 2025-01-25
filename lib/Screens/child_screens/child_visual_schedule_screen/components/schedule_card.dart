import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../../../../models/childs_models/visual_schedule/schedule_item.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;
  final bool isActive;
  final bool isNext;
  final Animation<double>? slideAnimation;
  final String currentPeriod;

  const ScheduleCard({
    super.key,
    required this.item,
    required this.currentPeriod,
    this.isActive = false,
    this.isNext = false,
    this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    // Only show the card if it belongs to the current period
    if (item.period != currentPeriod) {
      return const SizedBox.shrink();
    }

    Widget card = Padding(
      padding: EdgeInsets.only(
        bottom: 12,
        left: isActive ? 0 : 16,
        right: isActive ? 0 : 16,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppTheme.childCream,
          borderRadius: BorderRadius.circular(24),
          border: isActive || isNext
              ? Border.all(
                  color: isActive ? item.color : AppTheme.childYellow,
                  width: 3,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: isActive ? 90 : 80,
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Icon(
                item.icon,
                size: 32,
                color: item.color,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.activity,
                        style: AppTheme.childTitleLarge.copyWith(
                          color: item.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (isActive || isNext)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? item.color.withOpacity(0.2)
                              : AppTheme.childYellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isActive
                                  ? Icons.play_circle
                                  : Icons.arrow_forward,
                              size: 18,
                              color:
                                  isActive ? item.color : AppTheme.childYellow,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isActive ? 'Now' : 'Next',
                              style: AppTheme.childBodyText.copyWith(
                                color: isActive
                                    ? item.color
                                    : AppTheme.childYellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Apply slide animation if provided
    if (slideAnimation != null) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(slideAnimation!),
        child: card,
      );
    }

    return card;
  }
}
