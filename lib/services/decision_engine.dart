// lib/services/decision_engine.dart
import '../models/restaurant_model.dart';

class DecisionEngine {
  final List<Restaurant> rsuRestaurantsList = [
    Restaurant(id: "res_1", campusCode: "RSU", name: "G SPot", campusLocation: "Inside Campus (Behind Amphithere)", averagePrice: 1500.0, sweetnessRating: 70, portionSize: 90, deliversIn30Mins: false),
    Restaurant(id: "res_2", campusCode: "UNIPORT", name: "Uniport Choba Table Water", campusLocation: "Choba Campus", averagePrice: 1000.0, sweetnessRating: 80, portionSize: 85, deliversIn30Mins: false),
  ];

  List<Restaurant> findBestMatch({required String campusCode, required double studentCash}) {
    // Multi-tenant separation logic partitioning food registries cleanly
    return rsuRestaurantsList.where((spot) => spot.campusCode == campusCode && spot.averagePrice <= studentCash).toList();
  }
}
