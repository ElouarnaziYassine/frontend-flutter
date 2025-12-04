// lib/pages/teacher_dashboard.dart
import 'package:flutter/material.dart';
import '/pages/add_course_page.dart';
import '/pages/course_management_page.dart';
import '/components/teacherdashboard/top_navigation_bar.dart';
import '/components/teacherdashboard/welcome_section.dart';
import '/components/teacherdashboard/stat_card.dart';
import '/components/teacherdashboard/action_button.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  bool _darkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _handleNavigation(String route) {
    switch (route) {
      case 'courses':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CourseManagementPage(),
          ),
        );
        break;
      case 'dashboard':
      case 'students':
      case 'analytics':
        // Handle other navigation
        break;
    }
  }

  void _navigateToAddCourse() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddCoursePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2463eb),
          surface: Color(0xFFf6f6f8),
        ),
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2463eb),
          surface: Color(0xFF111621),
        ),
        scaffoldBackgroundColor: const Color(0xFF111621),
      ),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Column(
          children: [
            TopNavigationBar(
              darkMode: _darkMode,
              onToggleDarkMode: _toggleDarkMode,
              onNavigate: _handleNavigation,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WelcomeSection(
                          name: 'Anne',
                          subtitle: "Here's a summary of your activity.",
                          darkMode: _darkMode,
                        ),
                        const SizedBox(height: 40),
                        StatsSection(darkMode: _darkMode),
                        const SizedBox(height: 48),
                        QuickActionsSection(
                          darkMode: _darkMode,
                          onAddCourse: _navigateToAddCourse,
                          onCreateExam: () {},
                          onViewStudents: () {},
                          onViewAnalytics: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}