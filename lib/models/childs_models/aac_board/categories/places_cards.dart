import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class PlaceCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'place_1',
          text: 'Home',
          icon: Icons.home,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
        const AACCardBaseModel(
          id: 'place_2',
          text: 'School',
          icon: Icons.school,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
        const AACCardBaseModel(
          id: 'place_3',
          text: 'Park',
          icon: Icons.park,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
        const AACCardBaseModel(
          id: 'place_4',
          text: 'Store',
          icon: Icons.store,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
        const AACCardBaseModel(
          id: 'place_5',
          text: 'Bathroom',
          icon: Icons.bathroom,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
        const AACCardBaseModel(
          id: 'place_6',
          text: 'Restaurant',
          icon: Icons.restaurant,
          color: AACCategories.rosewood,
          categoryId: 'places',
        ),
      ];
}
