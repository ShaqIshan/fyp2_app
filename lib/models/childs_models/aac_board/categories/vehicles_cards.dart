import 'package:flutter/material.dart';
import '../aac_categories.dart';
import '../base/aac_card_base_model.dart';

class VehicleCards {
  static List<AACCardBaseModel> getCards() => [
        const AACCardBaseModel(
          id: 'vehicle_1',
          text: 'Car',
          icon: Icons.directions_car,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
        const AACCardBaseModel(
          id: 'vehicle_2',
          text: 'Bus',
          icon: Icons.directions_bus,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
        const AACCardBaseModel(
          id: 'vehicle_3',
          text: 'Bike',
          icon: Icons.pedal_bike,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
        const AACCardBaseModel(
          id: 'vehicle_4',
          text: 'Train',
          icon: Icons.train,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
        const AACCardBaseModel(
          id: 'vehicle_5',
          text: 'Airplane',
          icon: Icons.flight,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
        const AACCardBaseModel(
          id: 'vehicle_6',
          text: 'Boat',
          icon: Icons.directions_boat,
          color: AACCategories.mint,
          categoryId: 'vehicles',
        ),
      ];
}
