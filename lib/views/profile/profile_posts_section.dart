import 'package:flutter/material.dart';
import 'profile_models.dart';
import '../bottom_navigation.dart';

class ProfileLatestPostsSection extends StatelessWidget {
  final List<UserPost> posts;
  final String userName;
  final VoidCallback onSeeAllPosts;

  const ProfileLatestPostsSection({
    super.key,
    required this.posts,
    required this.userName,
    required this.onSeeAllPosts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Latest Posts",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: onSeeAllPosts,
                child: const Text("See all posts", style: TextStyle(color: Color(0xFF6366F1))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.content,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        post.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AllPostsScreen extends StatefulWidget {
  final List<UserPost> posts;
  final String userName;

  const AllPostsScreen({super.key, required this.posts, required this.userName});

  @override
  State<AllPostsScreen> createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    final filteredPosts = selectedFilter == "All" 
        ? widget.posts 
        : widget.posts.where((p) => p.category == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("All Posts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _filterChip("All"),
                const SizedBox(width: 12),
                _filterChip("Professional"),
                const SizedBox(width: 12),
                _filterChip("Personal"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return _buildPostCard(post);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPostCard(UserPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF0F172A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('lib/images/profile.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Text("Senior Financial Analyst at Johnson & Johnson", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  Text(post.date, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(post.content, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
          const SizedBox(height: 24),
          Row(
            children: [
              Text("${(post.likes/1000).toStringAsFixed(1)}k likes", style: const TextStyle(color: Colors.white38, fontSize: 13)),
              const Spacer(),
              Text("${post.comments} comments  •  ${post.shares} shares", style: const TextStyle(color: Colors.white38, fontSize: 13)),
            ],
          ),
          const Divider(color: Colors.white10, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionItem(Icons.thumb_up_outlined, "Like"),
              _actionItem(Icons.chat_bubble_outline, "Comment"),
              _actionItem(Icons.share_outlined, "Share"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 20),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white38, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
