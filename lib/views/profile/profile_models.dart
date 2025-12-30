class Experience {
  String title;
  String company;
  String startDate;
  String endDate;
  bool currentlyWorking;
  String location;
  String description;

  Experience({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.currentlyWorking,
    required this.location,
    required this.description,
  });
}

class Education {
  String school;
  String degree;
  String fieldOfStudy;
  String startYear;
  String endYear;
  bool currentlyStudying;
  String description;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.currentlyStudying,
    required this.description,
  });
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
