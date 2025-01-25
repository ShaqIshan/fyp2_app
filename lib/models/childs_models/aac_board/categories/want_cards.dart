import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class WantCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'want_1',
          text: 'I want',
          icon: Icons.touch_app,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
        const AACCardBaseModel(
          id: 'want_2',
          text: 'I don\'t want',
          icon: Icons.do_not_touch,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
        const AACCardBaseModel(
          id: 'want_3',
          text: 'More',
          icon: Icons.add_circle_outline,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
        const AACCardBaseModel(
          id: 'want_4',
          text: 'Less',
          icon: Icons.remove_circle_outline,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
        const AACCardBaseModel(
          id: 'want_5',
          text: 'Please',
          icon: Icons.favorite_outline,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
        const AACCardBaseModel(
          id: 'want_6',
          text: 'Thank you',
          icon: Icons.volunteer_activism,
          color: AACCategories.softBlue,
          categoryId: 'want',
        ),
      ];
}
