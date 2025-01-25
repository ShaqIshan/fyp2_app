import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class ClothesCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'clothes_1',
          text: 'Shirt',
          icon: Icons.checkroom,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
        const AACCardBaseModel(
          id: 'clothes_2',
          text: 'Pants',
          icon: Icons.checkroom,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
        const AACCardBaseModel(
          id: 'clothes_3',
          text: 'Shoes',
          icon: Icons.do_not_step,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
        const AACCardBaseModel(
          id: 'clothes_4',
          text: 'Socks',
          icon: Icons.do_not_step,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
        const AACCardBaseModel(
          id: 'clothes_5',
          text: 'Hat',
          icon: Icons.face,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
        const AACCardBaseModel(
          id: 'clothes_6',
          text: 'Jacket',
          icon: Icons.checkroom,
          color: AACCategories.lavender,
          categoryId: 'clothes',
        ),
      ];
}
