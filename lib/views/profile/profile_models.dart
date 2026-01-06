class Experience {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final bool currentlyWorking;
  final String location;
  final String description;

  Experience({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.currentlyWorking,
    required this.location,
    required this.description,
  });

  /// 🔥 BACKEND → FLUTTER MAPPER
  /// Backend keys:
  /// title, company_name, start_date, end_date, is_current, location, description
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] ?? '',
      company: json['company_name'] ?? '', // ✅ FIXED
      startDate: json['start_date'] ?? '', // ✅ FIXED
      endDate: json['end_date'] ?? '',
      currentlyWorking: json['is_current'] ?? false, // ✅ FIXED
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Education {
  final String school;
  final String degree;
  final String fieldOfStudy;
  final String startYear;
  final String endYear;
  final bool currentlyStudying;
  final String description;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.currentlyStudying,
    required this.description,
  });

  /// 🔥 BACKEND → FLUTTER MAPPER
  /// Backend keys:
  /// school_name, degree, field_of_study, start_date, end_date, description
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      school: json['school_name'] ?? '', // ✅ FIXED
      degree: json['degree'] ?? '',
      fieldOfStudy: json['field_of_study'] ?? '', // ✅ FIXED
      startYear: json['start_date'] ?? '',
      endYear: json['end_date'] ?? '',
      currentlyStudying: false, // backend does not send this
      description: json['description'] ?? '',
    );
  }
}

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
