import 'package:flutter/material.dart';

class PrivacySettings extends StatelessWidget {
  final bool profileVisibility;
  final bool showActivityStatus;
  final bool searchEngineIndexing;
  final ValueChanged<bool> onProfileVisibilityChanged;
  final ValueChanged<bool> onActivityStatusChanged;
  final ValueChanged<bool> onIndexingChanged;

  const PrivacySettings({
    super.key,
    required this.profileVisibility,
    required this.showActivityStatus,
    required this.searchEngineIndexing,
    required this.onProfileVisibilityChanged,
    required this.onActivityStatusChanged,
    required this.onIndexingChanged,
  });

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF6366F1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PRIVACY & SECURITY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "CONTROL HOW YOU SHARE YOUR INFORMATION.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 48),
        _buildSwitchOption(
          "PROFILE VISIBILITY", 
          "Make your profile visible to everyone", 
          profileVisibility, 
          onProfileVisibilityChanged, 
          primary
        ),
        _buildSwitchOption(
          "SHOW ACTIVITY STATUS", 
          "Let others see when you're online", 
          showActivityStatus, 
          onActivityStatusChanged, 
          primary
        ),
        _buildSwitchOption(
          "SEARCH ENGINE INDEXING", 
          "Allow search engines to show your profile", 
          searchEngineIndexing, 
          onIndexingChanged, 
          primary
        ),
      ],
    );
  }

  Widget _buildSwitchOption(String title, String subtitle, bool value, ValueChanged<bool> onChanged, Color primary) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primary,
            activeTrackColor: primary.withOpacity(0.2),
            inactiveThumbColor: Colors.white24,
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}
