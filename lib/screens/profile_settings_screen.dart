// lib/screens/profile_settings_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';
import 'login_screen.dart'; 

class ProfileSettingsScreen extends StatefulWidget {
  final UserProfile currentProfile; 
  final Function(UserProfile) onProfileUpdated;

  const ProfileSettingsScreen({
    super.key, 
    required this.currentProfile, 
    required this.onProfileUpdated
  });

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var p = widget.currentProfile;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("Account Settings Profile Hub")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text("App Unique ID Key: ${p.uid}", style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("Active Campus Domain Tenant: ${p.campusCode}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          const Divider(),
          Card(
            color: Colors.red.withOpacity(0.1),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent), 
              title: const Text("Sign Out of Account Session", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen()), 
                  (route) => false
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
