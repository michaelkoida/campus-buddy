// lib/screens/premium_subscription_screen.dart
import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';

class PremiumSubscriptionScreen extends StatefulWidget {
  final UserProfile currentProfile; 
  final Function(UserProfile) onBillingComplete; 
  final bool isSellerPageGate;

  const PremiumSubscriptionScreen({
    super.key, 
    required this.currentProfile, 
    required this.onBillingComplete, 
    required this.isSellerPageGate,
  });

  @override
  State<PremiumSubscriptionScreen> createState() => _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> {
  final String _livePublicKey = "pk_live_8df0473534fb813c5c1f7c5d34cd5bf6d0fdf5ae";
  final String _chatExtendUrl = "https://paystack.shop";          
  final String _sellerAccessUrl = "https://paystack.shop";        
  final String _externalBizUrl = "https://paystack.shop"; 

  @override
  Widget build(BuildContext context) {
    bool isExternal = widget.currentProfile.isExternalBusiness;
    String targetUrl = widget.isSellerPageGate ? (isExternal ? _externalBizUrl : _sellerAccessUrl) : _chatExtendUrl;
    String rate = widget.isSellerPageGate ? (isExternal ? "₦3,000 / 3 Months" : "₦2,000 / Session") : "₦1,000 / Session";

    return Scaffold(
      appBar: AppBar(title: const Text("Premium Verification Desk")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.workspace_premium, size: 60, color: Colors.amber),
            const SizedBox(height: 10),
            Text("Subscription Plan Rate: $rate", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
            Padding(
              padding: const EdgeInsets.all(16), 
              child: Text("Launches checkout destination browser path directly to Paystack page:\n$targetUrl", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey))
            ),
            ElevatedButton(
              onPressed: () { 
                UserProfile updated = widget.isSellerPageGate 
                  ? widget.currentProfile.copyWithSellerUpgrade(sellerStatus: true) 
                  : widget.currentProfile.copyWithPremiumUpgrade(premiumStatus: true);
                widget.onBillingComplete(updated); 
                Navigator.pop(context); 
              }, 
              child: const Text("Pay via Paystack Checkout Link"),
            ),
            const SizedBox(height: 20),
            Text("API Production Token: $_livePublicKey", style: const TextStyle(fontSize: 9, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
