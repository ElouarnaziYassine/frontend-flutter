// lib/components/courses_table.dart
import 'package:flutter/material.dart';
import '/models/course.dart';

class CoursesTable extends StatelessWidget {
  final List<Course> courses;
  final bool darkMode;
  final Function(Course) onCourseAction;
  final VoidCallback? onCourseEdit;
  final VoidCallback? onCourseView;

  const CoursesTable({
    super.key,
    required this.courses,
    required this.darkMode,
    required this.onCourseAction,
    this.onCourseEdit,
    this.onCourseView,
  });

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: darkMode 
              ? Colors.white.withOpacity(0.1) 
              : const Color(0xFFe5e7eb),
        ),
        boxShadow: darkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          const Divider(height: 1, thickness: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 1,
              color: darkMode 
                  ? Colors.white.withOpacity(0.05) 
                  : const Color(0xFFf3f4f6),
            ),
            itemBuilder: (context, index) => _buildCourseRow(courses[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(64),
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: darkMode 
              ? Colors.white.withOpacity(0.1) 
              : const Color(0xFFe5e7eb),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: darkMode ? Colors.grey[600] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No courses yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: darkMode ? Colors.grey[400] : const Color(0xFF6b7280),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first course to get started',
            style: TextStyle(
              fontSize: 14,
              color: darkMode ? Colors.grey[500] : const Color(0xFF9ca3af),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: darkMode 
            ? Colors.white.withOpacity(0.03) 
            : const Color(0xFFf9fafb),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: _buildHeaderText('COURSE'),
          ),
          Expanded(
            flex: 2,
            child: _buildHeaderText('STUDENTS'),
          ),
          Expanded(
            flex: 2,
            child: _buildHeaderText('STATUS'),
          ),
          const SizedBox(width: 60), // Space for actions
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: darkMode 
            ? Colors.grey[500] 
            : const Color(0xFF6b7280),
      ),
    );
  }

  Widget _buildCourseRow(Course course) {
    return InkWell(
      onTap: onCourseView,
      borderRadius: BorderRadius.circular(8),
      hoverColor: darkMode 
          ? Colors.white.withOpacity(0.05) 
          : const Color(0xFFf9fafb),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // Course Info (Title + Thumbnail)
            Expanded(
              flex: 4,
              child: _buildCourseInfo(course),
            ),
            // Students Count
            Expanded(
              flex: 2,
              child: _buildStudentsCount(course.students),
            ),
            // Status Badge
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: StatusBadge(
                  status: course.status,
                  darkMode: darkMode,
                ),
              ),
            ),
            // Actions
            _buildActionButtons(course),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfo(Course course) {
    return Row(
      children: [
        // Thumbnail with hover effect
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              course.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: darkMode 
                      ? Colors.grey[800] 
                      : Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported,
                    color: darkMode 
                        ? Colors.grey[600] 
                        : Colors.grey[400],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Title and Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: darkMode ? Colors.white : const Color(0xFF111318),
                  height: 1.4,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: darkMode 
                        ? Colors.grey[500] 
                        : const Color(0xFF9ca3af),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Created ${course.createdDate}',
                    style: TextStyle(
                      fontSize: 13,
                      color: darkMode 
                          ? Colors.grey[500] 
                          : const Color(0xFF6b7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsCount(int students) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF2463eb).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.people_outline,
            size: 16,
            color: Color(0xFF2463eb),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          students.toString(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: darkMode ? Colors.white : const Color(0xFF111318),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Course course) {
    return SizedBox(
      width: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildIconButton(
            icon: Icons.more_vert,
            onPressed: () => onCourseAction(course),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: darkMode 
            ? Colors.white.withOpacity(0.05) 
            : const Color(0xFFf3f4f6),
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 18,
        padding: EdgeInsets.zero,
        color: darkMode 
            ? Colors.grey[400] 
            : const Color(0xFF6b7280),
        onPressed: onPressed,
        splashRadius: 16,
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final CourseStatus status;
  final bool darkMode;

  const StatusBadge({
    super.key,
    required this.status,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getStatusTextColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _getStatusText(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _getStatusTextColor(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case CourseStatus.published:
        return darkMode 
            ? const Color(0xFF166534).withOpacity(0.2) 
            : const Color(0xFFdcfce7);
      case CourseStatus.draft:
        return darkMode 
            ? const Color(0xFF374151).withOpacity(0.3) 
            : const Color(0xFFf3f4f6);
      case CourseStatus.archived:
        return darkMode 
            ? const Color(0xFF854d0e).withOpacity(0.2) 
            : const Color(0xFFfef9c3);
    }
  }

  Color _getStatusTextColor() {
    switch (status) {
      case CourseStatus.published:
        return darkMode ? const Color(0xFF4ade80) : const Color(0xFF166534);
      case CourseStatus.draft:
        return darkMode ? const Color(0xFFd1d5db) : const Color(0xFF6b7280);
      case CourseStatus.archived:
        return darkMode ? const Color(0xFFfacc15) : const Color(0xFF92400e);
    }
  }

  String _getStatusText() {
    switch (status) {
      case CourseStatus.published:
        return 'Published';
      case CourseStatus.draft:
        return 'Draft';
      case CourseStatus.archived:
        return 'Archived';
    }
  }
}