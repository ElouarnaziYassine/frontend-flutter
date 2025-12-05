// lib/components/course_form_card.dart
import 'package:flutter/material.dart';
import '../../models/course_module.dart';
import 'course_modules_list.dart';

class CourseFormCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool darkMode;
  final bool attachExam;
  final List<CourseModule> modules;
  final Function(bool) onToggleAttachExam;
  final VoidCallback onAddModule;
  final Function(int) onEditModule;
  final Function(int) onDeleteModule;
  final Function(int) onToggleModule;
  final Function(int) onAddLesson;
  final Function(int, int) onEditLesson;
  final Function(int, int) onDeleteLesson;
  final VoidCallback onSaveDraft;
  final VoidCallback onPublish;

  const CourseFormCard({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.darkMode,
    required this.attachExam,
    required this.modules,
    required this.onToggleAttachExam,
    required this.onAddModule,
    required this.onEditModule,
    required this.onDeleteModule,
    required this.onToggleModule,
    required this.onAddLesson,
    required this.onEditLesson,
    required this.onDeleteLesson,
    required this.onSaveDraft,
    required this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF111621).withOpacity(0.7) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBasicInfoSection(),
          const SizedBox(height: 32),
          _buildThumbnailSection(),
          const SizedBox(height: 32),
          CourseModulesList(
            modules: modules,
            darkMode: darkMode,
            onAddModule: onAddModule,
            onEditModule: onEditModule,
            onDeleteModule: onDeleteModule,
            onToggleModule: onToggleModule,
            onAddLesson: onAddLesson,
            onEditLesson: onEditLesson,
            onDeleteLesson: onDeleteLesson,
          ),
          const SizedBox(height: 32),
          _buildSettingsSection(),
          const SizedBox(height: 32),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      children: [
        _buildFormField(
          label: 'Course Title',
          hintText: 'Enter the title of your course',
          controller: titleController,
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 144,
              decoration: BoxDecoration(
                color: darkMode ? const Color(0xFF1a202c) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: darkMode ? Colors.grey[700]! : const Color(0xFFdbdee6),
                ),
              ),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Provide a detailed description of the course',
                  hintStyle: TextStyle(color: Color(0xFF616e89)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: TextStyle(
                  color: darkMode ? Colors.white : const Color(0xFF111318),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF616e89)),
            filled: true,
            fillColor: darkMode ? const Color(0xFF1a202c) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: darkMode ? Colors.grey[700]! : const Color(0xFFdbdee6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF2463eb),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: TextStyle(
            color: darkMode ? Colors.white : const Color(0xFF111318),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Thumbnail',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: darkMode 
                  ? Colors.grey[500]!.withOpacity(0.5) 
                  : Colors.grey[900]!.withOpacity(0.25),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.upload_file,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Upload a file',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2463eb),
                      ),
                    ),
                  ),
                  Text(
                    ' or drag and drop',
                    style: TextStyle(
                      fontSize: 14,
                      color: darkMode ? Colors.grey[400] : const Color(0xFF616e89),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'PNG, JPG, GIF up to 10MB',
                style: TextStyle(
                  fontSize: 12,
                  color: darkMode ? Colors.grey[500] : const Color(0xFF616e89),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: darkMode ? const Color(0xFF111621) : const Color(0xFFf6f6f8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attach Exam to this Course',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
                ),
              ),
              Switch(
                value: attachExam,
                onChanged: onToggleAttachExam,
                activeColor: const Color(0xFF2463eb),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Text(
          'Draft saved at 10:15 AM',
          style: TextStyle(
            fontSize: 14,
            color: darkMode ? Colors.grey[500] : const Color(0xFF616e89),
          ),
        ),
        const Spacer(),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: darkMode ? Colors.white.withOpacity(0.1) : const Color(0xFFf6f6f8),
          ),
          child: TextButton(
            onPressed: onSaveDraft,
            style: TextButton.styleFrom(
              foregroundColor: darkMode ? Colors.white : const Color(0xFF111318),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: const Text(
              'Save Draft',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2463eb),
          ),
          child: TextButton(
            onPressed: onPublish,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: const Text(
              'Publish',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}