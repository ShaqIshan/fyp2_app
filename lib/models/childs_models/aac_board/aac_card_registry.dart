import 'base/aac_card_base_model.dart';
import 'categories/actions_cards.dart';
import 'categories/animals_cards.dart';
import 'categories/body_cards.dart';
import 'categories/clothes_cards.dart';
import 'categories/feelings_cards.dart';
import 'categories/food_cards.dart';
import 'categories/people_cards.dart';
import 'categories/places_cards.dart';
import 'categories/questions_cards.dart';
import 'categories/relations_cards.dart';
import 'categories/time_cards.dart';
import 'categories/tools_cards.dart';
import 'categories/vehicles_cards.dart';
import 'categories/want_cards.dart';

class AACCardRegistry {
  static Map<String, List<AACCardBaseModel>> getAllCards() => {
        'want': WantCards.getCards(),
        'food': FoodCards.getCards(),
        'feelings': FeelingCards.getCards(),
        'actions': ActionCards.getCards(),
        'people': PeopleCards.getCards(),
        'animals': AnimalCards.getCards(),
        'body': BodyCards.getCards(),
        'clothes': ClothesCards.getCards(),
        'vehicles': VehicleCards.getCards(),
        'places': PlaceCards.getCards(),
        'time': TimeCards.getCards(),
        'questions': QuestionCards.getCards(),
        'relations': RelationCards.getCards(),
        'tools': ToolCards.getCards(),
      };

  static List<AACCardBaseModel> getCardsByCategory(String categoryId) {
    return getAllCards()[categoryId] ?? [];
  }
}
