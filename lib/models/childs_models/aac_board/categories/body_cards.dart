import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class BodyCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'body_1',
          text: 'Head',
          icon: Icons.face,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
        const AACCardBaseModel(
          id: 'body_2',
          text: 'Hand',
          icon: Icons.back_hand,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
        const AACCardBaseModel(
          id: 'body_3',
          text: 'Foot',
          icon: Icons.accessibility_new,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
        const AACCardBaseModel(
          id: 'body_4',
          text: 'Tummy',
          icon: Icons.circle_outlined,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
        const AACCardBaseModel(
          id: 'body_5',
          text: 'Eyes',
          icon: Icons.remove_red_eye,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
        const AACCardBaseModel(
          id: 'body_6',
          text: 'Mouth',
          icon: Icons.voice_over_off,
          color: AACCategories.peach,
          categoryId: 'body',
        ),
      ];
}
