// lib/models/user_profile_model.dart
class UserProfile {
  final String uid;                 // Format layout: R-CB-XXXXX
  final String campusCode;          // Multi-Campus Tenant Anchor
  final String email;
  final String fullName;
  final String faculty;      
  final String department;   
  final int level;           
  final int semester;        
  final String avatarUrl;    
  final String verificationStatus;  // "unverified", "verified"
  final String role;                // "student", "course_rep", "dept_president", "approve_team", "co_owner", "owner"
  final bool isPremium;             
  final bool hasSellerAccess;       
  final int totalWordsSent;         // 1500 limit check
  final int totalMediaUploaded;     // 20 limit check
  final bool isExternalBusiness;    // Non-student merchant flag
  final String businessName;

  UserProfile({
    required this.uid, required this.campusCode, required this.email, required this.fullName, required this.faculty,
    required this.department, required this.level, required this.semester,
    this.avatarUrl = "https://unsplash.com",
    this.verificationStatus = "unverified", this.role = "student", this.isPremium = false, 
    this.hasSellerAccess = false, this.totalWordsSent = 0, this.totalMediaUploaded = 0,
    this.isExternalBusiness = false, this.businessName = "",
  });

  UserProfile copyWithVerification({required String status}) {
    return UserProfile(
      uid: uid, campusCode: campusCode, email: email, fullName: fullName, faculty: faculty, department: department,
      level: level, semester: semester, avatarUrl: avatarUrl, role: role, isPremium: isPremium,
      hasSellerAccess: hasSellerAccess, verificationStatus: status, totalWordsSent: totalWordsSent, 
      totalMediaUploaded: totalMediaUploaded, isExternalBusiness: isExternalBusiness, businessName: businessName,
    );
  }

  UserProfile copyWithPromotion({required int newLevel, required int newSemester}) {
    return UserProfile(
      uid: uid, campusCode: campusCode, email: email, fullName: fullName, faculty: faculty, department: department,
      level: newLevel, semester: newSemester, avatarUrl: avatarUrl, role: role, isPremium: isPremium,
      hasSellerAccess: hasSellerAccess, verificationStatus: verificationStatus, totalWordsSent: totalWordsSent, 
      totalMediaUploaded: totalMediaUploaded, isExternalBusiness: isExternalBusiness, businessName: businessName,
    );
  }

  UserProfile copyWithPremiumUpgrade({required bool premiumStatus}) {
    return UserProfile(
      uid: uid, campusCode: campusCode, email: email, fullName: fullName, faculty: faculty, department: department,
      level: level, semester: semester, avatarUrl: avatarUrl, role: role, isPremium: premiumStatus,
      hasSellerAccess: hasSellerAccess, verificationStatus: verificationStatus, totalWordsSent: totalWordsSent, 
      totalMediaUploaded: totalMediaUploaded, isExternalBusiness: isExternalBusiness, businessName: businessName,
    );
  }

  UserProfile copyWithSellerUpgrade({required bool sellerStatus}) {
    return UserProfile(
      uid: uid, campusCode: campusCode, email: email, fullName: fullName, faculty: faculty, department: department,
      level: level, semester: semester, avatarUrl: avatarUrl, role: role, isPremium: isPremium,
      hasSellerAccess: sellerStatus, verificationStatus: verificationStatus, totalWordsSent: totalWordsSent, 
      totalMediaUploaded: totalMediaUploaded, isExternalBusiness: isExternalBusiness, businessName: businessName,
    );
  }

  UserProfile copyWithIncrementedUsage({required int addedWords, required int addedMedia}) {
    return UserProfile(
      uid: uid, campusCode: campusCode, email: email, fullName: fullName, faculty: faculty, department: department,
      level: level, semester: semester, avatarUrl: avatarUrl, role: role, isPremium: isPremium,
      hasSellerAccess: hasSellerAccess, verificationStatus: verificationStatus, 
      totalWordsSent: totalWordsSent + addedWords, totalMediaUploaded: totalMediaUploaded + addedMedia,
      isExternalBusiness: isExternalBusiness, businessName: businessName,
    );
  }
}
