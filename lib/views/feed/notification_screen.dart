import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: const [
                      _NotificationTile(
                        title: "Sarah Chen liked your story",
                        time: "2m ago",
                        color: Color(0xFF60A5FA),
                        unread: true,
                      ),
                      Divider(color: Colors.white10, height: 1),
                      _NotificationTile(
                        title: "Michael Torres commented on your post",
                        time: "1h ago",
                        color: Color(0xFFC084FC),
                        unread: true,
                      ),
                      Divider(color: Colors.white10, height: 1),
                      _NotificationTile(
                        title: "New job alert: Product Designer",
                        time: "3h ago",
                        color: Color(0xFF34D399),
                        unread: false,
                      ),
                      Divider(color: Colors.white10, height: 1),
                      _NotificationTile(
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
    return Container(
      padding: const EdgeInsets.all(20),
      color: unread ? Colors.white.withOpacity(0.02) : Colors.transparent,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (unread)
            const CircleAvatar(
              radius: 4,
              backgroundColor: Color(0xFF4F70F0),
            ),
        ],
      ),
    );
  }
}
