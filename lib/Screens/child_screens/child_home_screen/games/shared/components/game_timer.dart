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
  late Timer _timer;
  late int _remainingSeconds;
  bool _isTimeUp = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.isPaused || widget.isCompleted || !mounted) return;

      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else if (!_isTimeUp) {
          _isTimeUp = true;
          _timer.cancel();
          widget.onTimeUp();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(GameTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted && !oldWidget.isCompleted) {
      _timer.cancel();
    }
    if (widget.isPaused != oldWidget.isPaused) {
      if (!widget.isPaused) {
        _startTimer();
      }
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.durationInSeconds;
    final isLowTime =
        _remainingSeconds <= 30; // Warning when 30 seconds or less remain

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: isLowTime ? AppTheme.childOrange : AppTheme.childTurquoise,
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatTime(_remainingSeconds),
                style: AppTheme.childBodyText.copyWith(
                  color: isLowTime
                      ? AppTheme.childOrange
                      : AppTheme.childTurquoise,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isLowTime
                          ? AppTheme.childOrange
                          : AppTheme.childTurquoise,
                    ),
                    minHeight: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
