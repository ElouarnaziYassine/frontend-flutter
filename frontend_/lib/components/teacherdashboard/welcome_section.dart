// lib/components/welcome_section.dart
import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool darkMode;

  const WelcomeSection({
    super.key,
    required this.name,
    required this.subtitle,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, $name! 👋',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: darkMode ? Colors.white : const Color(0xFF111318),
            height: 1.2,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: darkMode 
                ? Colors.white.withOpacity(0.6) 
                : const Color(0xFF6b7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}