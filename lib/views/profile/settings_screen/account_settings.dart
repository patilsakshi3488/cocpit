import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Colors.white;
    final Color subTextColor = Colors.white.withValues(alpha: 0.5);
    final Color cardBg = const Color(0xFF111827);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccountItem("Personal Info", "Name, email, and phone number", Icons.person_outline, textColor, subTextColor, cardBg),
          const SizedBox(height: 12),
          _buildAccountItem("Password", "Change your account password", Icons.lock_outline, textColor, subTextColor, cardBg),
          const SizedBox(height: 12),
          _buildAccountItem("Language", "English (US)", Icons.language, textColor, subTextColor, cardBg),
          const SizedBox(height: 12),
          _buildAccountItem("Delete Account", "Permanently remove your data", Icons.delete_outline, Colors.redAccent, subTextColor, cardBg, isDanger: true),
        ],
      ),
    );
  }

  Widget _buildAccountItem(String title, String subtitle, IconData icon, Color textColor, Color subTextColor, Color cardBg, {bool isDanger = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDanger ? Colors.redAccent : Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: subTextColor.withValues(alpha: 0.3), size: 14),
        ],
      ),
    );
  }
}
