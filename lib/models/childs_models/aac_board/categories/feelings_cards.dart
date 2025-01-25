import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class FeelingCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'feel_1',
          text: 'Happy',
          icon: Icons.sentiment_very_satisfied,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
        const AACCardBaseModel(
          id: 'feel_2',
          text: 'Sad',
          icon: Icons.sentiment_very_dissatisfied,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
        const AACCardBaseModel(
          id: 'feel_3',
          text: 'Tired',
          icon: Icons.bedtime,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
        const AACCardBaseModel(
          id: 'feel_4',
          text: 'Okay',
          icon: Icons.sentiment_satisfied,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
        const AACCardBaseModel(
          id: 'feel_5',
          text: 'Excited',
          icon: Icons.celebration,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
        const AACCardBaseModel(
          id: 'feel_6',
          text: 'Scared',
          icon: Icons.sentiment_very_dissatisfied,
          color: AACCategories.softPink,
          categoryId: 'feelings',
        ),
      ];
}
