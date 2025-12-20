import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 6),
        children: const [
          _NotificationTile(
            name: "John Smith",
            action: "liked your post about financial analysis",
            time: "5m ago",
            iconBg: Color(0xFFEF4444),
            icon: Icons.favorite,
            unread: true,
          ),
          _NotificationTile(
            name: "Sarah Johnson",
            action: "commented on your post",
            time: "1h ago",
            iconBg: Color(0xFF3B82F6),
            icon: Icons.comment,
            unread: true,
          ),
          _NotificationTile(
            name: "Michael Chen",
            action: "started following you",
            time: "3h ago",
            iconBg: Color(0xFF22C55E),
            icon: Icons.person_add,
            unread: false,
          ),
          _NotificationTile(
            name: "LinkedIn",
            action: "New job recommendations for you",
            time: "5h ago",
            iconBg: Color(0xFF6366F1),
            icon: Icons.work,
            unread: false,
            isBrand: true,
          ),
        ],
      ),

      // ✅ ADDED (NO UI CHANGE)
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),

    );
  }
}

// ================= NOTIFICATION TILE =================

class _NotificationTile extends StatelessWidget {
  final String name;
  final String action;
  final String time;
  final IconData icon;
  final Color iconBg;
  final bool unread;
  final bool isBrand;

  const _NotificationTile({
    required this.name,
    required this.action,
    required this.time,
    required this.icon,
    required this.iconBg,
    required this.unread,
    this.isBrand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👤 Avatar + Action Icon
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: isBrand ? iconBg : Colors.transparent,
                backgroundImage: isBrand
                    ? null
                    : const AssetImage('lib/images/profile.jpg'),
                child: isBrand
                    ? const Text(
                  "in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    : null,
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: iconBg,
                  child: Icon(icon, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // 📄 Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$name ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: action,
                        style:
                        const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // 🔵 Unread Dot
          if (unread)
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: CircleAvatar(
                radius: 4,
                backgroundColor: Color(0xFF6366F1),
              ),
            ),
        ],
      ),
    );
  }
}
