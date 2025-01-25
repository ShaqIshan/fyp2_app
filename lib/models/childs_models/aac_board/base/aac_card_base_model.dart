import 'package:flutter/material.dart';

class AACCardBaseModel {
  final String id;
  final String text;
  final IconData icon;
  final Color color;
  final String categoryId;

  const AACCardBaseModel({
    required this.id,
    required this.text,
    required this.icon,
    required this.color,
    required this.categoryId,
  });
}
