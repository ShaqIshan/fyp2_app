import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../parent_access_dialog.dart';

class ChildHomeHeader extends StatelessWidget {
  const ChildHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ParentAccessDialog(),
                  );
                },
                icon: Icon(
                  Icons.lock_outlined,
                  color: AppTheme.childTurquoise.withOpacity(0.7),
                  size: 28,
                ),
                tooltip: 'Parent Access',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Little',
                      style: AppTheme.childBodyText.copyWith(
                        color: AppTheme.childTurquoise.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Sophia',
                      style: AppTheme.childHeadingLarge.copyWith(
                        color: AppTheme.childTurquoise,
                      ),
                    ),
                  ],
                ),
              ),
              const StarsWidget(),
            ],
          ),
          const SizedBox(height: 24),
          const ProgressBarWidget(),
        ],
      ),
    );
  }
}

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.childYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.childYellow.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: AppTheme.childYellow,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '25',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childYellow,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const progress = 0.6; // 60% progress
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Journey',
          style: AppTheme.childBodyText.copyWith(
            color: AppTheme.childTurquoise.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.childTurquoise,
                          AppTheme.childTurquoise.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
