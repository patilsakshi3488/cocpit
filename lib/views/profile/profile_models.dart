// ===================== EXPERIENCE =====================
class Experience {
  final String? id;
  final String title;
  final String company;
  final String startDate;
  final String? endDate;
  final bool currentlyWorking;
  final String location;
  final String description;

  Experience({
    this.id,
    required this.title,
    required this.company,
    required this.startDate,
    this.endDate,
    required this.currentlyWorking,
    required this.location,
    required this.description,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['experience_id']?.toString(),
      title: json['title'] ?? '',
      company: json['company_name'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'],
      currentlyWorking: json['is_current'] ?? false,
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

// ===================== EDUCATION (✅ FINAL FIX) =====================
class Education {
  final String? id; // ✅ REQUIRED for update/delete
  final String school;
  final String degree;
  final String fieldOfStudy;
  final String startYear;
  final String? endYear;
  final bool currentlyStudying; // ✅ REQUIRED by UI
  final String description;

  Education({
    this.id,
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    this.endYear,
    required this.currentlyStudying,
    required this.description,
  });

  /// 🔥 BACKEND → FLUTTER
  /// Backend fields:
  /// education_id, school_name, degree, field_of_study, start_date, end_date, description
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['education_id']?.toString(),
      school: json['school_name'] ?? '',
      degree: json['degree'] ?? '',
      fieldOfStudy: json['field_of_study'] ?? '',
      startYear: json['start_date'] ?? '',
      endYear: json['end_date'],
      currentlyStudying: json['end_date'] == null, // ✅ auto derived
      description: json['description'] ?? '',
    );
  }
}

// ===================== SKILL =====================
class Skill {
  final String id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });

  factory Skill.fromJson(dynamic json) {
    // 🔒 SAFETY: handle String or Map
    if (json is String) {
      return Skill(id: json, name: json);
    }

    return Skill(
      id: json['skill_id']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }
}


// ===================== POSTS =====================
class UserPost {
  final String title;
  final String content;
  final String date;
  final int likes;
  final int comments;
  final int shares;
  final String category;

  UserPost({
    required this.title,
    required this.content,
    required this.date,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.category,
  });
}
