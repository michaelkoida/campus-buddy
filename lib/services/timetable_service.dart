// lib/services/timetable_service.dart
import '../models/timetable_model.dart';
import '../models/user_profile_model.dart';

class TimetableService {
  final List<TimetableItem> globalTimetableRepo = [];

  List<TimetableItem> fetchApprovedSchedules(String campus, String faculty, String dept, int lvl) {
    return globalTimetableRepo.where((item) => item.isApproved && item.campusCode == campus && item.faculty == faculty && item.department == dept && item.level == lvl).toList();
  }

  List<TimetableItem> fetchPendingSchedulesForReview(String campus, String faculty, String dept, int lvl) {
    return globalTimetableRepo.where((item) => !item.isApproved && item.campusCode == campus && item.faculty == faculty && item.department == dept && item.level == lvl).toList();
  }

  void submitOrVoteTimetableUpdate({required UserProfile student, required String courseCode, required String newLocation}) {
    final newItem = TimetableItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(), campusCode: student.campusCode, courseCode: courseCode, lecturerName: "Staff", location: newLocation,
      timeSlot: "TBD Hour", faculty: student.faculty, department: student.department, level: student.level, isApproved: false, confirmationCount: 1,
    );
    globalTimetableRepo.add(newItem);
  }

  void castStudentValidationTick({required TimetableItem targetItem, required bool isCorrectReported}) {
    if (isCorrectReported) {
      targetItem.confirmationCount += 1;
      if (targetItem.confirmationCount >= 5) targetItem.isApproved = true; 
    }
  }
}
