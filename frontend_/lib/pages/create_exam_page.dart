// lib/pages/create_exam_page.dart
import 'package:flutter/material.dart';
import '../components/teacherdashboard/top_navigation_bar.dart';
import '../components/exampage/exam_form_card.dart';
import '../models/exam_question.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({super.key});

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _passingScoreController = TextEditingController();
  bool _darkMode = false;
  String _selectedCourse = 'Introduction to Web Development';
  List<ExamQuestion> _questions = [];

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _navigateToRoute(String route) {
    Navigator.pushNamed(context, '/$route');
  }

  void _addQuestion() {
    setState(() {
      _questions.add(ExamQuestion(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        questionText: '',
        type: QuestionType.multipleChoice,
        options: ['', '', '', ''],
        correctAnswer: 0,
      ));
    });
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _updateQuestion(int index, ExamQuestion question) {
    setState(() {
      _questions[index] = question;
    });
  }

  void _saveDraft() {
    print('Save draft');
  }

  void _publishExam() {
    print('Publish exam');
  }

  void _cancel() {
    print('Cancel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkMode ? const Color(0xFF111621) : const Color(0xFFf6f6f8),
      body: Column(
        children: [
          TopNavigationBar(
            darkMode: _darkMode,
            onToggleDarkMode: _toggleDarkMode,
            onNavigate: _navigateToRoute,
            currentRoute: 'exams',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1024),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPageHeader(),
                      const SizedBox(height: 32),
                      ExamFormCard(
                        titleController: _titleController,
                        durationController: _durationController,
                        passingScoreController: _passingScoreController,
                        selectedCourse: _selectedCourse,
                        questions: _questions,
                        darkMode: _darkMode,
                        onCourseChanged: (value) {
                          setState(() {
                            _selectedCourse = value!;
                          });
                        },
                        onAddQuestion: _addQuestion,
                        onDeleteQuestion: _deleteQuestion,
                        onUpdateQuestion: _updateQuestion,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create New Exam',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: _darkMode ? Colors.white : const Color(0xFF111318),
            letterSpacing: -0.5,
          ),
        ),
        Row(
          children: [
            _buildHeaderButton(
              text: 'Cancel',
              onPressed: _cancel,
              isPrimary: false,
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              text: 'Save Draft',
              onPressed: _saveDraft,
              isPrimary: false,
              isSecondary: true,
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              text: 'Publish Exam',
              onPressed: _publishExam,
              isPrimary: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = false,
    bool isSecondary = false,
  }) {
    Color backgroundColor;
    Color textColor;

    if (isPrimary) {
      backgroundColor = const Color(0xFF2463eb);
      textColor = Colors.white;
    } else if (isSecondary) {
      backgroundColor = _darkMode ? const Color(0xFF374151) : const Color(0xFF6b7280);
      textColor = Colors.white;
    } else {
      backgroundColor = _darkMode ? const Color(0xFF374151) : const Color(0xFFe5e7eb);
      textColor = _darkMode ? Colors.white : const Color(0xFF374151);
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _passingScoreController.dispose();
    super.dispose();
  }
}