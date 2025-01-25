import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class AnimalCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'animal_1',
          text: 'Dog',
          icon: Icons.pets,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
        const AACCardBaseModel(
          id: 'animal_2',
          text: 'Cat',
          icon: Icons.pets,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
        const AACCardBaseModel(
          id: 'animal_3',
          text: 'Bird',
          icon: Icons.flutter_dash,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
        const AACCardBaseModel(
          id: 'animal_4',
          text: 'Fish',
          icon: Icons.water,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
        const AACCardBaseModel(
          id: 'animal_5',
          text: 'Rabbit',
          icon: Icons.pets,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
        const AACCardBaseModel(
          id: 'animal_6',
          text: 'Duck',
          icon: Icons.flutter_dash,
          color: AACCategories.sageGreen,
          categoryId: 'animals',
        ),
      ];
}
