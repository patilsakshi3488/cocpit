import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/theme_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final themeMode = themeService.themeMode;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Appearance'),
          _settingsCard(
            child: Column(
              children: [
                _themeTile(
                  context,
                  title: 'Light',
                  mode: ThemeMode.light,
                  current: themeMode,
                ),
                _divider(),
                _themeTile(
                  context,
                  title: 'Dark',
                  mode: ThemeMode.dark,
                  current: themeMode,
                ),
                _divider(),
                _themeTile(
                  context,
                  title: 'System',
                  mode: ThemeMode.system,
                  current: themeMode,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionTitle('Notifications'),
          _settingsCard(
            child: _simpleTile(
              icon: Icons.notifications,
              title: 'Push Notifications',
              subtitle: 'Manage notification preferences',
              onTap: () {},
            ),
          ),

          const SizedBox(height: 24),

          _sectionTitle('Privacy & Security'),
          _settingsCard(
            child: Column(
              children: [
                _simpleTile(
                  icon: Icons.lock,
                  title: 'Privacy Settings',
                  subtitle: 'Control who can see your content',
                  onTap: () {},
                ),
                _divider(),
                _simpleTile(
                  icon: Icons.password,
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionTitle('Account'),
          _settingsCard(
            child: Column(
              children: [
                _simpleTile(
                  icon: Icons.person,
                  title: 'Account Information',
                  subtitle: 'View and edit your details',
                  onTap: () {},
                ),
                _divider(),
                _simpleTile(
                  icon: Icons.delete_forever,
                  title: 'Deactivate Account',
                  subtitle: 'Temporarily disable your account',
                  danger: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------- HELPERS ---------------- */

  static Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget _settingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: child,
    );
  }

  static Widget _divider() {
    return const Divider(height: 1, color: Colors.white12);
  }

  static Widget _simpleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: danger ? Colors.red : Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? Colors.red : Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      onTap: onTap,
    );
  }

  static Widget _themeTile(
      BuildContext context, {
        required String title,
        required ThemeMode mode,
        required ThemeMode current,
      }) {
    return ListTile(
      leading: const Icon(Icons.color_lens, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: current == mode
          ? const Icon(Icons.check, color: Color(0xFF3B82F6))
          : null,
      onTap: () {
        context.read<ThemeService>().setTheme(mode);
      },
    );
  }
}
