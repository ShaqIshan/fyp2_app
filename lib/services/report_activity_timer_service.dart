// lib/services/activity_timer_service.dart

import 'dart:async';
import 'package:flutter/foundation.dart';

import 'report_progress_service.dart';

class ActivityTimerService {
  static final ActivityTimerService _instance =
      ActivityTimerService._internal();
  factory ActivityTimerService() => _instance;
  ActivityTimerService._internal();

  Timer? _timer;
  final ProgressService _progressService = ProgressService();

  void startTracking(String childId) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _progressService.updateProgress(
        childId: childId,
        minutesPlayed: 1,
      );
    });
  }

  void stopTracking() {
    _timer?.cancel();
    _timer = null;
  }
}
