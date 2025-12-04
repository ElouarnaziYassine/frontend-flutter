// lib/components/course_actions_modal.dart
import 'package:flutter/material.dart';
import '/models/course.dart';

class CourseActionsModal {
  static void show(BuildContext context, Course course) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Course'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit course
                },
              ),
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('View Course'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to view course
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Manage Students'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to manage students
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive),
                title: const Text('Archive Course'),
                onTap: () {
                  Navigator.pop(context);
                  // Archive course
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete Course',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Delete course
                },
              ),
            ],
          ),
        );
      },
    );
  }
}