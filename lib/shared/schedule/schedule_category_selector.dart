import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../models/schedule_categories.dart';

class ScheduleCategorySelector extends StatelessWidget {
  final ScheduleCategory? selectedCategory;
  final Function(ScheduleCategory) onCategorySelected;

  const ScheduleCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static final List<ScheduleCategory> _mainCategories = [
    // Row 1
    const ScheduleCategory(name: 'Learn', icon: Icons.school),
    const ScheduleCategory(name: 'Play', icon: Icons.sports_esports),
    const ScheduleCategory(name: 'Sleep', icon: Icons.bedtime),
    const ScheduleCategory(name: 'Eat', icon: Icons.restaurant),
    // Row 2
    const ScheduleCategory(name: 'Bath', icon: Icons.bathtub),
    const ScheduleCategory(name: 'Exercise', icon: Icons.fitness_center),
    const ScheduleCategory(name: 'Medicine', icon: Icons.medication),
    const ScheduleCategory(name: 'More', icon: Icons.add_circle_outline),
  ];

  static final List<ScheduleCategory> _extendedCategories = [
    const ScheduleCategory(name: 'Dress', icon: Icons.checkroom),
    const ScheduleCategory(name: 'Potty', icon: Icons.wc),
    const ScheduleCategory(name: 'Brush Teeth', icon: Icons.cleaning_services),
    const ScheduleCategory(name: 'Art', icon: Icons.palette),
    const ScheduleCategory(name: 'Music', icon: Icons.music_note),
    const ScheduleCategory(name: 'Story', icon: Icons.menu_book),
    const ScheduleCategory(name: 'Outside', icon: Icons.park),
    const ScheduleCategory(name: 'Therapy', icon: Icons.psychology),
    const ScheduleCategory(name: 'Doctor', icon: Icons.local_hospital),
    const ScheduleCategory(name: 'Friends', icon: Icons.group),
    const ScheduleCategory(name: 'School', icon: Icons.school_outlined),
    const ScheduleCategory(name: 'Transport', icon: Icons.directions_car),
    const ScheduleCategory(
        name: 'Chores', icon: Icons.cleaning_services_outlined),
    const ScheduleCategory(name: 'Screen', icon: Icons.tv),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        allCategories: [
          ..._mainCategories.where((c) => c.name != 'More'),
          ..._extendedCategories
        ],
      ),
    );
  }
}

class _CategorySelectionModal extends StatelessWidget {
  final ScheduleCategory? selectedCategory;
  final Function(ScheduleCategory) onCategorySelected;
  final List<ScheduleCategory> allCategories;

  const _CategorySelectionModal({
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.allCategories,
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                final category = allCategories[index];
                return InkWell(
                  onTap: () => onCategorySelected(category),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selectedCategory?.name == category.name
                            ? AppTheme.accentGreen
                            : Colors.grey.withOpacity(0.2),
                        width: selectedCategory?.name == category.name ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.icon,
                          color: selectedCategory?.name == category.name
                              ? AppTheme.accentGreen
                              : AppTheme.secondaryBrown,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.name,
                          style: AppTheme.bodyMedium.copyWith(
                            color: selectedCategory?.name == category.name
                                ? AppTheme.accentGreen
                                : AppTheme.secondaryBrown,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
