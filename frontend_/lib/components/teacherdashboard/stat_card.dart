// lib/components/stat_card.dart
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final bool darkMode;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: darkMode 
            ? Border.all(color: Colors.white.withOpacity(0.1)) 
            : null,
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2463eb).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2463eb),
                  size: 24,
                ),
              ),
              _ChangeBadge(
                change: change,
                isPositive: isPositive,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: darkMode ? Colors.white : const Color(0xFF111318),
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkMode 
                      ? Colors.white.withOpacity(0.6) 
                      : const Color(0xFF6b7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChangeBadge extends StatelessWidget {
  final String change;
  final bool isPositive;

  const _ChangeBadge({
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive
            ? const Color(0xFF10b981).withOpacity(0.1)
            : const Color(0xFFef4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: isPositive 
                ? const Color(0xFF10b981) 
                : const Color(0xFFef4444),
          ),
          const SizedBox(width: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isPositive 
                  ? const Color(0xFF10b981) 
                  : const Color(0xFFef4444),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  final bool darkMode;

  const StatsSection({
    super.key,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 3 : 1;
        
        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.4,
          ),
          children: [
            StatCard(
              icon: Icons.school_outlined,
              title: 'Total Courses',
              value: '12',
              change: '+2 this month',
              isPositive: true,
              darkMode: darkMode,
            ),
            StatCard(
              icon: Icons.people_outline,
              title: 'Total Students',
              value: '284',
              change: '+18 this month',
              isPositive: true,
              darkMode: darkMode,
            ),
            StatCard(
              icon: Icons.quiz_outlined,
              title: 'Exams Created',
              value: '35',
              change: '+5 this month',
              isPositive: true,
              darkMode: darkMode,
            ),
          ],
        );
      },
    );
  }
}