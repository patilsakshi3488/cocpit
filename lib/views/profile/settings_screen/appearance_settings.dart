import 'package:flutter/material.dart';
import '../../../services/theme_service.dart';

class AppearanceSettings extends StatelessWidget {
  final AppTheme selectedTheme;
  final bool isCompactMode;
  final ValueChanged<AppTheme> onThemeChanged;
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
    final theme = Theme.of(context);
    final primary = theme.primaryColor;
    final cardBg = theme.colorScheme.surfaceContainer;
    final subTextColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Theme Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Theme",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildThemeOption(context, AppTheme.navy, "Navy Mode", "The classic experience", Icons.bolt, primary, subTextColor),
              const SizedBox(height: 12),
              _buildThemeOption(context, AppTheme.light, "Light Mode", "Clean and bright interface", Icons.light_mode_outlined, primary, subTextColor),
              const SizedBox(height: 12),
              _buildThemeOption(context, AppTheme.dark, "Dark Mode", "Easy on the eyes, perfect for night", Icons.nightlight_outlined, primary, subTextColor),
              const SizedBox(height: 12),
              _buildThemeOption(context, AppTheme.system, "System", "Follow your device's setting", Icons.desktop_windows_outlined, primary, subTextColor),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Display Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Display",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Compact mode",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Show more content in less space",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isCompactMode,
                    onChanged: onCompactModeChanged,
                    activeColor: Colors.white,
                    activeTrackColor: primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(BuildContext context, AppTheme theme, String title, String subtitle, IconData icon, Color primary, Color subTextColor) {
    final appTheme = Theme.of(context);
    bool isSelected = selectedTheme == theme;
    return GestureDetector(
      onTap: () => onThemeChanged(theme),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: appTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primary : appTheme.dividerColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? primary : subTextColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTheme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: appTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primary : subTextColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: isSelected 
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ) 
                : null,
            ),
          ],
        ),
      ),
    );
  }
}
