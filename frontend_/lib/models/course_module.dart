// lib/models/course_module.dart

class CourseModule {
  final String title;
  final bool isExpanded;
  final List<CourseLesson> lessons;

  CourseModule({
    required this.title,
    required this.isExpanded,
    required this.lessons,
  });

  CourseModule copyWith({
    String? title,
    bool? isExpanded,
    List<CourseLesson>? lessons,
  }) {
    return CourseModule(
      title: title ?? this.title,
      isExpanded: isExpanded ?? this.isExpanded,
      lessons: lessons ?? this.lessons,
    );
  }
}

class CourseLesson {
  final String title;

  CourseLesson({required this.title});
}