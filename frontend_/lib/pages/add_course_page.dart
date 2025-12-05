// lib/pages/add_course_page.dart
import 'package:flutter/material.dart';
import '../components/teacherdashboard/top_navigation_bar.dart';
import '../components/addcourse/course_form_card.dart';
import '../models/course_module.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _darkMode = false;
  bool _attachExam = false;
  // ignore: prefer_final_fields
  List<CourseModule> _modules = [
    CourseModule(
      title: 'Module 1: Introduction to Web Design',
      isExpanded: true,
      lessons: [
        CourseLesson(title: 'Lesson 1.1: History of the Web'),
        CourseLesson(title: 'Lesson 1.2: HTML & CSS Basics'),
      ],
    ),
    CourseModule(
      title: 'Module 2: Advanced CSS Techniques',
      isExpanded: false,
      lessons: [],
    ),
  ];

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _navigateToRoute(String route) {
    print('Navigate to: $route');
  }

  void _addModule() {
    setState(() {
      _modules.add(CourseModule(
        title: 'Module ${_modules.length + 1}: New Module',
        isExpanded: false,
        lessons: [],
      ));
    });
  }

  void _editModule(int index) {
    print('Edit module: $index');
  }

  void _deleteModule(int index) {
    setState(() {
      _modules.removeAt(index);
    });
  }

  void _toggleModule(int index) {
    setState(() {
      _modules[index] = _modules[index].copyWith(
        isExpanded: !_modules[index].isExpanded,
      );
    });
  }

  void _addLesson(int moduleIndex) {
    setState(() {
      _modules[moduleIndex].lessons.add(
        CourseLesson(title: 'Lesson ${_modules[moduleIndex].lessons.length + 1}: New Lesson'),
      );
    });
  }

  void _editLesson(int moduleIndex, int lessonIndex) {
    print('Edit lesson: $moduleIndex, $lessonIndex');
  }

  void _deleteLesson(int moduleIndex, int lessonIndex) {
    setState(() {
      _modules[moduleIndex].lessons.removeAt(lessonIndex);
    });
  }

  void _saveDraft() {
    print('Save draft');
  }

  void _publishCourse() {
    print('Publish course');
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
            currentRoute: 'courses',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Course',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: _darkMode ? Colors.white : const Color(0xFF111318),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CourseFormCard(
                        titleController: _titleController,
                        descriptionController: _descriptionController,
                        darkMode: _darkMode,
                        attachExam: _attachExam,
                        modules: _modules,
                        onToggleAttachExam: (value) {
                          setState(() {
                            _attachExam = value;
                          });
                        },
                        onAddModule: _addModule,
                        onEditModule: _editModule,
                        onDeleteModule: _deleteModule,
                        onToggleModule: _toggleModule,
                        onAddLesson: _addLesson,
                        onEditLesson: _editLesson,
                        onDeleteLesson: _deleteLesson,
                        onSaveDraft: _saveDraft,
                        onPublish: _publishCourse,
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}