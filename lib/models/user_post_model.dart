// lib/models/user_post_model.dart
class UserPost {
  final String id;
  final String campusCode;
  final String authorName;
  final String postText;
  final String visibilityScope; 
  final DateTime timestamp;

  UserPost({required this.id, required this.campusCode, required this.authorName, required this.postText, required this.visibilityScope, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'id': id, 'campusCode': campusCode, 'authorName': authorName, 'postText': postText, 'visibilityScope': visibilityScope, 'timestamp': timestamp.toIso8601String()
  };

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
    id: json['id'], campusCode: json['campusCode'], authorName: json['authorName'], postText: json['postText'], visibilityScope: json['visibilityScope'], timestamp: DateTime.parse(json['timestamp'])
  );
}
