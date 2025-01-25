import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class QuestionCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'question_1',
          text: 'What?',
          icon: Icons.help_outline,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
        const AACCardBaseModel(
          id: 'question_2',
          text: 'Where?',
          icon: Icons.place_outlined,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
        const AACCardBaseModel(
          id: 'question_3',
          text: 'When?',
          icon: Icons.schedule,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
        const AACCardBaseModel(
          id: 'question_4',
          text: 'Who?',
          icon: Icons.person_outline,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
        const AACCardBaseModel(
          id: 'question_5',
          text: 'How?',
          icon: Icons.psychology,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
        const AACCardBaseModel(
          id: 'question_6',
          text: 'Why?',
          icon: Icons.question_mark,
          color: AACCategories.paleYellow,
          categoryId: 'questions',
        ),
      ];
}
