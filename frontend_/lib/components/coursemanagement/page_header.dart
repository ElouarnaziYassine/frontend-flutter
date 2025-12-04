// lib/components/page_header.dart
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onButtonPressed;
  final bool darkMode;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.buttonIcon,
    required this.onButtonPressed,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: darkMode ? Colors.white : const Color(0xFF111318),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: darkMode ? Colors.grey[400] : const Color(0xFF616e89),
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2463eb),
          ),
          child: TextButton.icon(
            onPressed: onButtonPressed,
            icon: Icon(
              buttonIcon,
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}