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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    final Color subTextColor = textColor.withValues(alpha: 0.5);
    final Color primary = const Color(0xFF6366F1);

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
          _buildSwitchOption(
            "Profile Visibility", 
            "Make your profile visible to everyone", 
            profileVisibility, 
            onProfileVisibilityChanged, 
            primary,
            textColor,
            subTextColor
          ),
          const SizedBox(height: 16),
          _buildSwitchOption(
            "Show Activity Status", 
            "Let others see when you're online", 
            showActivityStatus, 
            onActivityStatusChanged, 
            primary,
            textColor,
            subTextColor
          ),
          const SizedBox(height: 16),
          _buildSwitchOption(
            "Search Engine Indexing", 
            "Allow search engines to show your profile", 
            searchEngineIndexing, 
            onIndexingChanged, 
            primary,
            textColor,
            subTextColor
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchOption(String title, String subtitle, bool value, ValueChanged<bool> onChanged, Color primary, Color textColor, Color subTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: primary,
        ),
      ],
    );
  }
}
