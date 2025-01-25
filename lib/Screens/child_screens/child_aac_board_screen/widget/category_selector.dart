import 'package:flutter/material.dart';
import '../../../../models/childs_models/aac_board/aac_categories.dart';
import '../../../../shared/app_theme.dart';

class CategorySelector extends StatelessWidget {
  final CategoryInfo selectedCategory;
  final Function(CategoryInfo) onCategorySelected;

  const CategorySelector({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AACCategories.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final category = AACCategories.categories.values.elementAt(index);
          final isSelected = category.name == selectedCategory.name;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _CategoryChip(
              category: category,
              isSelected: isSelected,
              onTap: () => onCategorySelected(category),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final CategoryInfo category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.category.color.withOpacity(0.2)
              : _isHovered
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: widget.isSelected
                ? widget.category.color
                : Colors.grey.withOpacity(0.3),
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.category.icon,
                    color: widget.category.color,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.category.name,
                    style: AppTheme.childBodyText.copyWith(
                      color: widget.category.color,
                      fontWeight: widget.isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
