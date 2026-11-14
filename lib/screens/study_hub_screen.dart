// lib/screens/study_hub_screen.dart
import 'package:flutter/material.dart';
import '../services/cgpa_calculator_service.dart';

class StudyHubScreen extends StatefulWidget {
  const StudyHubScreen({super.key});
  @override
  State<StudyHubScreen> createState() => _StudyHubScreenState();
}

class _StudyHubScreenState extends State<StudyHubScreen> {
  final CgpaCalculatorService _service = CgpaCalculatorService(); 
  double _score = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("RSU 5-Point CGPA Calculator Engine", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Text(_score.toStringAsFixed(2), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () { 
                setState(() { 
                  // FIXED: Added course unit weights [3, 4, 2] instead of leaving it empty
                  _score = _service.calculateRsuCgpa([3, 4, 2], ["A", "B", "C"]); 
                }); 
              }, 
              child: const Text("Compute Sample GPA Summary Score")
            )
          ],
        ),
      ),
    );
  }
}
