// lib/screens/whatsapp_chat_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/local_cache_service.dart';
import 'premium_subscription_screen.dart';

class WhatsappChatScreen extends StatefulWidget {
  final String currentUserUsername; 
  final Function(dynamic) onProfileMetricsChanged; 
  final dynamic activeProfile;

  const WhatsappChatScreen({
    super.key, 
    required this.currentUserUsername, 
    required this.onProfileMetricsChanged, 
    required this.activeProfile
  });

  @override
  State<WhatsappChatScreen> createState() => _WhatsappChatScreenState();
}

class _WhatsappChatScreenState extends State<WhatsappChatScreen> {
  final LocalCacheService _cache = LocalCacheService(); 
  final TextEditingController _msg = TextEditingController();
  List<Map<String, dynamic>> _chatMessages = []; 
  final List<String> _blockedUsers = [];

  @override
  void initState() {
    super.initState(); 
    String cachedString = _cache.getRawDataString("chat_cache");
    if (cachedString != "") { 
      _chatMessages = List<Map<String, dynamic>>.from(jsonDecode(cachedString)); 
    } else { 
      _chatMessages = [{"user": "R-CB-201", "text": "Welcome to Open Campus Group Stream Chat Room Layouts!"}]; 
    }
  }

  int _countWords(String text) => text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;

  void _sendMessage() {
    String text = _msg.text.trim(); 
    if (text.isEmpty) return;
    int words = _countWords(text); 
    var p = widget.activeProfile;

    if (!p.isPremium && (p.totalWordsSent + words) > 1500) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text("Firebase Quota Limit Hit"), 
        content: const Text("Free tier chat quota exhausted. Unlock premium options to clear limitations."),
        actions: [
          ElevatedButton(
            onPressed: () { 
              Navigator.pop(context); 
              Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumSubscriptionScreen(currentProfile: widget.activeProfile, onBillingComplete: widget.onProfileMetricsChanged, isSellerPageGate: false))); 
            }, 
            child: const Text("Upgrade Plan")
          )
        ],
      ));
      return;
    }

    setState(() { 
      _chatMessages.add({"user": widget.currentUserUsername, "text": text}); 
      widget.onProfileMetricsChanged(p.copyWithIncrementedUsage(addedWords: words, addedMedia: 0)); 
    });
    _msg.clear(); 
    _cache.saveToDeviceDisk("chat_cache", _chatMessages);
  }

  @override
  Widget build(BuildContext context) {
    var p = widget.activeProfile; 
    var filtered = _chatMessages.where((m) => !_blockedUsers.contains(m["user"])).toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (!p.isPremium) Container(color: Colors.black45, padding: const EdgeInsets.all(4), child: Text("Quota: ${p.totalWordsSent}/1500 words sent.", style: const TextStyle(fontSize: 11, color: Colors.amber))),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length, 
              itemBuilder: (context, i) => ListTile(
                title: Text("${filtered[i]['user']}: ${filtered[i]['text']}"), 
                trailing: filtered[i]['user'] != widget.currentUserUsername 
                  ? IconButton(
                      icon: const Icon(Icons.report, color: Colors.orange), 
                      onPressed: () { 
                        setState(() { 
                          _blockedUsers.add(filtered[i]['user']); 
                          _chatMessages.removeAt(i); 
                        }); 
                      }
                    ) 
                  : null
              )
            )
          ),
          Row(children: [Expanded(child: TextField(controller: _msg)), IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage)])
        ],
      ),
    );
  }
}
