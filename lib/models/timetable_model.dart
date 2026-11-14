// lib/models/timetable_model.dart
// ignore_for_file: unnecessary_this

class TimetableItem {
  final String id;
  final String campusCode;          
  final String courseCode;     
  final String lecturerName;   
  final String location;       
  final String timeSlot;       
  final String faculty;        
  final String department;     
  final int level;             
  int confirmationCount;       
  bool isApproved;             
  Map<String, int> correctionSuggestions; 

  TimetableItem({
    required this.id, required this.campusCode, required this.courseCode, required this.lecturerName, required this.location,
    required this.timeSlot, required this.faculty, required this.department, required this.level,
    this.confirmationCount = 1, this.isApproved = false, Map<String, int>? correctionSuggestions,
  }) : this.correctionSuggestions = correctionSuggestions ?? {};
}
