import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class TimeCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'time_1',
          text: 'Now',
          icon: Icons.access_time,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
        const AACCardBaseModel(
          id: 'time_2',
          text: 'Later',
          icon: Icons.update,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
        const AACCardBaseModel(
          id: 'time_3',
          text: 'Morning',
          icon: Icons.brightness_5,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
        const AACCardBaseModel(
          id: 'time_4',
          text: 'Night',
          icon: Icons.brightness_2,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
        const AACCardBaseModel(
          id: 'time_5',
          text: 'Today',
          icon: Icons.today,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
        const AACCardBaseModel(
          id: 'time_6',
          text: 'Tomorrow',
          icon: Icons.next_plan,
          color: AACCategories.cornflower,
          categoryId: 'time',
        ),
      ];
}
