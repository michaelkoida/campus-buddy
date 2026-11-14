// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';
import '../models/timetable_model.dart';
import '../models/notice_board_model.dart';
import '../services/timetable_service.dart';
import '../services/seed_data_service.dart';
import '../services/announcement_service.dart';

class DashboardScreen extends StatefulWidget {
  final UserProfile currentStudent;
  const DashboardScreen({super.key, required this.currentStudent});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ignore: unused_field
  final TimetableService _ts = TimetableService(); final SeedDataService _seeds = SeedDataService(); final AnnouncementService _as = AnnouncementService();
  final TextEditingController _cc = TextEditingController(); final TextEditingController _lc = TextEditingController();
  late UserProfile _activeStudent;

  final List<NoticeBoardItem> _globalNoticeRepo = [
    NoticeBoardItem(id: "n_1", campusCode: "RSU", headlineTitle: "RSU Academic Session Calendar", descriptionDetails: "First semester begins.", postedByRole: "Senate Admin", datePublished: DateTime.now()),
    NoticeBoardItem(id: "n_2", campusCode: "UNIPORT", headlineTitle: "Uniport Choba Union Update", descriptionDetails: "General student union.", postedByRole: "SUG Team", datePublished: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState(); _activeStudent = widget.currentStudent; _seeds.injectGroupedDayOneData(_ts.globalTimetableRepo);
    _ts.globalTimetableRepo.add(TimetableItem(id: "pd_1", campusCode: _activeStudent.campusCode, courseCode: "GST 101", lecturerName: "Staff name", location: "Lecture hall ", timeSlot: "Fri 8AM", faculty: _activeStudent.faculty, department: _activeStudent.department, level: _activeStudent.level, isApproved: false, confirmationCount: 3));
  }

  @override
  Widget build(BuildContext context) {
    bool isStudent = !_activeStudent.isExternalBusiness; bool is100L = _activeStudent.level == 100;
    
    // ISOLATION: Filters announcement card blocks matching current active university campus
    var isolatedNotices = _globalNoticeRepo.where((n) => n.campusCode == _activeStudent.campusCode).toList();
    var approved = _ts.fetchApprovedSchedules(_activeStudent.campusCode, _activeStudent.faculty, _activeStudent.department, _activeStudent.level);
    var pending = _ts.fetchPendingSchedulesForReview(_activeStudent.campusCode, _activeStudent.faculty, _activeStudent.department, _activeStudent.level);

    return DefaultTabController(
      length: (isStudent && is100L) ? 3 : 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(isStudent ? "${_activeStudent.campusCode} Hub: ${_activeStudent.fullName}" : "Merchant Workspace Hub"),
          bottom: const TabBar(isScrollable: true, tabs: [Tab(text: "Notices & Schedules"), Tab(text: "Noticeboard"), Tab(text: "100L Guide")]),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text("📜 Scrollable Campus Noticeboard Feed", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ...isolatedNotices.map((n) => Card(child: ListTile(title: Text(n.headlineTitle), subtitle: Text(n.descriptionDetails)))),
                const Divider(),
                const Text("Live Schedules Array Row List:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...approved.map((item) => Card(child: ListTile(title: Text(item.courseCode), subtitle: Text(item.location)))),
                const Divider(),
                ...pending.map((item) => Card(color: Colors.black12, child: ListTile(title: Text(item.courseCode), trailing: ElevatedButton(onPressed: () => setState(() { _ts.castStudentValidationTick(targetItem: item, isCorrectReported: true); }), child: const Text("Tick"))))),
                if (isStudent) ...[
                  TextField(controller: _cc, decoration: const InputDecoration(labelText: "Course Code")),
                  TextField(controller: _lc, decoration: const InputDecoration(labelText: "Target Venue")),
                  ElevatedButton(onPressed: () { setState(() { _ts.submitOrVoteTimetableUpdate(student: _activeStudent, courseCode: _cc.text, newLocation: _lc.text); _cc.clear(); _lc.clear(); }); }, child: const Text("Submit Venue"))
                ]
              ],
            ),
            const Center(child: Text("Notice feed layers")),
            const Center(child: Text("Freshman guide book viewport")),
          ],
        ),
      ),
    );
  }
}
