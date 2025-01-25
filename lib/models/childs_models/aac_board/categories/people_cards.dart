import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class PeopleCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'people_1',
          text: 'Mom',
          icon: Icons.face_outlined,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
        const AACCardBaseModel(
          id: 'people_2',
          text: 'Dad',
          icon: Icons.face,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
        const AACCardBaseModel(
          id: 'people_3',
          text: 'Friend',
          icon: Icons.person_outline,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
        const AACCardBaseModel(
          id: 'people_4',
          text: 'Teacher',
          icon: Icons.school,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
        const AACCardBaseModel(
          id: 'people_5',
          text: 'Sister',
          icon: Icons.face_outlined,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
        const AACCardBaseModel(
          id: 'people_6',
          text: 'Brother',
          icon: Icons.face,
          color: AACCategories.lightBrown,
          categoryId: 'people',
        ),
      ];
}
