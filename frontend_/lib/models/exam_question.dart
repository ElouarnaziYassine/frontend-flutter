// lib/models/exam_question.dart

enum QuestionType {
  multipleChoice,
  trueFalse,
  shortAnswer,
}

class ExamQuestion {
  final String id;
  final String questionText;
  final QuestionType type;
  final List<String> options;
  final int correctAnswer;

  ExamQuestion({
    required this.id,
    required this.questionText,
    required this.type,
    required this.options,
    required this.correctAnswer,
  });

  ExamQuestion copyWith({
    String? id,
    String? questionText,
    QuestionType? type,
    List<String>? options,
    int? correctAnswer,
  }) {
    return ExamQuestion(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      type: type ?? this.type,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }
}