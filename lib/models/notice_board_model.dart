// lib/models/notice_board_model.dart
class NoticeBoardItem {
  final String id;
  final String campusCode;          
  final String headlineTitle;
  final String descriptionDetails;
  final String postedByRole;        
  final DateTime datePublished;

  NoticeBoardItem({
    required this.id, required this.campusCode, required this.headlineTitle, required this.descriptionDetails, required this.postedByRole, required this.datePublished,
  });
}
