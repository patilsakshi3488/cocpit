import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'notification_screen.dart';
import '../bottom_navigation.dart';
import 'create_career_moment_screen.dart';
import 'career_moment_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTop = false;
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

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
          'text': 'Excited to share a sneak peek of our latest product feature!',
          'time': '6h ago'
        },
      ],
    },
    {
      'name': 'James Wilson',
      'isMine': false,
      'image': 'lib/images/story4.png',
      'profile': 'lib/images/profile3.jpg',
      'stories': [
        {
          'image': 'lib/images/story4.png',
          'text': 'Sharing some insights from our latest data analysis project.',
          'time': '8h ago'
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
      'comments': [
        {
          'name': 'Alex Johnson',
          'time': '2h',
          'text': 'This looks amazing! Can\'t wait to see it in action.',
          'likes': 15,
          'isLiked': false,
        },
        {
          'name': 'Maria Garcia',
          'time': '1h',
          'text': 'Great work, Maria! The component library is so clean.',
          'likes': 8,
          'isLiked': false,
        }
      ],
    },
    {
      'id': '2',
      'name': 'Sally Liang',
      'title': 'Senior Financial Analyst',
      'time': '1d ago',
      'text': "Just finished a deep dive into data analysis trends for 2024. The shift towards AI-driven forecasting is fascinating!",
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

  List<Map<String, dynamic>> get _allPeople {
    return [
      {'name': 'Sarah Chen', 'role': 'UX Designer at Design Studio', 'profile': 'lib/images/profile3.jpg', 'mutual': '5 mutual connections'},
      {'name': 'Michael Chen', 'role': 'Recruiter', 'profile': 'lib/images/profile2.jpg', 'mutual': '12 mutual connections'},
      {'name': 'Emily Rodriguez', 'role': 'Hiring Manager', 'profile': 'lib/images/profile4.jpg', 'mutual': '3 mutual connections'},
      {'name': 'Mike Torres', 'role': 'Product Manager', 'profile': 'lib/images/profile2.jpg', 'mutual': '8 mutual connections'},
      {'name': 'James Wilson', 'role': 'Software Engineer', 'profile': 'lib/images/profile3.jpg', 'mutual': '2 mutual connections'},
    ];
  }

  void _updateOverlay(String query) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    if (query.isEmpty) return;

    final results = _allPeople.where((p) => p['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();

    if (results.isEmpty) return;

    _overlayEntry = _createOverlayEntry(results);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(List<Map<String, dynamic>> results) {
    final theme = Theme.of(context);
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50),
          child: Material(
            elevation: 8,
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "PEOPLE",
                      style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                  ...results.take(3).map((person) => InkWell(
                    onTap: () {
                      _searchController.clear();
                      _updateOverlay("");
                      FocusScope.of(context).unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(person['profile']),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(person['name'], style: theme.textTheme.titleSmall),
                                Text(person['role'], style: theme.textTheme.bodySmall),
                                Text(person['mutual'], style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(theme),
            Expanded(
              child: ListView(
                children: [
                  _storiesHeader(theme),
                  _careerMomentsBar(theme),
                  const SizedBox(height: 20),
                  _topRecentToggle(theme),
                  Divider(color: theme.dividerColor, height: 1),
                  ..._posts.map((post) {
                    if (post['type'] == 'suggested') {
                      return _suggestedForYouSection(theme);
                    }
                    return _postView(post, theme);
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

  Widget _topBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.logo_dev, color: theme.primaryColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.search, color: theme.textTheme.bodySmall?.color, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _updateOverlay,
                        style: theme.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.notifications_none, color: theme.iconTheme.color),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: theme.iconTheme.color),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
        ],
      ),
    );
  }

  Widget _storiesHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Stories", style: theme.textTheme.titleLarge),
          Text("View All", style: TextStyle(color: theme.primaryColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _careerMomentsBar(ThemeData theme) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth > 600 ? 150 : 120;

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
                Navigator.push(context, MaterialPageRoute(builder: (_) => CareerMomentViewer(users: careerMoments, initialUserIndex: index)));
              }
            },
            child: Container(
              width: itemWidth,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: !m['isMine'] ? DecorationImage(image: AssetImage(m['image']), fit: BoxFit.cover) : null,
                color: m['isMine'] ? theme.primaryColor : theme.cardColor,
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
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.add, color: Colors.white, size: 30),
                          ),
                          const SizedBox(height: 12),
                          const Text("Your Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                  if (!m['isMine'])
                    Positioned(
                      bottom: 8, left: 0, right: 0,
                      child: Column(
                        children: [
                          CircleAvatar(radius: 18, backgroundColor: theme.primaryColor, child: CircleAvatar(radius: 16, backgroundImage: AssetImage(m['profile']))),
                          const SizedBox(height: 4),
                          Text(m['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topRecentToggle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _togglePill("Top", showTop, theme, () => setState(() => showTop = true)),
          const SizedBox(width: 12),
          _togglePill("Recent", !showTop, theme, () => setState(() => showTop = false)),
        ],
      ),
    );
  }

  Widget _togglePill(String text, bool selected, ThemeData theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(color: selected ? theme.primaryColor : Colors.transparent, borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: TextStyle(color: selected ? Colors.white : theme.textTheme.bodyMedium?.color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _suggestedForYouSection(ThemeData theme) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth > 600 ? 250 : 180;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text("Suggested for you", style: theme.textTheme.titleLarge),
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
                width: cardWidth,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(radius: 40, backgroundImage: AssetImage(user['profile'])),
                        if (user['isVerified'])
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: theme.primaryColor,
                              child: const Icon(Icons.check, color: Colors.white, size: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(user['name'], style: theme.textTheme.titleSmall, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(user['role'], style: theme.textTheme.bodySmall, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text("${user['followers']} followers", style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
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
        Divider(color: theme.dividerColor, height: 8, thickness: 8),
      ],
    );
  }

  Widget _postView(Map<String, dynamic> post, ThemeData theme) {
    String likesText = post['likes'] >= 1000 ? "${(post['likes'] / 1000).toStringAsFixed(1)}k" : "${post['likes']}";
    bool isLiked = post['isLiked'] ?? false;
    bool isPrivate = post['isPrivate'] ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(radius: 24, backgroundImage: AssetImage(post['profile'] ?? 'lib/images/profile.png')),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post['name'], style: theme.textTheme.titleMedium),
                      Text(post['title'], style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          Text(post['time'], style: theme.textTheme.bodySmall?.copyWith(fontSize: 12)),
                          if (isPrivate) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.visibility_off_outlined, color: theme.textTheme.bodySmall?.color, size: 12),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: theme.copyWith(
                    popupMenuTheme: PopupMenuThemeData(
                      color: theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.more_horiz, color: theme.textTheme.bodySmall?.color),
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
                            Icon(post['isPrivate'] == true ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: theme.iconTheme.color, size: 20),
                            const SizedBox(width: 12),
                            Text(post['isPrivate'] == true ? "Make Public" : "Make Private", style: theme.textTheme.bodyLarge),
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
            child: Text(post['text'], style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
          const SizedBox(height: 16),
          if (post['image'] != null) Image.asset(post['image'], width: double.infinity, fit: BoxFit.cover),
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
                        Text("$likesText likes", style: theme.textTheme.bodySmall),
                      ],
                    ),
                    Text("${post['comments_count']} comments • ${post['shares']} shares", style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(color: theme.dividerColor, height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _actionBtn(
                      isLiked ? Icons.favorite : Icons.favorite_border, 
                      "Like", 
                      isLiked ? Colors.pinkAccent : theme.textTheme.bodySmall?.color ?? Colors.grey,
                      () {
                        setState(() {
                          post['isLiked'] = !isLiked;
                          post['likes'] += isLiked ? -1 : 1;
                        });
                      }
                    ),
                    _actionBtn(Icons.chat_bubble_outline, "Comment", theme.textTheme.bodySmall?.color ?? Colors.grey, () => _showCommentSheet(context, post, theme)),
                    _actionBtn(Icons.share_outlined, "Share", theme.textTheme.bodySmall?.color ?? Colors.grey, () => _showShareSheet(context, theme)),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: theme.dividerColor, height: 8, thickness: 8),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String text, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap, 
      child: Row(
        children: [
          Icon(icon, color: color, size: 20), 
          const SizedBox(width: 6), 
          Text(text, style: TextStyle(color: color, fontSize: 13))
        ]
      )
    );
  }

  void _showCommentSheet(BuildContext context, Map<String, dynamic> post, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CommentSheet(post: post, theme: theme),
    );
  }

  void _showShareSheet(BuildContext context, ThemeData theme) {
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
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Share to",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: theme.dividerColor, height: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: theme.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: theme.textTheme.bodySmall,
                          icon: Icon(Icons.search, color: theme.textTheme.bodySmall?.color, size: 20),
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
                              color: isSelected ? theme.primaryColor.withValues(alpha: 0.05) : Colors.transparent,
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
                                      Text(user['name'], style: theme.textTheme.titleSmall),
                                      Text(user['role'], style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: isSelected ? theme.primaryColor : theme.dividerColor, width: 2),
                                    color: isSelected ? theme.primaryColor : Colors.transparent,
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
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: theme.dividerColor)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            style: theme.textTheme.bodyLarge,
                            decoration: InputDecoration(
                              hintText: "Write a message...",
                              hintStyle: theme.textTheme.bodySmall,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text("Shared successfully"),
                                backgroundColor: theme.primaryColor,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
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
}

class _CommentSheet extends StatefulWidget {
  final Map<String, dynamic> post;
  final ThemeData theme;
  const _CommentSheet({required this.post, required this.theme});

  @override
  State<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<_CommentSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(color: widget.theme.colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: widget.theme.dividerColor, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Text("Comments", style: widget.theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Divider(color: widget.theme.dividerColor, height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.post['comments'].length,
                itemBuilder: (context, index) => _CommentItem(comment: widget.post['comments'][index], theme: widget.theme),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: widget.theme.dividerColor))),
              child: Row(
                children: [
                  const CircleAvatar(radius: 18, backgroundImage: AssetImage('lib/images/profile.png')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: widget.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(24)),
                      child: TextField(
                        controller: _controller,
                        style: widget.theme.textTheme.bodyLarge,
                        decoration: InputDecoration(hintText: "Add a comment...", hintStyle: widget.theme.textTheme.bodySmall, border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          widget.post['comments'].insert(0, {'name': 'You', 'time': 'Just now', 'text': _controller.text, 'likes': 0, 'isLiked': false});
                          widget.post['comments_count']++;
                        });
                        _controller.clear();
                      }
                    },
                    child: Text("Post", style: TextStyle(color: widget.theme.primaryColor, fontWeight: FontWeight.bold)),
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

class _CommentItem extends StatefulWidget {
  final Map<String, dynamic> comment;
  final ThemeData theme;
  const _CommentItem({required this.comment, required this.theme});

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.comment['isLiked'] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 18, backgroundImage: AssetImage('lib/images/profile.png')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: widget.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.comment['name'], style: widget.theme.textTheme.titleSmall),
                          Text(widget.comment['time'], style: widget.theme.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(widget.comment['text'], style: widget.theme.textTheme.bodyMedium, ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        widget.comment['isLiked'] = !isLiked;
                        widget.comment['likes'] += isLiked ? -1 : 1;
                      }),
                      child: Text("Like", style: TextStyle(color: isLiked ? Colors.pinkAccent : widget.theme.textTheme.bodySmall?.color, fontSize: 12, fontWeight: isLiked ? FontWeight.bold : FontWeight.normal)),
                    ),
                    const SizedBox(width: 16),
                    Text("Reply", style: widget.theme.textTheme.bodySmall?.copyWith(fontSize: 12)),
                    const SizedBox(width: 16),
                    if (widget.comment['likes'] > 0)
                      Text("${widget.comment['likes']} likes", style: widget.theme.textTheme.bodySmall?.copyWith(fontSize: 12)),
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
