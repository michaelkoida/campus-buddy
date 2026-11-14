// lib/models/market_item_model.dart
class MarketItem {
  final String id;
  final String campusCode;          
  final String sellerName;
  final String productName;
  final String description;
  final double price;
  final String category;           
  double sellerRating;             
  List<String> buyerComments;

  MarketItem({
    required this.id, required this.campusCode, required this.sellerName, required this.productName,
    required this.description, required this.price, required this.category,
    this.sellerRating = 5.0, List<String>? buyerComments,
  // ignore: unnecessary_this
  }) : this.buyerComments = buyerComments ?? [];

  Map<String, dynamic> toJson() => {
    'id': id, 'campusCode': campusCode, 'sellerName': sellerName, 'productName': productName, 'description': description, 'price': price, 'category': category, 'sellerRating': sellerRating, 'buyerComments': buyerComments
  };

  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
    id: json['id'], campusCode: json['campusCode'], sellerName: json['sellerName'], productName: json['productName'], description: json['description'], price: json['price'], category: json['category'], sellerRating: json['sellerRating'], buyerComments: List<String>.from(json['buyerComments'])
  );
}
