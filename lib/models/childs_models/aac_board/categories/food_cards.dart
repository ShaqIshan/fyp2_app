import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class FoodCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'food_1',
          text: 'Food',
          icon: Icons.restaurant,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
        const AACCardBaseModel(
          id: 'food_2',
          text: 'Water',
          icon: Icons.water_drop,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
        const AACCardBaseModel(
          id: 'food_3',
          text: 'Snack',
          icon: Icons.cookie,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
        const AACCardBaseModel(
          id: 'food_4',
          text: 'Drink',
          icon: Icons.local_drink,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
        const AACCardBaseModel(
          id: 'food_5',
          text: 'Breakfast',
          icon: Icons.free_breakfast,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
        const AACCardBaseModel(
          id: 'food_6',
          text: 'Lunch',
          icon: Icons.lunch_dining,
          color: AACCategories.mutedGreen,
          categoryId: 'food',
        ),
      ];
}
