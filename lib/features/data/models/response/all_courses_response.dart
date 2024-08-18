import 'dart:convert';

// Parsing the JSON response to a list of AllCoursesResponse objects
List<AllCoursesResponse> allCoursesResponseFromJson(String str) => List<AllCoursesResponse>.from(json.decode(str).map((x) => AllCoursesResponse.fromJson(x)));

// Converting a list of AllCoursesResponse objects back to JSON
String allCoursesResponseToJson(List<AllCoursesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCoursesResponse {
  int id;
  int instructorId;
  String title;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  Instructor instructor;
  List<Lesson> lessons;

  AllCoursesResponse({
    required this.id,
    required this.instructorId,
    required this.title,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.instructor,
    required this.lessons,
  });

  // Parsing JSON data into an AllCoursesResponse object
  factory AllCoursesResponse.fromJson(Map<String, dynamic> json) => AllCoursesResponse(
    id: json["id"],
    instructorId: json["instructor_id"],
    title: json["title"],
    category: json["category"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    instructor: Instructor.fromJson(json["instructor"]),
    lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
  );

  // Converting an AllCoursesResponse object to JSON data
  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor_id": instructorId,
    "title": title,
    "category": category,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "instructor": instructor.toJson(),
    "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
  };
}

class Instructor {
  int id;
  String name;
  String role;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Instructor({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Parsing JSON data into an Instructor object
  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  // Converting an Instructor object to JSON data
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Lesson {
  int id;
  int courseId;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Parsing JSON data into a Lesson object
  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json["id"],
    courseId: json["course_id"],
    title: json["title"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  // Converting a Lesson object to JSON data
  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "title": title,
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
