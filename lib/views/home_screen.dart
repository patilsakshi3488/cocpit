import 'dart:async';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'notification_screen.dart';
import 'bottom_navigation.dart';
import 'create_career_moment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTop = true;

  final LinearGradient gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  // 🔥 Career Moments (UNCHANGED STRUCTURE)
  final List<Map<String, dynamic>> careerMoments = [
    {
      'name': 'You',
      'isMine': true,
      'stories': [],
      'image': 'lib/images/profile.png',
    },
    {
      'name': 'John Smith',
      'isMine': false,
      'image': 'lib/images/profile2.jpg',
      'stories': [
        {
          'image': 'lib/images/story1.png',
          'text': 'Flutter workshop 🚀',
          'likes': 12,
          'views': 54,
        },
        {
          'image': 'lib/images/story2.png',
          'text': 'Networking 🤝',
          'likes': 20,
          'views': 68,
        },
        {
          'image': 'lib/images/story3.png',
          'text': 'Late night coding 💻',
          'likes': 31,
          'views': 92,
        },
      ],
    },
    {
      'name': 'Sarah Johnson',
      'isMine': false,
      'image': 'lib/images/profile3.jpg',
      'stories': [
        {
          'image': 'lib/images/story4.png',
          'text': 'Promoted 💼',
          'likes': 44,
          'views': 120,
        },
        {
          'image': 'lib/images/story5.png',
          'text': 'Leading roadmap 🚀',
          'likes': 29,
          'views': 88,
        },
      ],
    },
    {
      'name': 'James Beauford',
      'isMine': false,
      'image': 'lib/images/profile.jpg',
      'stories': [
        {
          'image': 'lib/images/story1.png',
          'text': 'Flutter workshop 🚀',
          'likes': 12,
          'views': 54,
        },
        {
          'image': 'lib/images/story2.png',
          'text': 'Networking 🤝',
          'likes': 20,
          'views': 68,
        },
        {
          'image': 'lib/images/story3.png',
          'text': 'Late night coding 💻',
          'likes': 31,
          'views': 92,
        },
      ],
    },
    {
      'name': 'Isabel conqline',
      'isMine': false,
      'image': 'lib/images/profile5.jpg',
      'stories': [
        {
          'image': 'lib/images/story4.png',
          'text': 'Promoted 💼',
          'likes': 44,
          'views': 120,
        },
        {
          'image': 'lib/images/story5.png',
          'text': 'Leading roadmap 🚀',
          'likes': 29,
          'views': 88,
        },
      ],
    },
  ];

  final _posts = [
    {
      'name': 'Sarah Johnson',
      'title': 'Product Manager at Google',
      'time': '2h ago',
      'text': "Excited to share that our team just launched a new feature!",
      'image': 'lib/images/post1.jpg',
    },
    {
      'name': 'John Smith',
      'title': 'Senior Software Engineer at Meta',
      'time': '5h ago',
      'text': "Great discussions at today’s architecture review 🚀",
      'image': 'lib/images/post2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            _careerMomentsBar(),
            _topRecentToggle(),
            Expanded(child: _feed()),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }

  // ---------------- TOP BAR ----------------

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
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
                  Text("Search...", style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CAREER MOMENTS BAR ----------------

  Widget _careerMomentsBar() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: careerMoments.length,
        itemBuilder: (context, index) {
          final m = careerMoments[index];

          return GestureDetector(
            onTap: () {
              if (m['isMine']) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateCareerMomentScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CareerMomentViewer(
                      name: m['name'],
                      stories: m['stories'],
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: m['isMine'] ? gradient : null,
                image: !m['isMine']
                    ? DecorationImage(
                  image: AssetImage(m['image']),
                  fit: BoxFit.cover,
                )
                    : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: m['isMine']
                  ? const Center(
                child: Text(
                  "+\nYour Update",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Text(
                    m['name'],
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- TOP / RECENT ----------------

  Widget _topRecentToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          _pill("Top", showTop, () => setState(() => showTop = true)),
          const SizedBox(width: 10),
          _pill("Recent", !showTop, () => setState(() => showTop = false)),
        ],
      ),
    );
  }

  Widget _pill(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? gradient : null,
          color: selected ? null : const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // ---------------- FEED ----------------

  Widget _feed() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (context, index) => _postCard(_posts[index]),
    );
  }

  Widget _postCard(Map post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('lib/images/profile2.jpg')),
            title: Text(post['name'],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(
              "${post['title']} • ${post['time']}",
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child:
            Text(post['text'], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Image.asset(post['image'], fit: BoxFit.cover),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("234 likes",
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
                Text("45 comments • 12 shares",
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                _PostAction(icon: Icons.favorite_border, label: "Like"),
                _PostAction(icon: Icons.chat_bubble_outline, label: "Comment"),
                _PostAction(icon: Icons.share_outlined, label: "Share"),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// ================= STORY VIEWER (FEATURES ADDED ONLY) =================

class CareerMomentViewer extends StatefulWidget {
  final String name;
  final List stories;

  const CareerMomentViewer({
    super.key,
    required this.name,
    required this.stories,
  });

  @override
  State<CareerMomentViewer> createState() => _CareerMomentViewerState();
}

class _CareerMomentViewerState extends State<CareerMomentViewer> {
  int currentIndex = 0;
  double progress = 0;
  Timer? timer;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    progress = 0;

    timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      setState(() => progress += 0.01);
      if (progress >= 1) _nextStory();
    });
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      currentIndex++;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startTimer();
    } else {
      Navigator.pop(context);
    }
  }

  void _prevStory() {
    if (currentIndex > 0) {
      currentIndex--;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onHorizontalDragEnd: (d) {
          if (d.primaryVelocity! < 0) {
            _nextStory();
          } else {
            _prevStory();
          }
        },
        onTapUp: (d) {
          if (d.localPosition.dx <
              MediaQuery.of(context).size.width / 2) {
            _prevStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (_, i) {
                return Image.asset(
                  widget.stories[i]['image'],
                  fit: BoxFit.cover,
                );
              },
            ),

            // Progress bars
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(widget.stories.length, (i) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: i < currentIndex
                            ? Colors.white
                            : i == currentIndex
                            ? Colors.white.withOpacity(progress)
                            : Colors.white24,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),

            Positioned(
              top: 50,
              left: 16,
              child: Text(widget.name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),

            // Bottom reaction bar
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  const Icon(Icons.favorite_border, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.stories[currentIndex]['likes']}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  const SizedBox(width: 6),
                  const Text("Reply",
                      style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  const Icon(Icons.remove_red_eye, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.stories[currentIndex]['views']}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 40,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PostAction({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white54, size: 20),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
























/*import 'package:flutter/material.dart';

import 'profile_screen.dart';
import 'chat_screen.dart';
import 'notification_screen.dart';
import 'create_post_screen.dart';
import 'jobs_screen.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool showTop = true;

  final LinearGradient gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  final _posts = [
    {
      'name': 'Sarah Johnson',
      'title': 'Product Manager at Google',
      'time': '2h ago',
      'text':
      "Excited to share that our team just launched a new feature that will revolutionize how users interact with our platform!",
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'John Smith',
      'title': 'Senior Software Engineer at Meta',
      'time': '5h ago',
      'text':
      "Great discussions at today’s architecture review. Scaling systems is always a fun challenge 🚀",
      'image': 'lib/images/profile.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            _stories(),
            _topRecentToggle(),
            Expanded(child: _feed()),
          ],
        ),
      ),

      // ✅ BOTTOM NAV FROM SEPARATE FILE
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }

  // ---------------- TOP BAR ----------------

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
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
                  Text("Search...",
                      style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            },
            child: const Icon(Icons.chat_bubble_outline,
                color: Colors.white),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const NotificationScreen()),
              );
            },
            child: const Icon(Icons.notifications_none,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ---------------- STORIES ----------------

  Widget _stories() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _yourStory(),
          _story("John Smith"),
          _story("Sarah Johnson"),
        ],
      ),
    );
  }

  Widget _yourStory() {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "+\nYour Update",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _story(String name) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('lib/images/profile.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // ---------------- TOP / RECENT ----------------

  Widget _topRecentToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          _pill("Top", showTop, () => setState(() => showTop = true)),
          const SizedBox(width: 10),
          _pill("Recent", !showTop,
                  () => setState(() => showTop = false)),
        ],
      ),
    );
  }

  Widget _pill(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? gradient : null,
          color: selected ? null : const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(20),
        ),
        child:
        Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // ---------------- FEED ----------------

  Widget _feed() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _postCard(_posts[index]);
      },
    );
  }

  Widget _postCard(Map post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage:
              AssetImage('lib/images/profile.jpg'),
            ),
            title: Text(
              post['name'],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${post['title']} • ${post['time']}",
              style: const TextStyle(
                  color: Colors.white54, fontSize: 12),
            ),
            trailing: const Icon(Icons.more_horiz,
                color: Colors.white54),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(post['text'],
                style:
                const TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),
          Image.asset(post['image'], fit: BoxFit.cover),
          const Divider(color: Colors.white12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: const [
                _Action(
                    icon: Icons.thumb_up_alt_outlined,
                    label: "Like"),
                _Action(
                    icon: Icons.comment_outlined,
                    label: "Comment"),
                _Action(
                    icon: Icons.share_outlined,
                    label: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Action({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}*/


