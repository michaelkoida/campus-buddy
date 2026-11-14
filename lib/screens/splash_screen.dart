// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../services/local_cache_service.dart';
import 'login_screen.dart'; 

class CampusBuddySplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme; 
  final bool isDarkMode;

  const CampusBuddySplashScreen({
    super.key, 
    required this.onToggleTheme, 
    required this.isDarkMode
  });

  @override
  State<CampusBuddySplashScreen> createState() => _CampusBuddySplashScreenState();
}

class _CampusBuddySplashScreenState extends State<CampusBuddySplashScreen> {
  @override
  void initState() {
    super.initState();
    LocalCacheService().runAutomatedStorageWipeCleanup(); 
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      // CLEARED PARAMETERS TO MATCH NEW LOGING SCREEN HOOKS
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginScreen()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121212), 
      body: Center(
        child: Text(
          "CAMPUS BUDDY", 
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 3)
        )
      )
    );
  }
}
