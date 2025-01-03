import 'package:flutter/material.dart';

class ScheduleCategory {
  final String name;
  final IconData icon;
  final String description;

  const ScheduleCategory({
    required this.name,
    required this.icon,
    this.description = '',
  });
}
