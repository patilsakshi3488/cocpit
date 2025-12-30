import 'package:flutter/material.dart';

class AppearanceSettings extends StatelessWidget {
  final String selectedTheme;
  final bool isCompactMode;
  final ValueChanged<String> onThemeChanged;
  final ValueChanged<bool> onCompactModeChanged;

  const AppearanceSettings({
    super.key,
    required this.selectedTheme,
    required this.isCompactMode,
    required this.onThemeChanged,
    required this.onCompactModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subTextColor = isDark ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.4);
    final Color primary = const Color(0xFF6366F1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "APPEARANCE",
          style: TextStyle(
            color: textColor,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "CHOOSE A THEME THAT SUITS YOUR READING STYLE.",
          style: TextStyle(
            color: subTextColor,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 48),
        _buildThemeOption("NAVY MODE", "The classic experience", primary, textColor, subTextColor),
        _buildThemeOption("LIGHT MODE", "Clean and bright interface", primary, textColor, subTextColor),
        _buildThemeOption("DARK MODE", "Easy on the eyes, perfect for night", primary, textColor, subTextColor),
        _buildThemeOption("SYSTEM", "Follow your device's setting", primary, textColor, subTextColor),
        const SizedBox(height: 64),
        Text(
          "DISPLAY",
          style: TextStyle(
            color: textColor,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "COMPACT MODE",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Show more content in less space",
                  style: TextStyle(
                    color: subTextColor.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Switch(
              value: isCompactMode,
              onChanged: onCompactModeChanged,
              activeColor: primary,
              activeTrackColor: primary.withOpacity(0.2),
              inactiveThumbColor: isDark ? Colors.white24 : Colors.grey[400],
              inactiveTrackColor: isDark ? Colors.white10 : Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(String title, String subtitle, Color primary, Color textColor, Color subTextColor) {
    bool isSelected = selectedTheme.toUpperCase() == title;
    return GestureDetector(
      onTap: () => onThemeChanged(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: subTextColor.withOpacity(0.1), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? primary : textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check, color: primary, size: 24),
          ],
        ),
      ),
    );
  }
}
