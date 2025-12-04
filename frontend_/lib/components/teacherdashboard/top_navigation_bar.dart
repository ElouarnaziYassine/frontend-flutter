// lib/components/top_navigation_bar.dart
import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onToggleDarkMode;
  final Function(String) onNavigate;
  final String currentRoute;

  const TopNavigationBar({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
    required this.onNavigate,
    this.currentRoute = 'dashboard',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF1a1f2e) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: darkMode 
                ? Colors.white.withOpacity(0.1) 
                : const Color(0xFFe5e7eb),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          _BrandSection(darkMode: darkMode),
          const Spacer(),
          _NavigationLinks(darkMode: darkMode, onNavigate: onNavigate, currentRoute: currentRoute),
          const SizedBox(width: 40),
          _ActionButtons(
            darkMode: darkMode,
            onToggleDarkMode: onToggleDarkMode,
          ),
        ],
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  final bool darkMode;

  const _BrandSection({required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF2463eb),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.school,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'E-Learning Platform',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkMode ? Colors.white : const Color(0xFF111318),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _NavigationLinks extends StatelessWidget {
  final bool darkMode;
  final Function(String) onNavigate;
  final String currentRoute;

  const _NavigationLinks({
    required this.darkMode,
    required this.onNavigate,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavLink(
          text: 'Dashboard',
          isActive: currentRoute == 'dashboard',
          darkMode: darkMode,
          onTap: () => onNavigate('dashboard'),
        ),
        const SizedBox(width: 32),
        NavLink(
          text: 'My Courses',
          isActive: currentRoute == 'courses',
          darkMode: darkMode,
          onTap: () => onNavigate('courses'),
        ),
        const SizedBox(width: 32),
        NavLink(
          text: 'Students',
          isActive: currentRoute == 'students',
          darkMode: darkMode,
          onTap: () => onNavigate('students'),
        ),
        const SizedBox(width: 32),
        NavLink(
          text: 'Analytics',
          isActive: currentRoute == 'analytics',
          darkMode: darkMode,
          onTap: () => onNavigate('analytics'),
        ),
      ],
    );
  }
}

class NavLink extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool darkMode;
  final VoidCallback? onTap;

  const NavLink({
    super.key,
    required this.text,
    this.isActive = false,
    required this.darkMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive 
                    ? const Color(0xFF2463eb) 
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? (darkMode ? Colors.white : const Color(0xFF111318))
                  : (darkMode 
                      ? Colors.white.withOpacity(0.6) 
                      : const Color(0xFF6b7280)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool darkMode;
  final VoidCallback onToggleDarkMode;

  const _ActionButtons({
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonWidget(
          icon: darkMode ? Icons.light_mode : Icons.dark_mode,
          onPressed: onToggleDarkMode,
          darkMode: darkMode,
        ),
        const SizedBox(width: 12),
        IconButtonWidget(
          icon: Icons.notifications_outlined,
          onPressed: () {},
          showBadge: true,
          darkMode: darkMode,
        ),
        const SizedBox(width: 16),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF2463eb).withOpacity(0.3),
              width: 2,
            ),
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuASUcFCim-VQ0GUCbt4tbOBXw_aLh4Br5NFSkFffH7HTjd6fcVf9pXO5I3cZzIagA_S8O06yEpAG5WDQojYsU7RtfyAAALKS7AhLcLWK2JtLev4TDqT8WnNS7wJajCn8eapx2TPur816-MOLOiVpDJ7VPN_qFYdhJHKcEnLqtVHjq2sxSorxt7aBgwfsX1ERCnCV-V2mnadJ2PEh_LRBdU5h7T1ba9rFqusSHms0ma7GiH3h9uQIwcrYSSWiLtKsJsp9nIbehDqQ5U',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool showBadge;
  final bool darkMode;

  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    this.showBadge = false,
    required this.darkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: darkMode 
                ? Colors.white.withOpacity(0.08) 
                : const Color(0xFFf3f4f6),
          ),
          child: IconButton(
            icon: Icon(icon),
            iconSize: 20,
            color: darkMode ? Colors.white : const Color(0xFF111318),
            onPressed: onPressed,
            padding: EdgeInsets.zero,
          ),
        ),
        if (showBadge)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFef4444),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}