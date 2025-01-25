import 'package:flutter/material.dart';

class AACCategories {
  // Color definitions
  static const Color softBlue = Color(0xFF5B9BD5);
  static const Color mutedGreen = Color(0xFF7FB069);
  static const Color softPink = Color(0xFFD4939D);
  static const Color skyBlue = Color(0xFF4B9FBA);
  static const Color lightBrown = Color(0xFFA0877E);
  static const Color sageGreen = Color(0xFF5BA69C);
  static const Color peach = Color(0xFFE6A28C);
  static const Color lavender = Color(0xFF8B88B3);
  static const Color mint = Color(0xFF6BAEA1);
  static const Color rosewood = Color(0xFFB67E7E);
  static const Color cornflower = Color(0xFF7C98B3);
  static const Color paleYellow = Color(0xFFD4B26A);
  static const Color lightPurple = Color(0xFF9B7CB3);
  static const Color sand = Color(0xFFA69B8D);

  static final Map<String, CategoryInfo> categories = {
    'want': CategoryInfo('Want', Icons.touch_app, softBlue),
    'food': CategoryInfo('Food', Icons.restaurant, mutedGreen),
    'feelings': CategoryInfo('Feelings', Icons.emoji_emotions, softPink),
    'actions': CategoryInfo('Actions', Icons.directions_run, skyBlue),
    'people': CategoryInfo('People', Icons.people, lightBrown),
    'animals': CategoryInfo('Animals', Icons.pets, sageGreen),
    'body': CategoryInfo('Body', Icons.accessibility_new, peach),
    'clothes': CategoryInfo('Clothes', Icons.checkroom, lavender),
    'vehicles': CategoryInfo('Vehicles', Icons.directions_car, mint),
    'places': CategoryInfo('Places', Icons.place, rosewood),
    'time': CategoryInfo('Time', Icons.access_time, cornflower),
    'questions': CategoryInfo('Questions', Icons.help, paleYellow),
    'relations': CategoryInfo('Relations', Icons.family_restroom, lightPurple),
    'tools': CategoryInfo('Tools', Icons.build, sand),
  };
}

class CategoryInfo {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryInfo(this.name, this.icon, this.color);
}
