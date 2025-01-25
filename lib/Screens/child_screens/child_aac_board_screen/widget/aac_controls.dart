// lib/widgets/aac_controls.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class AACControls extends StatefulWidget {
  final VoidCallback onClear;
  final VoidCallback onPlay;
  final bool isPlaying;

  const AACControls({
    Key? key,
    required this.onClear,
    required this.onPlay,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  State<AACControls> createState() => _AACControlsState();
}

class _AACControlsState extends State<AACControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isClearHovered = false;
  bool _isPlayHovered = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.isPlaying) {
      _pulseController.repeat();
    }
  }

  @override
  void didUpdateWidget(AACControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _pulseController.repeat();
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Clear/Restart button with hover effect
        MouseRegion(
          onEnter: (_) => setState(() => _isClearHovered = true),
          onExit: (_) => setState(() => _isClearHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF7E7E),
                  const Color(0xFFFF6B6B)
                      .withOpacity(_isClearHovered ? 0.8 : 1.0),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF7E7E)
                      .withOpacity(_isClearHovered ? 0.4 : 0.2),
                  blurRadius: _isClearHovered ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onClear,
                borderRadius: BorderRadius.circular(16),
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Color.fromARGB(255, 135, 0, 0),
                  size: 32,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Play button with animations
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isPlayHovered = true),
            onExit: (_) => setState(() => _isPlayHovered = false),
            child: ScaleTransition(
              scale: widget.isPlaying
                  ? _pulseAnimation
                  : const AlwaysStoppedAnimation(1.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFFFFB946),
                      const Color(0xFFFFAB2E)
                          .withOpacity(_isPlayHovered ? 0.8 : 1.0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB946)
                          .withOpacity(_isPlayHovered ? 0.4 : 0.2),
                      blurRadius: _isPlayHovered ? 12 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onPlay,
                    borderRadius: BorderRadius.circular(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.isPlaying
                              ? Icons.volume_up
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.isPlaying ? 'Speaking...' : 'Play',
                          style: AppTheme.childHeadingMedium.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
