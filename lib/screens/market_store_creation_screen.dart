// lib/screens/market_store_creation_screen.dart
import 'package:flutter/material.dart';
import '../models/market_item_model.dart';

class MarketStoreCreationScreen extends StatefulWidget {
  final Function(MarketItem) onStoreItemPublished;
  const MarketStoreCreationScreen({super.key, required this.onStoreItemPublished});
  @override
  State<MarketStoreCreationScreen> createState() => _MarketStoreCreationScreenState();
}

class _MarketStoreCreationScreenState extends State<MarketStoreCreationScreen> {
  final TextEditingController _s = TextEditingController(); final TextEditingController _p = TextEditingController(); final TextEditingController _pr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Launch Market Shop")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _s, decoration: const InputDecoration(labelText: "Store Name")),
            TextField(controller: _p, decoration: const InputDecoration(labelText: "Product Title")),
            TextField(controller: _pr, decoration: const InputDecoration(labelText: "Price")),
            ElevatedButton(onPressed: () { widget.onStoreItemPublished(MarketItem(id: DateTime.now().toString(), campusCode: "RSU", sellerName: _s.text, productName: _p.text, description: "", price: double.parse(_pr.text), category: "Food")); Navigator.pop(context); }, child: const Text("Publish Item"))
          ],
        ),
      ),
    );
  }
}
