import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
                "Messages",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.white54, size: 20),
                    SizedBox(width: 12),
                    Text(
                      "Search messages...",
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 💬 Messages List
            Expanded(
              child: ListView(
                children: [
                  _ChatTile(
                    name: "Michael Chen",
                    role: "Recruiter",
                    message: "Thanks for connecting! Looking forwar...",
                    time: "2m ago",
                    unreadCount: 2,
                    color: Colors.blueAccent,
                    isOnline: true,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalChatScreen(name: "Michael Chen", role: "Recruiter", color: Colors.blueAccent))),
                  ),
                  _ChatTile(
                    name: "Emily Rodriguez",
                    role: "Hiring Manager",
                    message: "That sounds great! When would be a good ...",
                    time: "1h ago",
                    unreadCount: 0,
                    color: Colors.pinkAccent,
                    isOnline: true,
                    onTap: () {},
                  ),
                  _ChatTile(
                    name: "David Park",
                    role: "Connection",
                    message: "I saw your recent post about AI trends...",
                    time: "3h ago",
                    unreadCount: 1,
                    color: Colors.deepPurpleAccent,
                    isOnline: false,
                    onTap: () {},
                  ),
                  _ChatTile(
                    name: "Jessica Williams",
                    role: "Talent Acquisition",
                    message: "Happy to help with that project!",
                    time: "1d ago",
                    unreadCount: 0,
                    color: Colors.greenAccent,
                    isOnline: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String name;
  final String role;
  final String message;
  final String time;
  final int unreadCount;
  final Color color;
  final bool isOnline;
  final VoidCallback onTap;

  const _ChatTile({
    required this.name,
    required this.role,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.color,
    required this.isOnline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: color,
                ),
                if (isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0B1220), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        time,
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      role,
                      style: const TextStyle(color: Color(0xFF7C83FF), fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: Color(0xFF4F70F0), shape: BoxShape.circle),
                          child: Text(
                            unreadCount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalChatScreen extends StatefulWidget {
  final String name;
  final String role;
  final Color color;

  const PersonalChatScreen({super.key, required this.name, required this.role, required this.color});

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hi! Thanks for accepting my connection request!', 'isMe': false, 'time': '10:30 AM'},
    {'text': 'I\'m reaching out regarding the Senior React role.', 'isMe': false, 'time': '10:31 AM'},
    {'text': 'Hi Michael! Thanks for reaching out.', 'isMe': true, 'time': '10:32 AM'},
    {'text': 'I\'d love to hear more about the team.', 'isMe': true, 'time': '10:32 AM'},
    {'text': 'Great! Do you have time for a quick call this week?', 'isMe': false, 'time': '10:33 AM'},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text.trim(),
          'isMe': true,
          'time': TimeOfDay.now().format(context),
        });
        _messageController.clear();
      });
    }
  }

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
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 18, backgroundColor: widget.color),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: const Color(0xFF0B1220), width: 1.5)),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(widget.role, style: const TextStyle(color: Color(0xFF7C83FF), fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF1F2937).withOpacity(0.5),
            child: const Text(
              "Context: Senior React Developer Role",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7C83FF), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                bool showTime = index == _messages.length - 1 || _messages[index + 1]['isMe'] != msg['isMe'];
                return Column(
                  crossAxisAlignment: msg['isMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: msg['isMe'] ? const Color(0xFF4F70F0) : const Color(0xFF1F2937),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        msg['text'],
                        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                      ),
                    ),
                    if (showTime)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 4),
                        child: Text(
                          msg['time'],
                          style: const TextStyle(color: Colors.white38, fontSize: 11),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.attach_file, color: Colors.white54), onPressed: () {}),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Write a message...",
                        hintStyle: const TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        suffixIcon: IconButton(icon: const Icon(Icons.sentiment_satisfied_alt_outlined, color: Colors.white54), onPressed: () {}),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFF4F70F0),
                    child: Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
