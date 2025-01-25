// lib/widgets/aac_card.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class AACCard extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isCompact;

  const AACCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.isSelected = false,
    this.isCompact = false,
  }) : super(key: key);

  @override
  State<AACCard> createState() => _AACCardState();
}

class _AACCardState extends State<AACCard> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHoverChange(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverChange(true),
      onExit: (_) => _handleHoverChange(false),
      child: ScaleTransition(
        scale: _hoverAnimation,
        child: Container(
          width: widget.isCompact ? 100 : null,
          margin: widget.isCompact
              ? const EdgeInsets.symmetric(horizontal: 4)
              : null,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  widget.iconColor.withOpacity(widget.isSelected ? 0.3 : 0.1),
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.iconColor.withOpacity(_isHovered ? 0.2 : 0.1),
                blurRadius: _isHovered ? 8 : 4,
                offset: const Offset(0, 2),
                spreadRadius: _isHovered ? 1 : 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: widget.iconColor.withOpacity(0.1),
              highlightColor: widget.iconColor.withOpacity(0.05),
              child: Padding(
                padding: widget.isCompact
                    ? const EdgeInsets.all(8)
                    : const EdgeInsets.all(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final iconSize = widget.isCompact ? 24.0 : 32.0;
                    final availableHeight = constraints.maxHeight;
                    final iconContainerHeight =
                        iconSize + 24; // icon size + padding
                    final spacingHeight = 4.0;
                    final availableTextHeight =
                        availableHeight - iconContainerHeight - spacingHeight;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon container
                        Container(
                          padding: EdgeInsets.all(widget.isCompact ? 8 : 12),
                          decoration: BoxDecoration(
                            color: widget.iconColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.icon,
                            size: iconSize,
                            color: widget.iconColor,
                          ),
                        ),
                        SizedBox(height: spacingHeight),
                        // Text container
                        Container(
                          height: availableTextHeight,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.text,
                              style: (widget.isCompact
                                      ? AppTheme.childBodyText
                                      : AppTheme.childTitleLarge)
                                  .copyWith(
                                color: widget.iconColor,
                                fontSize: widget.isCompact ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
