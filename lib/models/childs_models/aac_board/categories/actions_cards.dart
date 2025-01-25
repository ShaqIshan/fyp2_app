import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class ActionCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'action_1',
          text: 'Play',
          icon: Icons.sports_esports,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
        const AACCardBaseModel(
          id: 'action_2',
          text: 'Sleep',
          icon: Icons.bedtime,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
        const AACCardBaseModel(
          id: 'action_3',
          text: 'Walk',
          icon: Icons.directions_walk,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
        const AACCardBaseModel(
          id: 'action_4',
          text: 'Run',
          icon: Icons.directions_run,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
        const AACCardBaseModel(
          id: 'action_5',
          text: 'Eat',
          icon: Icons.restaurant,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
        const AACCardBaseModel(
          id: 'action_6',
          text: 'Drink',
          icon: Icons.local_drink,
          color: AACCategories.skyBlue,
          categoryId: 'actions',
        ),
      ];
}
