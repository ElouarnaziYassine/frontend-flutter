// lib/pages/course_management_page.dart
import 'package:flutter/material.dart';
import '/pages/add_course_page.dart';
import '/models/course.dart';
import '/components/teacherdashboard/top_navigation_bar.dart';
import '/components/coursemanagement/page_header.dart';
import '/components/coursemanagement/search_and_filters.dart';
import '/components/coursemanagement/courses_table.dart';
import '/components/coursemanagement/course_actions_modal.dart';

class CourseManagementPage extends StatefulWidget {
  const CourseManagementPage({super.key});

  @override
  State<CourseManagementPage> createState() => _CourseManagementPageState();
}

class _CourseManagementPageState extends State<CourseManagementPage> {
  final _searchController = TextEditingController();
  bool _darkMode = false;
  
  final List<Course> _courses = [
    Course(
      title: 'Introduction to Graphic Design',
      thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAN3iiCFJocNzPdGMTEUfQp2yuGAh4Q83TL6VHXn7G5MP_0YjeoHwUtz4JarU4CtABtB_g_4cUVxNY3hQnSN5dsGZpOl1RAPNAirJi3K7gDgVPOqZcKhAoZctkE9ytslrGHmKu3XGmtOouxmw8R5fZ6H1Zz_0YUAQvxZe4VUqdk_NHpbH7iGhZ3VaAms1B0PWoZ3nejf0caxY83HFQya1JMGByA9jVCufNBxUr3P6L2YRoy2xMASkhHYvkPlFNCcDYhhz5ST5xFzcQ',
      students: 154,
      status: CourseStatus.published,
      createdDate: 'Jan 15, 2024',
    ),
    Course(
      title: 'Advanced Web Development',
      thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVpWTphDeEM1qQVSO7fqha0DDEIudc8QBYK91a29DLWVkyqfvfLoubujh_QBbMLwPUV5tRbpqAR46BGBa7RXl_Yge4W66D3FH5ZcNa8JSoCOB1ifnTkp4xVAketqo8ZtYrQf4t2oXngV20VGSCRQXjkvr2Q-lg0CLZtsq7S__12CXxVCH-cN6-oGULRqVlgaA4rL9A6gWzmA8b8HApf4DlJd38brrIUhH-oQFgtUJRSHvW1Oq1HfFIb4s4k6z4VqG3wJolav-Kkmo',
      students: 88,
      status: CourseStatus.published,
      createdDate: 'Dec 02, 2023',
    ),
    Course(
      title: 'Data Science with Python',
      thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUPGjNVwJhAdgNfZEPIodLoZ225gcLO0VzMmNLEg7_RRC2IHJUmCMK_WWLhvvKOT0qUguNWtge01XNYcFyyMF1obDeXnDxEMe3giq1sN79WpxByT1uZiGBft-Hpmj8cEsEOFC4bsqq5NQLUl3vOI_AXOjPBowmNajqMNzqSUmSTKlPdNuAmMKSWI_oUFxlzXV7gS8jY91CsDCrASKM_J3PWG13Pwqa7xBZJ2GLxv2kE_feIY05L3kuaNQ6uOfhqZyNZkseNw-5Rh8',
      students: 210,
      status: CourseStatus.draft,
      createdDate: 'Nov 21, 2023',
    ),
    Course(
      title: 'Digital Marketing Fundamentals',
      thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAxLRh1UlB9TvpNf0nt3tkcLqpKxnbPa6QGyJtQkBPxRx1uBhz3ouZM1cJhWgVL24FN_J6Iwt_OuYXbjmGo4Uousbx4qWL4W5RQX-aLkbUVMyP8jIy-qlrUU0F-VQDbAXNZBieDOkC93oUeO7CmiehmN_65dXzwjtIYuRCiVWZLbLMRef7ZqHThwZcOQ9SsT4aHRFILoRbdMYp84idslI0h24_UFHfAFu6ITJdZR6Q-2WjkTaQI5dXQQPWAUkUGx2fV3d8xSock00w',
      students: 12,
      status: CourseStatus.archived,
      createdDate: 'Aug 05, 2023',
    ),
  ];

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _handleNavigation(String route) {
    if (route == 'dashboard') {
      Navigator.pop(context);
    }
    // Handle other navigation routes
  }

  void _navigateToAddCourse() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddCoursePage(),
      ),
    );
  }

  void _handleCourseAction(Course course) {
    CourseActionsModal.show(context, course);
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
              currentRoute: 'courses',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: [
                        PageHeader(
                          title: 'Course Management',
                          subtitle: 'Manage, edit, and analyze your course performance.',
                          buttonText: 'Create New Course',
                          buttonIcon: Icons.add_circle,
                          onButtonPressed: _navigateToAddCourse,
                          darkMode: _darkMode,
                        ),
                        const SizedBox(height: 24),
                        SearchAndFilters(
                          searchController: _searchController,
                          darkMode: _darkMode,
                          onSearchChanged: (value) {
                            // Implement search functionality
                          },
                          onStatusFilterPressed: () {},
                          onCategoryFilterPressed: () {},
                        ),
                        const SizedBox(height: 24),
                        CoursesTable(
                          courses: _courses,
                          darkMode: _darkMode,
                          onCourseAction: _handleCourseAction,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}