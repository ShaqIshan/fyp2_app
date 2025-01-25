import 'package:flutter/material.dart';

class ScheduleItem {
  final String id;
  final String time;
  final String activity;
  final IconData icon;
  final Color color;
  final String period;
  final String duration;
  final bool isCompleted;

  const ScheduleItem({
    required this.id,
    required this.time,
    required this.activity,
    required this.icon,
    required this.color,
    required this.period,
    required this.duration,
    this.isCompleted = false,
  });

  ScheduleItem copyWith({
    String? id,
    String? time,
    String? activity,
    IconData? icon,
    Color? color,
    String? period,
    String? duration,
    bool? isCompleted,
  }) {
    return ScheduleItem(
      id: id ?? this.id,
      time: time ?? this.time,
      activity: activity ?? this.activity,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      period: period ?? this.period,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
