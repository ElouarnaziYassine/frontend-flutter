// lib/components/course_modules_list.dart
import 'package:flutter/material.dart';
import '../../models/course_module.dart';

class CourseModulesList extends StatelessWidget {
  final List<CourseModule> modules;
  final bool darkMode;
  final VoidCallback onAddModule;
  final Function(int) onEditModule;
  final Function(int) onDeleteModule;
  final Function(int) onToggleModule;
  final Function(int) onAddLesson;
  final Function(int, int) onEditLesson;
  final Function(int, int) onDeleteLesson;

  const CourseModulesList({
    super.key,
    required this.modules,
    required this.darkMode,
    required this.onAddModule,
    required this.onEditModule,
    required this.onDeleteModule,
    required this.onToggleModule,
    required this.onAddLesson,
    required this.onEditLesson,
    required this.onDeleteLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Course Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF2463eb).withOpacity(0.1),
              ),
              child: TextButton.icon(
                onPressed: onAddModule,
                icon: const Icon(
                  Icons.add,
                  size: 18,
                  color: Color(0xFF2463eb),
                ),
                label: const Text(
                  'Add Module',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2463eb),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: modules.asMap().entries.map((entry) {
            final index = entry.key;
            final module = entry.value;
            return _buildModuleItem(module, index);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildModuleItem(CourseModule module, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: darkMode ? Colors.grey[700]! : Colors.grey[200]!,
        ),
        color: darkMode ? const Color(0xFF111621) : const Color(0xFFf6f6f8),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.drag_indicator,
              color: Colors.grey[500],
            ),
            title: Text(
              module.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: darkMode ? Colors.white : const Color(0xFF111318),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20, color: Colors.grey[600]),
                  onPressed: () => onEditModule(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20, color: Colors.grey[600]),
                  onPressed: () => onDeleteModule(index),
                ),
                IconButton(
                  icon: Icon(
                    module.isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[500],
                  ),
                  onPressed: () => onToggleModule(index),
                ),
              ],
            ),
          ),
          if (module.isExpanded) _buildLessonsList(module, index),
        ],
      ),
    );
  }

  Widget _buildLessonsList(CourseModule module, int moduleIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 56, right: 16, bottom: 16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: darkMode ? Colors.grey[600]! : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Column(
                      children: module.lessons.asMap().entries.map((entry) {
                        final lessonIndex = entry.key;
                        final lesson = entry.value;
                        return _buildLessonItem(lesson, moduleIndex, lessonIndex);
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 36,
                  margin: const EdgeInsets.only(left: 8),
                  child: TextButton.icon(
                    onPressed: () => onAddLesson(moduleIndex),
                    icon: Icon(
                      Icons.add,
                      size: 16,
                      color: darkMode ? Colors.white : const Color(0xFF111318),
                    ),
                    label: Text(
                      'Add Lesson',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : const Color(0xFF111318),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: darkMode ? const Color(0xFF1a202c) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: darkMode ? Colors.grey[600]! : Colors.grey[300]!,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(CourseLesson lesson, int moduleIndex, int lessonIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: darkMode ? const Color(0xFF1a202c) : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            Icons.description,
            size: 16,
            color: darkMode ? Colors.grey[300] : const Color(0xFF616e89),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              lesson.title,
              style: TextStyle(
                fontSize: 14,
                color: darkMode ? Colors.grey[300] : const Color(0xFF616e89),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 16, color: Colors.grey[600]),
            onPressed: () => onEditLesson(moduleIndex, lessonIndex),
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 16, color: Colors.grey[600]),
            onPressed: () => onDeleteLesson(moduleIndex, lessonIndex),
          ),
        ],
      ),
    );
  }
}