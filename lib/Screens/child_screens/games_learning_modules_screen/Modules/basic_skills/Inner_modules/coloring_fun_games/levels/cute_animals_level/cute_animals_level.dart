import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../../overall_levels_components_shared/head_components/head_coloring_theme.dart';
import '../../overall_levels_components_shared/levels_components_shared/cute_animals_level_components/cute_animals_components/cute_animals_canvas.dart';

class CuteAnimalsLevel extends StatefulWidget {
  final VoidCallback? onGameComplete;

  const CuteAnimalsLevel({
    Key? key,
    this.onGameComplete,
  }) : super(key: key);

  @override
  State<CuteAnimalsLevel> createState() => _CuteAnimalsLevelState();
}

class _CuteAnimalsLevelState extends State<CuteAnimalsLevel> {
  Color selectedColor = ColoringTheme.basicColors.first.color;
  double strokeWidth = 15.0;
  bool isEraser = false;
  String currentAnimal = 'cat';
  final GlobalKey<State> canvasKey = GlobalKey();

  void _handleColorSelected(Color color) {
    setState(() {
      selectedColor = color;
      isEraser = false;
    });
  }

  void _handleEraserSelected() {
    setState(() {
      isEraser = true;
      selectedColor = Colors.white;
    });
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
          onTap: _handleEraserSelected,
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const colorPaletteHeight = 120.0;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = size.height - colorPaletteHeight - appBarHeight;

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.childTurquoise,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Coloring Fun',
            style: AppTheme.childHeadingMedium.copyWith(
              color: AppTheme.childTurquoise,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Drawing area taking all available space
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: CuteAnimalsCanvas(
                    key: canvasKey,
                    animal: currentAnimal,
                    width: size.width - 40,
                    height: availableHeight -
                        16, // Subtracting total vertical padding
                    currentColor: selectedColor,
                    strokeWidth: isEraser
                        ? ColoringTheme.eraserSize
                        : ColoringTheme.defaultBrushSize,
                    onComplete: widget.onGameComplete,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 32,
                  child: _buildEraserButton(),
                ),
              ],
            ),
          ),
          // Color palette with fixed height
          Container(
            height: colorPaletteHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: ColoringTheme.basicColors.map((colorChoice) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildColorButton(
                      colorChoice.color,
                      colorChoice.name,
                      selectedColor == colorChoice.color && !isEraser,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(Color color, String name, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60, // Increased from 50 to 60
          height: 60, // Increased from 50 to 60
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
              onTap: () => _handleColorSelected(color),
              borderRadius: BorderRadius.circular(30),
              child: Container(),
            ),
          ),
        ),
        const SizedBox(height: 8), // Increased from 4 to 8
        Text(
          name,
          style: AppTheme.childBodyText.copyWith(
            fontSize: 14, // Increased from 12 to 14
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
