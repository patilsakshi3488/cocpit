import 'package:flutter/material.dart';
import '../views/create_post_screen.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    // 👉 ADD button opens CreatePostScreen MODALLY
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true, // ✅ iOS-style close behavior
          builder: (_) => const CreatePostScreen(),
        ),
      );
      return;
    }

    final routes = [
      '/feed',
      '/jobs',
      '/add',     // unused (handled above)
      '/events',
      '/profile',
    ];

    Navigator.pushNamedAndRemoveUntil(
      context,
      routes[index],
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0F172A),
      selectedItemColor: const Color(0xFF7C83FF),
      unselectedItemColor: Colors.white70,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
