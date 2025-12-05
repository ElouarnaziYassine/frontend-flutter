// lib/components/exam_questions_list.dart
import 'package:flutter/material.dart';
import '../../models/exam_question.dart';

class ExamQuestionsList extends StatelessWidget {
  final List<ExamQuestion> questions;
  final bool darkMode;
  final VoidCallback onAddQuestion;
  final Function(int) onDeleteQuestion;
  final Function(int, ExamQuestion) onUpdateQuestion;

  const ExamQuestionsList({
    super.key,
    required this.questions,
    required this.darkMode,
    required this.onAddQuestion,
    required this.onDeleteQuestion,
    required this.onUpdateQuestion,
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
              'Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.white : const Color(0xFF111318),
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF2463eb),
              ),
              child: TextButton.icon(
                onPressed: onAddQuestion,
                icon: const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
                label: const Text(
                  'Add Question',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (questions.isEmpty)
          _buildEmptyState()
        else
          Column(
            children: questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildQuestionCard(question, index),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        border: Border.all(
          color: darkMode ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: darkMode ? const Color(0xFF1e293b) : const Color(0xFFf1f5f9),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.quiz_outlined,
                size: 24,
                color: darkMode ? const Color(0xFF64748b) : const Color(0xFF94a3b8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No questions added yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Click \'Add Question\' to begin building your exam.',
              style: TextStyle(
                fontSize: 14,
                color: darkMode ? const Color(0xFF64748b) : const Color(0xFF94a3b8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(ExamQuestion question, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: darkMode ? const Color(0xFF334155) : const Color(0xFFe5e7eb),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. Multiple Choice',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkMode ? const Color(0xFF94a3b8) : const Color(0xFF64748b),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: TextEditingController(text: question.questionText),
                      decoration: InputDecoration(
                        hintText: 'Type your question here...',
                        hintStyle: TextStyle(
                          color: darkMode ? const Color(0xFF64748b) : const Color(0xFF94a3b8),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: darkMode ? const Color(0xFFe2e8f0) : const Color(0xFF1e293b),
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        onUpdateQuestion(
                          index,
                          question.copyWith(questionText: value),
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: darkMode ? const Color(0xFF94a3b8) : const Color(0xFF64748b),
                ),
                onPressed: () => onDeleteQuestion(index),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              children: question.options.asMap().entries.map((entry) {
                final optionIndex = entry.key;
                final optionText = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: optionIndex,
                        groupValue: question.correctAnswer,
                        activeColor: const Color(0xFF2463eb),
                        onChanged: (value) {
                          if (value != null) {
                            onUpdateQuestion(
                              index,
                              question.copyWith(correctAnswer: value),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: darkMode ? const Color(0xFF1e293b) : const Color(0xFFf1f5f9),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: darkMode ? const Color(0xFF334155) : const Color(0xFFe5e7eb),
                            ),
                          ),
                          child: TextField(
                            controller: TextEditingController(text: optionText),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            style: TextStyle(
                              color: darkMode ? const Color(0xFFcbd5e1) : const Color(0xFF475569),
                              fontSize: 14,
                            ),
                            onChanged: (value) {
                              final newOptions = List<String>.from(question.options);
                              newOptions[optionIndex] = value;
                              onUpdateQuestion(
                                index,
                                question.copyWith(options: newOptions),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}