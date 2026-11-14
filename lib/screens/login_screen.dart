// lib/screens/login_screen.dart
// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';
import 'main_navigation_hub.dart';

class LoginScreen extends StatefulWidget { // FIXED: Correct class extension type
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  
  bool _isSignUpMode = false;
  int _selectedAuthTab = 0; 
  int _devTaps = 0; String _err = "";

  Future<void> createLiveStudentCloudProfile(String email, String password, String fullName) async {
    UserCredential credentialToken = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password
    );

    await FirebaseFirestore.instance.collection('rsu_students').doc(credentialToken.user!.uid).set({
      "uid": "R-CB-${Random().nextInt(90000) + 10000}",
      "email": email,
      "fullName": fullName,
      "role": "student", 
      "isPremium": false,
      "totalWordsSent": 0,
      "totalMediaUploaded": 0,
      "campusCode": "RSU"
    });
  }

  void _submit() async {
    setState(() { _err = ""; });
    String email = _email.text.trim(); String pass = _pass.text.trim();
    if (email.isEmpty || pass.isEmpty) return;
    
    if (_isSignUpMode && pass != _confirmPass.text.trim()) {
      setState(() { _err = "❌ Passwords do not match!"; }); return;
    }

    try {
      if (_isSignUpMode && _selectedAuthTab == 0) {
        await createLiveStudentCloudProfile(email, pass, "RSU Student");
      }

      bool isOwner = (email == "" && pass == "RSU_creator_buddy_2026!");
      String assignedRole = isOwner ? "owner" : "student";
      String verification = isOwner ? "verified" : "unverified";

      UserProfile user;

      if (_selectedAuthTab == 1) {
        user = UserProfile(
          uid: "R-CB-BIZ-${Random().nextInt(90000) + 10000}", campusCode: "RSU", email: email, fullName: _businessNameController.text.trim().isEmpty ? "External Vendor" : _businessNameController.text.trim(),
          faculty: "None", department: "Marketplace Vendor", level: 0, semester: 0, isPremium: false,
          verificationStatus: "verified", role: "merchant", isExternalBusiness: true, businessName: _businessNameController.text.trim(),
        );
      } else {
        user = UserProfile(
          uid: "R-CB-${Random().nextInt(90000) + 10000}", campusCode: "RSU", email: email, fullName: isOwner ? "Creator Account" : "RSU Student",
          faculty: "Engineering", department: "Computer Engineering", level: 200, semester: 1, isPremium: isOwner,
          verificationStatus: verification, role: assignedRole,
        );
      }
      
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavigationHub(loggedInStudent: user)));
    } catch (e) {
      setState(() { _err = "❌ Firebase Connection Error: ${e.toString()}"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () { _devTaps++; if (_devTaps >= 5) { _devTaps = 0; _email.text = "app.campusbuddy@gmail.com"; _pass.text = "WRONGs1@"; _submit(); } },
              child: const Text("Campus Buddy Portal", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: _selectedAuthTab == 0 ? Colors.blue : Colors.transparent, elevation: 0),
                      onPressed: () => setState(() { _selectedAuthTab = 0; _isSignUpMode = false; }),
                      child: const Text("Student Login", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: _selectedAuthTab == 1 ? Colors.blue : Colors.transparent, elevation: 0),
                      onPressed: () => setState(() { _selectedAuthTab = 1; _isSignUpMode = true; }),
                      child: const Text("Business Account Signup", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedAuthTab == 1) ...[
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(color: const Color.fromARGB(255, 233, 117, 16).withOpacity(0.12), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber.shade700)),
                child: const Text(
                  "💡 Notice: If you are a student with a business on campus, signup with a student account its faster.",
                  style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.w500, height: 1.4),
                ),
              ),
              TextField(controller: _businessNameController, decoration: const InputDecoration(labelText: "Registered Shop / Business Name", border: OutlineInputBorder())),
              const SizedBox(height: 16),
            ],
            TextField(controller: _email, decoration: const InputDecoration(labelText: "Email Address", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _pass, decoration: const InputDecoration(labelText: "Password Box", border: OutlineInputBorder()), obscureText: true),
            if (_isSignUpMode || _selectedAuthTab == 1) ...[
              const SizedBox(height: 16),
              TextField(controller: _confirmPass, decoration: const InputDecoration(labelText: "Retype Confirmation Password", border: OutlineInputBorder()), obscureText: true),
            ],
            if (_err.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: Text(_err, style: const TextStyle(color: Colors.red, fontSize: 12))),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text(_selectedAuthTab == 1 ? "Register External Business" : (_isSignUpMode ? "Register Account" : "Sign In"))),
            if (_selectedAuthTab == 0) TextButton(onPressed: () => setState(() { _isSignUpMode = !_isSignUpMode; }), child: Text(_isSignUpMode ? "Login instead" : "Create standard student account")),
          ],
        ),
      ),
    );
  }
}
