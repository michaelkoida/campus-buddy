// lib/services/seed_data_service.dart
import '../models/timetable_model.dart';

class SeedDataService {
  void injectGroupedDayOneData(List<TimetableItem> targetRepo) {
    if (targetRepo.isEmpty) {
      targetRepo.add(TimetableItem(
        id: "seed_1",
        campusCode: "RSU",
        courseCode: "GNS 101",
        lecturerName: "Dr. Amadi",
        location: "Amphitheater A",
        timeSlot: "Mon 8:00 AM",
        faculty: "Engineering",
        department: "Computer Engineering",
        level: 100,
        confirmationCount: 5,
        isApproved: true,
      ));
    }
  }
}
