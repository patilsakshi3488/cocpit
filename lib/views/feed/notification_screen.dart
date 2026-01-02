import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                "Notifications",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const _NotificationTile(
                        title: "Sarah Chen liked your story",
                        time: "2m ago",
                        color: Color(0xFF60A5FA),
                        unread: true,
                      ),
                      Divider(color: theme.dividerColor, height: 1),
                      const _NotificationTile(
                        title: "Michael Torres commented on your post",
                        time: "1h ago",
                        color: Color(0xFFC084FC),
                        unread: true,
                      ),
                      Divider(color: theme.dividerColor, height: 1),
                      const _NotificationTile(
                        title: "New job alert: Product Designer",
                        time: "3h ago",
                        color: Color(0xFF34D399),
                        unread: false,
                      ),
                      Divider(color: theme.dividerColor, height: 1),
                      const _NotificationTile(
                        title: "Jessica Williams viewed your profile",
                        time: "5h ago",
                        color: Color(0xFFFACC15),
                        unread: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final bool unread;

  const _NotificationTile({
    required this.title,
    required this.time,
    required this.color,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      color: unread ? colorScheme.onSurface.withValues(alpha: 0.02) : Colors.transparent,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (unread)
            CircleAvatar(
              radius: 4,
              backgroundColor: theme.primaryColor,
            ),
        ],
      ),
    );
  }
}
