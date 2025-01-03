import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../head_coloring_theme.dart';

class HeadColorPalette extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;
  final bool isEraser;
  final VoidCallback onEraserSelected;

  const HeadColorPalette({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
    required this.isEraser,
    required this.onEraserSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Floating Eraser Button
        Positioned(
          top: -70, // Position above the color palette
          right: 20,
          child: _buildEraserButton(),
        ),
        // Scrollable Color Palette
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 85, // Fixed height for the scrollable area
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ...ColoringTheme.basicColors.map((colorChoice) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _buildColorButton(
                            colorChoice.color,
                            colorChoice.name,
                            selectedColor == colorChoice.color && !isEraser,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorButton(Color color, String name, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50, // Slightly smaller for better fit
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppTheme.childTurquoise : Colors.white,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onColorSelected(color),
              borderRadius: BorderRadius.circular(25),
              child: Container(),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTheme.childBodyText.copyWith(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildEraserButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEraserSelected,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isEraser ? AppTheme.childTurquoise : Colors.grey.shade300,
                width: 4,
              ),
            ),
            child: Icon(
              Icons.auto_fix_normal_rounded,
              color: isEraser ? AppTheme.childTurquoise : Colors.grey,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
