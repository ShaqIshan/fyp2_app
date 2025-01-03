import 'package:flutter/material.dart';

class ActivityCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final int totalItems;

  ActivityCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.totalItems,
  });
}
