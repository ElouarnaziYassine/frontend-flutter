// lib/components/search_and_filters.dart
import 'package:flutter/material.dart';

class SearchAndFilters extends StatelessWidget {
  final TextEditingController searchController;
  final bool darkMode;
  final Function(String) onSearchChanged;
  final VoidCallback onStatusFilterPressed;
  final VoidCallback onCategoryFilterPressed;

  const SearchAndFilters({
    super.key,
    required this.searchController,
    required this.darkMode,
    required this.onSearchChanged,
    required this.onStatusFilterPressed,
    required this.onCategoryFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: darkMode 
                      ? Border.all(color: Colors.white.withOpacity(0.1))
                      : null,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by course title...',
                    hintStyle: TextStyle(
                      color: darkMode ? Colors.grey[400] : const Color(0xFF616e89),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkMode ? Colors.grey[400] : const Color(0xFF616e89),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: TextStyle(
                    color: darkMode ? Colors.grey[200] : const Color(0xFF111318),
                    fontSize: 16,
                  ),
                  onChanged: onSearchChanged,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Filters
        Row(
          children: [
            FilterButton(
              text: 'Status: All',
              darkMode: darkMode,
              onPressed: onStatusFilterPressed,
            ),
            const SizedBox(width: 12),
            FilterButton(
              text: 'Category',
              darkMode: darkMode,
              onPressed: onCategoryFilterPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool darkMode;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.text,
    required this.darkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: darkMode 
            ? Border.all(color: Colors.white.withOpacity(0.1))
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: darkMode ? Colors.grey[200] : const Color(0xFF111318),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.expand_more,
              size: 20,
              color: darkMode ? Colors.grey[400] : const Color(0xFF616e89),
            ),
          ],
        ),
      ),
    );
  }
}