import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'fullscreen_image.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import 'bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String coverImage = 'lib/images/cover.jpg';
  static const String profileImage = 'lib/images/profile.jpg';

  void _photoOptions(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sheetItem(Icons.photo_camera, 'Add $type Photo'),
          _sheetItem(Icons.edit, 'Edit $type Photo'),
          _sheetItem(Icons.delete, 'Remove $type Photo', danger: true),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  static Widget _sheetItem(
      IconData icon,
      String text, {
        bool danger = false,
      }) {
    return ListTile(
      leading: Icon(icon, color: danger ? Colors.red : Colors.white),
      title: Text(
        text,
        style: TextStyle(color: danger ? Colors.red : Colors.white),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      endDrawer: const _ProfileDrawer(),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: 'cover',
                    child: Container(
                      height: 190,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(coverImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 16,
                    top: 16,
                    child: Builder(
                      builder: (context) => _roundIcon(
                        Icons.menu,
                            () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    bottom: -50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: const CircleAvatar(
                        radius: 47,
                        backgroundImage: AssetImage(profileImage),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sally Liang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// ✅ EDIT PROFILE BUTTON (WORKING)
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit Information'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.15),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _roundIcon(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.55),
      child: Icon(icon, color: Colors.white),
    ),
  );
}

class _ProfileDrawer extends StatelessWidget {
  const _ProfileDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F172A),
      child: Column(
        children: [
          const SizedBox(height: 50),

          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),

          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title:
            const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
