// lib/shared/wrapper/game_level_wrapper.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../components/game_timer.dart';
import '../components/time_up_dialog.dart';

class GameLevelWrapper extends StatefulWidget {
  final String title;
  final Widget child;
  final int? score;
  final VoidCallback? onBackPressed;
  final bool showTimer;
  final bool isCompleted;
  final bool preventPop;
  final VoidCallback? onTimeUp;
  final bool isPaused;

  const GameLevelWrapper({
    super.key,
    required this.title,
    required this.child,
    this.score,
    this.onBackPressed,
    this.showTimer = true,
    this.isCompleted = false,
    this.preventPop = false,
    this.onTimeUp,
    this.isPaused = false,
  });

  @override
  State<GameLevelWrapper> createState() => _GameLevelWrapperState();
}

class _GameLevelWrapperState extends State<GameLevelWrapper> {
  bool _isPaused = false;
  Key _timerKey = UniqueKey();

  void _handleTimeUp() {
    if (widget.isCompleted || !mounted) return;

    // Call the widget's onTimeUp callback if provided
    widget.onTimeUp?.call();

    setState(() {
      _isPaused = true;
    });
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => TimeUpDialog(
          onTryAgain: () {
            _resetTimer();
            Navigator.of(context).pop(); // Close dialog first
          },
        ),
      );
    }
  }

  void _resetTimer() {
    if (!mounted) return;
    setState(() {
      _isPaused = false;
      _timerKey = UniqueKey();
    });
  }

  Future<bool> _onWillPop() async {
    if (widget.preventPop) return false;
    return true;
  }

  Widget _buildStars() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.childYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: AppTheme.childYellow,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            '3',
            style: AppTheme.childTitleLarge
                .copyWith(color: AppTheme.childYellow, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.childSkyBlue,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                decoration: BoxDecoration(
                  color: AppTheme.childCream,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.childTurquoise.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppTheme.childTurquoise,
                        size: 24,
                      ),
                      onPressed: widget.onBackPressed ??
                          () {
                            if (mounted && !widget.preventPop) {
                              Navigator.pop(context);
                            }
                          },
                    ),
                    // Timer section
                    if (widget.showTimer && !widget.isCompleted)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: AppTheme.childTurquoise,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GameTimer(
                                  key: _timerKey,
                                  onTimeUp: _handleTimeUp,
                                  isPaused: widget.isPaused ||
                                      _isPaused, // Consider both local and widget pause states
                                  isCompleted: widget.isCompleted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    _buildStars(),
                  ],
                ),
              ),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
