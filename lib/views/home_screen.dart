import 'dart:async';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'notification_screen.dart';
import 'bottom_navigation.dart';
import 'create_career_moment_screen.dart';
import 'career_moment_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTop = false;

  final LinearGradient gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  final List<Map<String, dynamic>> careerMoments = [
    {
      'name': 'You',
      'isMine': true,
      'stories': [
        {'image': 'lib/images/profile.png', 'text': 'Just sharing my latest update with my close friends!', 'time': '1m ago'},
      ],
      'profile': 'lib/images/profile.png',
      'image': 'lib/images/profile.png',
    },
    {
      'name': 'Mike Torres',
      'isMine': false,
      'image': 'lib/images/story1.png',
      'profile': 'lib/images/profile2.jpg',
      'stories': [
        {
          'image': 'lib/images/story1.png',
          'text': 'Excited to share a sneak peek of our latest product feature! This has been months in the making and the team has done an incredible job. Can’t wait to hear your thoughts!',
          'time': '6h ago'
        },
      ],
    },
    {
      'name': 'David Kim',
      'isMine': false,
      'image': 'lib/images/story4.png',
      'profile': 'lib/images/profile3.jpg',
      'stories': [
        {
          'image': 'lib/images/story4.png',
          'text': 'Sharing some insights from our latest data analysis project. The patterns we discovered are fascinating! Always amazed by what the data reveals when you look closely enough.',
          'time': '8h ago'
        },
      ],
    },
    {
      'name': 'Sarah Chen',
      'isMine': false,
      'image': 'lib/images/post1.jpg',
      'profile': 'lib/images/profile3.jpg',
      'stories': [
        {
          'image': 'lib/images/post1.jpg',
          'text': 'Just launched our new design system! Working with an amazing team to create consistent, accessible experiences across all our products.',
          'time': '2h ago'
        },
      ],
    },
    {
      'name': 'John Smith',
      'isMine': false,
      'image': 'lib/images/post2.jpg',
      'profile': 'lib/images/profile2.jpg',
      'stories': [
        {
          'image': 'lib/images/post2.jpg',
          'text': 'Great discussions at today’s architecture review 🚀',
          'time': '5h ago'
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'name': 'Sarah Chen',
      'title': 'UX Designer at Design Studio',
      'time': '2h ago',
      'text': "🎨 Just launched our new design system! Working with an amazing team to create consistent, accessible experiences across all our products.",
      'image': 'lib/images/post1.jpg',
      'profile': 'lib/images/profile3.jpg',
      'likes': 234,
      'isLiked': false,
      'isPrivate': false,
      'comments_count': 47,
      'shares': 12,
      'comments': [],
    },
    {
      'id': '2',
      'name': 'Sally Liang',
      'title': 'Senior Financial Analyst at Johnson & Johnson',
      'time': '1d ago',
      'text': "Just finished a deep dive into data analysis trends for 2024. The shift towards AI-driven forecasting is fascinating! #DataAnalysis #FinTech",
      'image': null,
      'profile': 'lib/images/profile4.jpg',
      'likes': 1200,
      'isLiked': false,
      'isPrivate': false,
      'comments_count': 15,
      'shares': 8,
      'comments': [],
    },
    {
      'id': 'suggested',
      'type': 'suggested',
    },
    {
      'id': '3',
      'name': 'Sally Liang',
      'title': 'Senior Financial Analyst at Johnson & Johnson',
      'time': '3d ago',
      'text': "Great session on Product Strategy today. Always learning! 📚",
      'image': null,
      'profile': 'lib/images/profile4.jpg',
      'likes': 850,
      'isLiked': false,
      'isPrivate': false,
      'comments_count': 12,
      'shares': 3,
      'comments': [],
    },
    {
      'id': '4',
      'name': 'Sally Liang',
      'title': 'Senior Financial Analyst at Johnson & Johnson',
      'time': '1w ago',
      'text': "Honored to be recognized as Top Contributor of the Month! 🏆 Thanks to my amazing team.",
      'image': null,
      'profile': 'lib/images/profile4.jpg',
      'likes': 2100,
      'isLiked': false,
      'isPrivate': true,
      'comments_count': 45,
      'shares': 12,
      'comments': [],
    },
    {
      'id': '5',
      'name': 'John Smith',
      'title': 'Senior Software Engineer at Meta',
      'time': '5h ago',
      'text': "Great discussions at today’s architecture review 🚀",
      'image': 'lib/images/post2.jpg',
      'profile': 'lib/images/profile2.jpg',
      'likes': 189,
      'isLiked': false,
      'isPrivate': false,
      'comments_count': 23,
      'shares': 8,
      'comments': [],
    },
  ];

  final List<Map<String, dynamic>> suggestedUsers = [
    {
      'name': 'Sarah Williams',
      'role': 'UX Designer',
      'followers': '2.3k',
      'profile': 'lib/images/profile3.jpg',
      'isVerified': true,
    },
    {
      'name': 'Michael Jordan',
      'role': 'Software Engineer',
      'followers': '1.8k',
      'profile': 'lib/images/profile2.jpg',
      'isVerified': false,
    },
    {
      'name': 'Alex Johnson',
      'role': 'Product Manager',
      'followers': '3.5k',
      'profile': 'lib/images/profile4.jpg',
      'isVerified': true,
    },
  ];

  final List<Map<String, dynamic>> shareToUsers = [
    {'name': 'Michael Chen', 'role': 'Recruiter', 'profile': 'lib/images/profile2.jpg', 'color': Colors.lightBlue},
    {'name': 'Emily Rodriguez', 'role': 'Hiring Manager', 'profile': 'lib/images/profile4.jpg', 'color': Colors.pinkAccent},
    {'name': 'David Park', 'role': 'Connection', 'profile': 'lib/images/profile3.jpg', 'color': Colors.deepPurpleAccent},
    {'name': 'Jessica Williams', 'role': 'Talent Acquisition', 'profile': 'lib/images/profile4.jpg', 'color': Colors.greenAccent},
    {'name': 'Alex Thompson', 'role': 'Designer', 'profile': 'lib/images/profile2.jpg', 'color': Colors.orangeAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(
              child: ListView(
                children: [
                  _storiesHeader(),
                  _careerMomentsBar(),
                  const SizedBox(height: 20),
                  _topRecentToggle(),
                  const Divider(color: Colors.white10, height: 1),
                  ..._posts.map((post) {
                    if (post['type'] == 'suggested') {
                      return _suggestedForYouSection();
                    }
                    return _postView(post);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.logo_dev, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54, size: 20),
                  SizedBox(width: 10),
                  Text("Search...", style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storiesHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Stories", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text("View All", style: TextStyle(color: Color(0xFF7C83FF), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _careerMomentsBar() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: careerMoments.length,
        itemBuilder: (context, index) {
          final m = careerMoments[index];
          return GestureDetector(
            onTap: () {
              if (m['isMine']) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateCareerMomentScreen()));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CareerMomentViewer(
                      users: careerMoments,
                      initialUserIndex: index,
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: !m['isMine'] ? DecorationImage(image: AssetImage(m['image']), fit: BoxFit.cover) : null,
                color: m['isMine'] ? const Color(0xFF4F70F0) : const Color(0xFF1F2937),
              ),
              child: Stack(
                children: [
                  if (m['isMine'])
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.add, color: Colors.white, size: 30),
                          ),
                          const SizedBox(height: 12),
                          const Text("Your Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                  if (!m['isMine']) ...[
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: const Color(0xFF7C83FF),
                            child: CircleAvatar(radius: 16, backgroundImage: AssetImage(m['profile'])),
                          ),
                          const SizedBox(height: 4),
                          Text(m['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topRecentToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _togglePill("Top", showTop, () => setState(() => showTop = true)),
          const SizedBox(width: 12),
          _togglePill("Recent", !showTop, () => setState(() => showTop = false)),
        ],
      ),
    );
  }

  Widget _togglePill(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4F70F0) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(color: selected ? Colors.white : Colors.white54, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _postView(Map<String, dynamic> post) {
    String likesText = post['likes'] >= 1000 ? "${(post['likes'] / 1000).toStringAsFixed(1)}k" : "${post['likes']}";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(post['profile'] ?? 'lib/images/profile.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(post['title'], style: const TextStyle(color: Colors.white54, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          Text(post['time'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          if (post['isPrivate'] == true) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.visibility_off_outlined, color: Colors.white38, size: 12),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: PopupMenuThemeData(
                      color: const Color(0xFF1F2937),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, color: Colors.white54),
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == 'private') {
                        setState(() {
                          post['isPrivate'] = !(post['isPrivate'] ?? false);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(post['isPrivate'] ? "Post is now private" : "Post is now public")),
                        );
                      } else if (value == 'delete') {
                        setState(() {
                          _posts.removeWhere((p) => p['id'] == post['id']);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post deleted")));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'private',
                        child: Row(
                          children: [
                            Icon(post['isPrivate'] == true ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white, size: 20),
                            const SizedBox(width: 12),
                            Text(post['isPrivate'] == true ? "Make Public" : "Make Private", style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                            const SizedBox(width: 12),
                            Text("Delete", style: TextStyle(color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(post['text'], style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
          ),
          const SizedBox(height: 16),
          if (post['image'] != null)
            Image.asset(post['image'], width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.pinkAccent, size: 16),
                        const SizedBox(width: 4),
                        Text("$likesText likes", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                      ],
                    ),
                    Text("${post['comments_count']} comments • ${post['shares']} shares", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _actionButton(Icons.favorite_border, "Like", () {}),
                    _actionButton(Icons.chat_bubble_outline, "Comment", () {}),
                    _actionButton(Icons.share_outlined, "Share", () => _showShareSheet(context)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 8, thickness: 8),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 20),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    int selectedIndex = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Share to",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white10, height: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white38),
                          icon: Icon(Icons.search, color: Colors.white38, size: 20),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shareToUsers.length,
                      itemBuilder: (context, index) {
                        final user = shareToUsers[index];
                        final isSelected = selectedIndex == index;
                        return InkWell(
                          onTap: () => setSheetState(() => selectedIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withOpacity(0.05) : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: user['color'],
                                  child: Text(
                                    user['name'][0],
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text(user['role'], style: const TextStyle(color: Colors.white54, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: isSelected ? const Color(0xFF6366F1) : Colors.white24, width: 2),
                                    color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
                                  ),
                                  child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white10)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Write a message...",
                              hintStyle: TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Shared successfully"),
                                backgroundColor: Color(0xFF6366F1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _suggestedForYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text("Suggested for you", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: suggestedUsers.length,
            itemBuilder: (context, index) {
              final user = suggestedUsers[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(radius: 40, backgroundImage: AssetImage(user['profile'])),
                        if (user['isVerified'])
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xFF4F70F0),
                              child: Icon(Icons.check, color: Colors.white, size: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(user['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(user['role'], style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text("${user['followers']} followers", style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F70F0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(double.infinity, 32),
                      ),
                      child: const Text("Follow", style: TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: Colors.white10, height: 8, thickness: 8),
      ],
    );
  }
}
