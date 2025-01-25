import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class RelationCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'relation_1',
          text: 'Family',
          icon: Icons.family_restroom,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
        const AACCardBaseModel(
          id: 'relation_2',
          text: 'Friend',
          icon: Icons.people_outline,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
        const AACCardBaseModel(
          id: 'relation_3',
          text: 'Teacher',
          icon: Icons.school,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
        const AACCardBaseModel(
          id: 'relation_4',
          text: 'Doctor',
          icon: Icons.medical_services,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
        const AACCardBaseModel(
          id: 'relation_5',
          text: 'Neighbor',
          icon: Icons.home,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
        const AACCardBaseModel(
          id: 'relation_6',
          text: 'Helper',
          icon: Icons.support_agent,
          color: AACCategories.lightPurple,
          categoryId: 'relations',
        ),
      ];
}
