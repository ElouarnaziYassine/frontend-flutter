// lib/models/course.dart

class Course {
  final String title;
  final String thumbnailUrl;
  final int students;
  final CourseStatus status;
  final String createdDate;

  Course({
    required this.title,
    required this.thumbnailUrl,
    required this.students,
    required this.status,
    required this.createdDate,
  });
}

enum CourseStatus {
  published,
  draft,
  archived,
}