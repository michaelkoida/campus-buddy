// lib/models/restaurant_model.dart
class Restaurant {
  final String id;
  final String campusCode;          // e.g., "RSU", "UNIPORT"
  final String name;
  final String campusLocation; 
  final double averagePrice;    
  final int sweetnessRating;   
  final int portionSize;       
  final bool deliversIn30Mins; 

  Restaurant({
    required this.id, required this.campusCode, required this.name, required this.campusLocation, 
    required this.averagePrice, required this.sweetnessRating, required this.portionSize, required this.deliversIn30Mins,
  });
}
