import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/models/schedule_categories.dart';

class CategoryGrid extends StatelessWidget {
  final ScheduleCategory? selectedCategory;
  final Function(ScheduleCategory?)
      onCategorySelected; // Updated to accept null
  final bool showExtendedCategories;

  const CategoryGrid({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
    this.showExtendedCategories = false,
  });

  static const List<ScheduleCategory> _mainCategories = [
    ScheduleCategory(name: 'Learn', icon: Icons.school),
    ScheduleCategory(name: 'Play', icon: Icons.sports_esports),
    ScheduleCategory(name: 'Sleep', icon: Icons.bedtime),
    ScheduleCategory(name: 'Eat', icon: Icons.restaurant),
    ScheduleCategory(name: 'Bath', icon: Icons.bathtub),
    ScheduleCategory(name: 'Exercise', icon: Icons.fitness_center),
    ScheduleCategory(name: 'Medicine', icon: Icons.medication),
    ScheduleCategory(name: 'More', icon: Icons.add_circle_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!showExtendedCategories) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category', style: AppTheme.titleMedium),
              if (selectedCategory != null)
                TextButton(
                  onPressed: () => onCategorySelected(null),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: AppTheme.secondaryBrown.withOpacity(0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.clear,
                        size: 16,
                        color: AppTheme.secondaryBrown,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Clear',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.secondaryBrown,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _mainCategories.length,
          itemBuilder: (context, index) {
            final category = _mainCategories[index];
            if (category.name == 'More') {
              return _buildMoreButton(context);
            }
            return _buildCategoryItem(category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(ScheduleCategory category) {
    final bool isSelected = selectedCategory?.name == category.name;

    return InkWell(
      onTap: () => onCategorySelected(category),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentGreen
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.accentGreen.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              color:
                  isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              category.name,
              style: AppTheme.bodyMedium.copyWith(
                color:
                    isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return InkWell(
      onTap: () => _showCategoryModal(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppTheme.secondaryBrown,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              'More',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CategorySelectionModal(
        selectedCategory: selectedCategory,
        onCategorySelected: (category) {
          Navigator.pop(context);
          onCategorySelected(category);
        },
      ),
    );
  }
}

class _CategorySelectionModal extends StatelessWidget {
  final ScheduleCategory? selectedCategory;
  final Function(ScheduleCategory?) onCategorySelected;

  const _CategorySelectionModal({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Select Category',
                  style: AppTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: CategoryGrid(
                selectedCategory: selectedCategory,
                onCategorySelected: onCategorySelected,
                showExtendedCategories: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
