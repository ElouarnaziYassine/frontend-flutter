// lib/components/exam_form_card.dart
import 'package:flutter/material.dart';
import '../../models/exam_question.dart';
import 'exam_questions_list.dart';

class ExamFormCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController durationController;
  final TextEditingController passingScoreController;
  final String selectedCourse;
  final List<ExamQuestion> questions;
  final bool darkMode;
  final Function(String?) onCourseChanged;
  final VoidCallback onAddQuestion;
  final Function(int) onDeleteQuestion;
  final Function(int, ExamQuestion) onUpdateQuestion;

  const ExamFormCard({
    super.key,
    required this.titleController,
    required this.durationController,
    required this.passingScoreController,
    required this.selectedCourse,
    required this.questions,
    required this.darkMode,
    required this.onCourseChanged,
    required this.onAddQuestion,
    required this.onDeleteQuestion,
    required this.onUpdateQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1e293b) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExamDetailsSection(),
          const SizedBox(height: 24),
          Divider(
            color: darkMode ? const Color(0xFF334155) : const Color(0xFFe5e7eb),
            height: 1,
          ),
          const SizedBox(height: 24),
          ExamQuestionsList(
            questions: questions,
            darkMode: darkMode,
            onAddQuestion: onAddQuestion,
            onDeleteQuestion: onDeleteQuestion,
            onUpdateQuestion: onUpdateQuestion,
          ),
        ],
      ),
    );
  }

  Widget _buildExamDetailsSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'Exam Title',
                hintText: 'Enter the title of the exam',
                controller: titleController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildCourseDropdown(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildFormField(
                      label: 'Duration (min)',
                      hintText: 'e.g., 60',
                      controller: durationController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFormField(
                      label: 'Passing Score (%)',
                      hintText: 'e.g., 75',
                      controller: passingScoreController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: darkMode ? const Color(0xFF64748b) : const Color(0xFF94a3b8),
            ),
            filled: true,
            fillColor: darkMode ? const Color(0xFF1e293b) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: darkMode ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: darkMode ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
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
              vertical: 12,
            ),
          ),
          style: TextStyle(
            color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Course',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: darkMode ? const Color(0xFF1e293b) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: darkMode ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCourse,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              dropdownColor: darkMode ? const Color(0xFF1e293b) : Colors.white,
              style: TextStyle(
                color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
                fontSize: 16,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: darkMode ? const Color(0xFF64748b) : const Color(0xFF94a3b8),
              ),
              items: [
                'Introduction to Web Development',
                'Advanced JavaScript Concepts',
                'UI/UX Design Principles',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onCourseChanged,
            ),
          ),
        ),
      ],
    );
  }
}