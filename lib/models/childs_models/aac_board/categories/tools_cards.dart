import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class ToolCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'tool_1',
          text: 'Help',
          icon: Icons.help_outline,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
        const AACCardBaseModel(
          id: 'tool_2',
          text: 'Stop',
          icon: Icons.stop_circle,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
        const AACCardBaseModel(
          id: 'tool_3',
          text: 'Yes',
          icon: Icons.check_circle,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
        const AACCardBaseModel(
          id: 'tool_4',
          text: 'No',
          icon: Icons.cancel,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
        const AACCardBaseModel(
          id: 'tool_5',
          text: 'Wait',
          icon: Icons.hourglass_empty,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
        const AACCardBaseModel(
          id: 'tool_6',
          text: 'Done',
          icon: Icons.task_alt,
          color: AACCategories.sand,
          categoryId: 'tools',
        ),
      ];
}
