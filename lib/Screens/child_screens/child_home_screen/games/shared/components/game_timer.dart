// lib/shared/components/game_timer.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class GameTimer extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback onTimeUp;
  final bool isPaused;
  final bool isCompleted;

  const GameTimer({
    super.key,
    this.durationInSeconds = 60,
    required this.onTimeUp,
    this.isPaused = false,
    this.isCompleted = false,
  });

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  Timer? _timer; // Make it nullable
  late int _remainingSeconds;
  bool _isTimeUp = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel if exists
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.isPaused || widget.isCompleted || !mounted) return;

      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else if (!_isTimeUp) {
          _isTimeUp = true;
          _timer?.cancel();
          widget.onTimeUp();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(GameTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted && !oldWidget.isCompleted) {
      _timer?.cancel();
    }
    if (widget.isPaused != oldWidget.isPaused) {
      if (!widget.isPaused) {
        // Reset the timer state when unpausing
        _timer?.cancel();
        _remainingSeconds = widget.durationInSeconds;
        _isTimeUp = false;
        _startTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.durationInSeconds;
    final isLowTime =
        _remainingSeconds <= 30; // Warning when 30 seconds or less remain

    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            isLowTime ? AppTheme.childOrange : AppTheme.childTurquoise,
          ),
          minHeight: 4,
        ),
      ),
    );
  }
}
