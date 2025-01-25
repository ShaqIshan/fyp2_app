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

  const GameLevelWrapper({
    super.key,
    required this.title,
    required this.child,
    this.score,
    this.onBackPressed,
    this.showTimer = true,
    this.isCompleted = false,
    this.preventPop = false,
  });

  @override
  State<GameLevelWrapper> createState() => _GameLevelWrapperState();
}

class _GameLevelWrapperState extends State<GameLevelWrapper> {
  bool _isPaused = false;
  Key _timerKey = UniqueKey();

  void _handleTimeUp() {
    if (widget.isCompleted || !mounted) return;
    setState(() {
      _isPaused = true;
    });
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => TimeUpDialog(
          onTryAgain: _resetTimer,
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
                padding: const EdgeInsets.fromLTRB(4, 16, 24, 16),
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppTheme.childTurquoise,
                      onPressed: widget.onBackPressed ??
                          () {
                            if (mounted && !widget.preventPop) {
                              Navigator.pop(context);
                            }
                          },
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: AppTheme.childHeadingMedium.copyWith(
                          color: AppTheme.childTurquoise,
                        ),
                      ),
                    ),
                    if (widget.showTimer && !widget.isCompleted)
                      GameTimer(
                        key: _timerKey,
                        onTimeUp: _handleTimeUp,
                        isPaused: _isPaused,
                        isCompleted: widget.isCompleted,
                      ),
                    if (widget.score != null) ...[
                      const SizedBox(width: 16),
                      Container(
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
                              widget.score.toString(),
                              style: AppTheme.childTitleLarge.copyWith(
                                  color: AppTheme.childYellow, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
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
