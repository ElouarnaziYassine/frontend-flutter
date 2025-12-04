// lib/components/action_button.dart
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isPrimary;
  final bool darkMode;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.isPrimary,
    required this.darkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPrimary
              ? const Color(0xFF2463eb)
              : (darkMode
                  ? Colors.white.withOpacity(0.08)
                  : const Color(0xFFf3f4f6)),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF2463eb).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isPrimary
                        ? Colors.white
                        : (darkMode 
                            ? Colors.white 
                            : const Color(0xFF2463eb)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isPrimary
                          ? Colors.white
                          : (darkMode 
                              ? Colors.white 
                              : const Color(0xFF2463eb)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onAddCourse;
  final VoidCallback onCreateExam;
  final VoidCallback onViewStudents;
  final VoidCallback onViewAnalytics;

  const QuickActionsSection({
    super.key,
    required this.darkMode,
    required this.onAddCourse,
    required this.onCreateExam,
    required this.onViewStudents,
    required this.onViewAnalytics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: darkMode ? Colors.white : const Color(0xFF111318),
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ActionButton(
              icon: Icons.add,
              text: 'Add New Course',
              isPrimary: true,
              darkMode: darkMode,
              onPressed: onAddCourse,
            ),
            ActionButton(
              icon: Icons.edit_document,
              text: 'Create New Exam',
              isPrimary: true,
              darkMode: darkMode,
              onPressed: onCreateExam,
            ),
            ActionButton(
              icon: Icons.visibility,
              text: 'View All Students',
              isPrimary: false,
              darkMode: darkMode,
              onPressed: onViewStudents,
            ),
            ActionButton(
              icon: Icons.bar_chart,
              text: 'View Analytics',
              isPrimary: false,
              darkMode: darkMode,
              onPressed: onViewAnalytics,
            ),
          ],
        ),
      ],
    );
  }
}