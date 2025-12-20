import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'fullscreen_image.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import 'bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // TEMP local assets
  static const String coverImage = 'lib/images/cover.jpg';
  static const String profileImage = 'lib/images/profile.jpg';

  /* ================= PHOTO OPTIONS ================= */

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

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      endDrawer: const _ProfileDrawer(),

      // ✅ Bottom Navigation (UNCHANGED)
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* ================= COVER + HEADER ================= */
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FullScreenImage(
                            imagePath: coverImage,
                            tag: 'cover',
                          ),
                        ),
                      );
                    },
                    child: Hero(
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
                  ),

                  Positioned(
                    right: 60,
                    top: 16,
                    child: _roundIcon(
                      Icons.camera_alt,
                          () => _photoOptions(context, 'Cover'),
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
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FullScreenImage(
                                  imagePath: profileImage,
                                  tag: 'profile',
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: const CircleAvatar(
                              radius: 47,
                              backgroundImage: AssetImage(profileImage),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () =>
                                _photoOptions(context, 'Profile'),
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFF3B82F6),
                              child: Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              /* ================= BODY ================= */
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Sally Liang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.verified, size: 18, color: Colors.blue),
                        SizedBox(width: 6),
                        Text('· 2nd',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 6),
                    const Text(
                      'Senior Financial Analyst at Johnson & Johnson',
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 4),
                    const Text(
                      'Berkeley, California, United States',
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text('Contact info',
                            style: TextStyle(color: Colors.blue)),
                        SizedBox(width: 12),
                        Text('500+ connections',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 14),

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
                            color: Colors.white.withValues(alpha: 0.12)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    linkedInCard(
                      title: 'About',
                      child: const Text(
                        'Passionate product manager with 7+ years of experience building user-centric solutions that drive business growth.',
                        style: TextStyle(
                            color: Color(0xFFE5E7EB), height: 1.4),
                      ),
                    ),

                    linkedInCard(
                      title: 'Experience',
                      child: Column(
                        children: const [
                          _ProfileListItem(
                            title: 'Senior Financial Analyst',
                            subtitle: 'Johnson & Johnson',
                            time: '2021 – Present · San Francisco, CA',
                          ),
                          Divider(color: Colors.white12),
                          _ProfileListItem(
                            title: 'Financial Analyst',
                            subtitle: 'Morgan Stanley',
                            time: '2018 – 2021 · New York, NY',
                          ),
                        ],
                      ),
                    ),

                    linkedInCard(
                      title: 'Education',
                      child: const _ProfileListItem(
                        title: 'University of California, Berkeley',
                        subtitle:
                        'Master of Business Administration (MBA)',
                        time: '2016 – 2018',
                      ),
                    ),

                    linkedInCard(
                      title: 'Skills',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          _SkillChip('Financial Analysis'),
                          _SkillChip('Strategic Planning'),
                          _SkillChip('Leadership'),
                          _SkillChip('Data Modeling'),
                        ],
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

/* ================= HELPERS ================= */

Widget _roundIcon(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: Colors.black.withValues(alpha: 0.55),
      child: Icon(icon, color: Colors.white),
    ),
  );
}

Widget linkedInCard({required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(18),
      border:
      Border.all(color: Colors.white.withValues(alpha: 0.08)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Add',
              style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

class _ProfileListItem extends StatelessWidget {
  final String title, subtitle, time;

  const _ProfileListItem(
      {required this.title,
        required this.subtitle,
        required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70)),
          Text(time,
              style: const TextStyle(
                  color: Color(0xFF9CA3AF), fontSize: 13)),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border:
        Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Text(label,
          style:
          const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }
}

/* ================= DRAWER ================= */

class _ProfileDrawer extends StatelessWidget {
  const _ProfileDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F172A),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 32,
              backgroundImage:
              AssetImage(ProfileScreen.profileImage),
            ),
            const SizedBox(height: 8),
            const Text('Sally Liang',
                style: TextStyle(color: Colors.white)),
            const Text('Senior Financial Analyst',
                style: TextStyle(color: Colors.grey)),
            const Divider(color: Colors.white12),

            ListTile(
              leading:
              const Icon(Icons.bookmark, color: Colors.white),
              title: const Text('Saved Posts',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('View your saved content',
                  style: TextStyle(color: Colors.white54)),
              onTap: () {},
            ),
            ListTile(
              leading:
              const Icon(Icons.group, color: Colors.white),
              title: const Text('Groups',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('Manage your groups',
                  style: TextStyle(color: Colors.white54)),
              onTap: () {},
            ),
            ListTile(
              leading:
              const Icon(Icons.bar_chart, color: Colors.white),
              title: const Text('Analytics',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('View your insights',
                  style: TextStyle(color: Colors.white54)),
              onTap: () {},
            ),

            const Divider(color: Colors.white12),

            ListTile(
              leading:
              const Icon(Icons.settings, color: Colors.white),
              title: const Text('Settings',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SettingsScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.workspace_premium,
                  color: Colors.blue),
              title: const Text('Premium / Business Account',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('Upgrade your account',
                  style: TextStyle(color: Colors.white54)),
              onTap: () {},
            ),

            const Spacer(),

            ListTile(
              leading:
              const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (route) => false);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
