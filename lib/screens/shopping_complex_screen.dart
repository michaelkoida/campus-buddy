// lib/screens/shopping_complex_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/market_item_model.dart';
import '../services/local_cache_service.dart';
import 'market_store_creation_screen.dart';
import 'premium_subscription_screen.dart';

class ShoppingComplexScreen extends StatefulWidget {
  final dynamic activeProfile; final Function(dynamic) onProfileMetricsChanged;
  const ShoppingComplexScreen({super.key, required this.activeProfile, required this.onProfileMetricsChanged});
  @override
  State<ShoppingComplexScreen> createState() => _ShoppingComplexScreenState();
}

class _ShoppingComplexScreenState extends State<ShoppingComplexScreen> {
  final LocalCacheService _cache = LocalCacheService(); List<MarketItem> _inventory = [];

  @override
  void initState() {
    super.initState(); String cachedString = _cache.getRawDataString("market_cache");
    if (cachedString != "[]") { List<dynamic> decoded = jsonDecode(cachedString); _inventory = decoded.map((j) => MarketItem.fromJson(j)).toList(); }
    else { _inventory = [MarketItem(id: "1", campusCode: "RSU", sellerName: "Risi Center", productName: "Combo pack food", description: "", price: 1500, category: "Food")]; }
  }

  @override
  Widget build(BuildContext context) {
    var p = widget.activeProfile; 
    // MARKET COMPLEX CODES ISOLATION PARSE: Filters product inventory lists matching user's active campus domain code
    var isolatedMarketItems = _inventory.where((item) => item.campusCode == p.campusCode).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text("${p.campusCode} Marketplace Square"), actions: [IconButton(icon: const Icon(Icons.add_business), onPressed: () {
        if (!p.hasSellerAccess) { Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumSubscriptionScreen(currentProfile: p, onBillingComplete: widget.onProfileMetricsChanged, isSellerPageGate: true))); return; }
        Navigator.push(context, MaterialPageRoute(builder: (context) => MarketStoreCreationScreen(onStoreItemPublished: (item) { setState(() { _inventory.add(item); _cache.saveToDeviceDisk("market_cache", _inventory.map((i) => i.toJson()).toList()); }); })));
      })]),
      body: ListView.builder(itemCount: isolatedMarketItems.length, itemBuilder: (context, i) => Card(child: ListTile(title: Text(isolatedMarketItems[i].productName), subtitle: Text("₦${isolatedMarketItems[i].price.toStringAsFixed(0)}")))),
    );
  }
}
