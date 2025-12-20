import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
          "Messages",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),

      // ✅ BOTTOM NAVIGATION VISIBLE
      bottomNavigationBar: const AppBottomNavigation(
        currentIndex: 0, // Feed highlighted
      ),

      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54),
                  SizedBox(width: 10),
                  Text(
                    "Search messages",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),

          // 💬 Messages List
          Expanded(
            child: ListView(
              children: const [
                _ChatTile(
                  name: "Sarah Johnson",
                  message: "Thanks for connecting! Would love to discuss...",
                  time: "2h",
                  unread: true,
                ),
                _ChatTile(
                  name: "Michael Chen",
                  message: "Great presentation today!",
                  time: "5h",
                  unread: false,
                ),
                _ChatTile(
                  name: "Emily Roberts",
                  message: "Let’s schedule a call next week",
                  time: "1d",
                  unread: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= CHAT TILE =================

class _ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool unread;

  const _ChatTile({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
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
        children: [
          // 👤 Avatar
          Stack(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('lib/images/profile.jpg'),
              ),
              if (unread)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1F2937),
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // 📄 Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ⏰ Time
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
              if (unread)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6366F1),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
