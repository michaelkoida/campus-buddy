// lib/services/announcement_service.dart
import '../models/user_profile_model.dart';

class AnnouncementService {
  final List<Map<String, dynamic>> _globalHeadlines = [
    {"text": "📢 Welcome Back to Campus Everyone!", "targetCampus": "RSU", "targetFaculty": "All"},
    {"text": "🚨 General Notice: Welcome Back to Campus Everyone!", "targetCampus": "UNIPORT", "targetFaculty": "All"}
  ];

  List<String> fetchMyTargetedHeadlines(UserProfile student) {
    List<String> validHeadlines = [];
    for (var headline in _globalHeadlines) {
      bool campusMatches = headline["targetCampus"] == student.campusCode;
      bool facultyMatches = headline["targetFaculty"] == "All" || headline["targetFaculty"] == student.faculty;
      if (campusMatches && facultyMatches) validHeadlines.add(headline["text"]);
    }
    return validHeadlines;
  }
}
