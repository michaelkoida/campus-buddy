// lib/services/cgpa_calculator_service.dart
class CgpaCalculatorService {
  int convertGradeToPoints(String grade) {
    switch (grade.toUpperCase()) {
      case 'A': return 5; case 'B': return 4; case 'C': return 3; case 'D': return 2; case 'F': return 0; default: return 0;
    }
  }
  double calculateRsuCgpa(List<int> units, List<String> grades) {
    if (units.isEmpty || units.length != grades.length) return 0.0;
    int totalUnits = 0; int totalPoints = 0;
    for (int i = 0; i < units.length; i++) { totalUnits += units[i]; totalPoints += (units[i] * convertGradeToPoints(grades[i])); }
    return totalUnits == 0 ? 0.0 : totalPoints / totalUnits;
  }
}
