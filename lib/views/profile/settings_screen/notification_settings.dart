import 'package:flutter/material.dart';

class NotificationSettings extends StatelessWidget {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool messageNotifications;
  final bool jobAlerts;
  final Function(bool) onEmailChanged;
  final Function(bool) onPushChanged;
  final Function(bool) onMessageChanged;
  final Function(bool) onJobAlertsChanged;

  const NotificationSettings({
    super.key,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.messageNotifications,
    required this.jobAlerts,
    required this.onEmailChanged,
    required this.onPushChanged,
    required this.onMessageChanged,
    required this.onJobAlertsChanged,
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
          _buildSwitchOption("Email Notifications", "Receive email updates about your activity", emailNotifications, onEmailChanged, primary, textColor, subTextColor),
          const SizedBox(height: 16),
          _buildSwitchOption("Push Notifications", "Get notifications on your devices", pushNotifications, onPushChanged, primary, textColor, subTextColor),
          const SizedBox(height: 16),
          _buildSwitchOption("Message Notifications", "Get notified about new messages", messageNotifications, onMessageChanged, primary, textColor, subTextColor),
          const SizedBox(height: 16),
          _buildSwitchOption("Job Alerts", "Receive notifications about job matches", jobAlerts, onJobAlertsChanged, primary, textColor, subTextColor),
        ],
      ),
    );
  }

  Widget _buildSwitchOption(String title, String subtitle, bool value, Function(bool) onChanged, Color primary, Color textColor, Color subTextColor) {
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
