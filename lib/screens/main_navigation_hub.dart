// lib/screens/main_navigation_hub.dart
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'whatsapp_chat_screen.dart';
import 'study_hub_screen.dart';
import 'shopping_complex_screen.dart';
import 'profile_settings_screen.dart';
import 'admin_role_consoles_screen.dart';
import '../models/user_profile_model.dart';
import '../widgets/campus_background_wrapper.dart'; // 3. VERIFIED CORRECT IMPORT DIRECTORY

class MainNavigationHub extends StatefulWidget {
  final UserProfile loggedInStudent;
  const MainNavigationHub({super.key, required this.loggedInStudent});
  @override
  State<MainNavigationHub> createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _currentIndex = 0; 
  late List<Widget> _pages; 
  late List<BottomNavigationBarItem> _tabs; 
  late UserProfile _profile;

  @override
  void initState() { 
    super.initState(); 
    _profile = widget.loggedInStudent; 
    _sync(); 
  }

  void _sync() {
    bool isVerified = _profile.verificationStatus == "verified";
    bool hasClearance = _profile.role != "student";

    _pages = [
      DashboardScreen(currentStudent: _profile),
      // WIRED CLEANLY INTO WHATSAPP CHAT VIEW CONTEXTS
      WhatsappChatScreen(currentUserUsername: _profile.uid, activeProfile: _profile, onProfileMetricsChanged: (newData) { setState(() { _profile = newData; _sync(); }); }),
      const StudyHubScreen(),
      ShoppingComplexScreen(activeProfile: _profile, onProfileMetricsChanged: (newData) { setState(() { _profile = newData; _sync(); }); }),
      _buildLocked("RSU Campus Map"), 
      ProfileSettingsScreen(currentProfile: _profile, onProfileUpdated: (newData) => setState(() { _profile = newData; _sync(); })),
    ];

    _tabs = [
      const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
      const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Study"),
      const BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Market"),
      const BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ];

    if (hasClearance) {
      _pages.add(AdminRoleConsolesScreen(currentPrivilegedUser: _profile));
      _tabs.add(const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings, color: Colors.redAccent), label: "Console"));
    }
  }

  Widget _buildLocked(String label) => Scaffold(backgroundColor: Colors.transparent, body: Center(child: Text("🔒 $label\nModule operational layout panel.", textAlign: TextAlign.center)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CampusBackgroundWrapper(screenContent: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: (i) => setState(() { _currentIndex = i; }), 
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: Colors.blue, 
        items: _tabs
      ),
    );
  }
}