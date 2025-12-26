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
  bool showTop = false;

  final LinearGradient gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  final List<Map<String, dynamic>> careerMoments = [
    {
      'name': 'You',
      'isMine': true,
      'stories': [],
      'image': 'lib/images/profile.png',
    },
    {
      'name': 'James Wilson',
      'isMine': false,
      'image': 'lib/images/story1.png',
      'profile': 'lib/images/profile2.jpg',
      'stories': [
        {'image': 'lib/images/story1.png', 'text': 'Workshop', 'likes': 12, 'views': 54},
      ],
    },
    {
      'name': 'Sarah Chen',
      'isMine': false,
      'image': 'lib/images/story4.png',
      'profile': 'lib/images/profile3.jpg',
      'stories': [
        {'image': 'lib/images/story4.png', 'text': 'Project', 'likes': 44, 'views': 120},
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
      'comments_count': 12,
      'shares': 3,
      'comments': [],
    },
    {
      'id': '4',
      'name': 'John Smith',
      'title': 'Senior Software Engineer at Meta',
      'time': '5h ago',
      'text': "Great discussions at today’s architecture review 🚀",
      'image': 'lib/images/post2.jpg',
      'profile': 'lib/images/profile2.jpg',
      'likes': 189,
      'isLiked': false,
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => CareerMomentViewer(name: m['name'], stories: m['stories'])));
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
                      Text(post['time'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.white54),
                  onPressed: () => _showPostOptions(context, post),
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _actionButton(Icons.favorite_border, "Like", post['isLiked'], () {
                      setState(() {
                        post['isLiked'] = !post['isLiked'];
                        post['likes'] += post['isLiked'] ? 1 : -1;
                      });
                    }),
                    _actionButton(Icons.chat_bubble_outline, "Comment", false, () {
                      _showCommentSheet(context, post);
                    }),
                    _actionButton(Icons.share_outlined, "Share", false, () {}),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, thickness: 8),
        ],
      ),
    );
  }

  Widget _suggestedForYouSection() {
    return Container(
      color: const Color(0xFF1F2937).withOpacity(0.3),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Suggested for you", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text("See all", style: TextStyle(color: Color(0xFF7C83FF)))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: suggestedUsers.length,
              itemBuilder: (context, index) {
                final user = suggestedUsers[index];
                return Container(
                  width: 260,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(radius: 30, backgroundImage: AssetImage(user['profile'])),
                              if (user['isVerified'])
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(color: Color(0xFF4F70F0), shape: BoxShape.circle),
                                    child: const Icon(Icons.check, color: Colors.white, size: 12),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(user['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(user['role'], style: const TextStyle(color: Colors.white54, fontSize: 13)),
                                const SizedBox(height: 8),
                                Text("${user['followers']} followers", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F70F0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 16),
                                SizedBox(width: 4),
                                Text("Follow", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(Icons.close, color: Colors.white38, size: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: InkWell(
              onTap: () {},
              child: const Text("View more suggestions →", style: TextStyle(color: Colors.white54, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F2937),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.lock_outline, color: Colors.white),
              title: const Text("Make Private", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post is now private")));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
              title: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                setState(() {
                  _posts.removeWhere((p) => p['id'] == post['id']);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post deleted")));
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Icon(isActive ? Icons.favorite : icon, color: isActive ? Colors.pinkAccent : Colors.white54, size: 20),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isActive ? Colors.pinkAccent : Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showCommentSheet(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F2937),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => _CommentSheetContent(
        initialComments: post['comments'] as List,
        onCommentAdded: (c) {
          setState(() {
            post['comments'].add(c);
            post['comments_count']++;
          });
        },
      ),
    );
  }
}

class _CommentSheetContent extends StatefulWidget {
  final List initialComments;
  final Function(Map<String, dynamic>)? onCommentAdded;

  const _CommentSheetContent({required this.initialComments, this.onCommentAdded});

  @override
  State<_CommentSheetContent> createState() => _CommentSheetContentState();
}

class _CommentSheetContentState extends State<_CommentSheetContent> {
  late List comments;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments = List.from(widget.initialComments);
  }

  void _postComment() {
    if (_controller.text.trim().isNotEmpty) {
      final newComment = {
        'name': 'You',
        'time': 'Just now',
        'text': _controller.text.trim(),
        'likes': 0,
        'isLiked': false,
      };
      setState(() {
        comments.add(newComment);
      });
      widget.onCommentAdded?.call(newComment);
      _controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Text("Comments", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              const Divider(color: Colors.white12),
              Flexible(
                child: comments.isEmpty
                    ? const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 50), child: Text("No comments yet.", style: TextStyle(color: Colors.white38))))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) => _CommentItem(
                          comment: comments[index] as Map<String, dynamic>,
                          onLikeChanged: (isLiked) {
                            setState(() {
                              comments[index]['isLiked'] = isLiked;
                              comments[index]['likes'] += isLiked ? 1 : -1;
                            });
                          },
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const CircleAvatar(radius: 18, backgroundImage: AssetImage('lib/images/profile.png')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(24)),
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Add a comment...",
                          hintStyle: const TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          suffixIcon: TextButton(
                            onPressed: _postComment,
                            child: const Text("Post", style: TextStyle(color: Color(0xFF7C83FF), fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final Map<String, dynamic> comment;
  final Function(bool)? onLikeChanged;

  const _CommentItem({required this.comment, this.onLikeChanged});

  @override
  Widget build(BuildContext context) {
    bool isLiked = comment['isLiked'] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 18, backgroundImage: AssetImage('lib/images/profile2.jpg')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF111827).withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(comment['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(comment['time'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(comment['text'], style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => onLikeChanged?.call(!isLiked),
                      child: Text("Like", style: TextStyle(color: isLiked ? Colors.pinkAccent : Colors.white54, fontSize: 12, fontWeight: isLiked ? FontWeight.bold : FontWeight.w500)),
                    ),
                    const SizedBox(width: 16),
                    const Text("Reply", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 16),
                    Text("${comment['likes']} likes", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CareerMomentViewer extends StatefulWidget {
  final String name;
  final List stories;

  const CareerMomentViewer({super.key, required this.name, required this.stories});

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
    if (widget.stories.isEmpty) {
      Future.microtask(() => Navigator.pop(context));
      return;
    }
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
      setState(() => currentIndex++);
      _pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _startTimer();
    } else {
      Navigator.pop(context);
    }
  }

  void _prevStory() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
        onTapUp: (d) => d.localPosition.dx < MediaQuery.of(context).size.width / 2 ? _prevStory() : _nextStory(),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (_, i) => Image.asset(widget.stories[i]['image'], fit: BoxFit.cover),
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(widget.stories.length, (i) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 3,
                    decoration: BoxDecoration(
                      color: i < currentIndex ? Colors.white : i == currentIndex ? Colors.white.withOpacity(progress.clamp(0, 1)) : Colors.white24,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                )),
              ),
            ),
            Positioned(top: 50, left: 16, child: Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            Positioned(top: 40, right: 10, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context))),
          ],
        ),
      ),
    );
  }
}
