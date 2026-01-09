import 'package:flutter/material.dart';
import '../../models/public_user.dart';
import '../../services/public_user_service.dart';
import '../feed/chat_screen.dart';

class PublicProfileScreen extends StatefulWidget {
  final String userId;

  const PublicProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  PublicUser? _user;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await PublicUserService.getUserProfile(widget.userId);
      if (!mounted) return;

      setState(() {
        _user = data;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = "Failed to load profile";
        _loading = false;
      });
    }
  }

  // ===================== BUILD =====================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
      );
    }

    if (_user == null) {
      return const Center(child: Text("Profile not available"));
    }

    return ListView(
      children: [
        _header(theme),
        _stats(theme),
        _divider(theme),
        _about(theme),
        _divider(theme),
        _experience(theme),
        _divider(theme),
        _skills(theme),
        _divider(theme),
        _education(theme),
        const SizedBox(height: 60),
      ],
    );
  }

  // ===================== HEADER =====================

  Widget _header(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColorDark,
          ],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: _user!.avatarUrl != null
                ? NetworkImage(_user!.avatarUrl!)
                : const AssetImage("lib/images/profile.png") as ImageProvider,
          ),
          const SizedBox(height: 12),

          Text(
            _user!.fullName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          if (_user!.headline != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _user!.headline!,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ),

          if (_user!.location != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                _user!.location!,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.white70),
              ),
            ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _openChat,
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text("Message"),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _followUser,
                icon: const Icon(Icons.person_add_alt),
                label: const Text("Follow"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===================== STATS =====================

  Widget _stats(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _StatItem(label: "Connections", value: "500+"),
          _StatItem(label: "Profile Views", value: "--"),
          _StatItem(label: "Posts", value: "0"),
        ],
      ),
    );
  }

  // ===================== ABOUT =====================

  Widget _about(ThemeData theme) {
    return _section(
      title: "About",
      child: Text(
        _user!.about ?? "No information provided",
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  // ===================== EXPERIENCE =====================

  Widget _experience(ThemeData theme) {
    if (_user!.experiences.isEmpty) return const SizedBox();

    return _section(
      title: "Experience",
      child: Column(
        children: _user!.experiences.map((e) {
          return ListTile(
            leading: const Icon(Icons.work_outline),
            title: Text(e.title),
            subtitle: Text(e.company),
            trailing: e.isCurrent
                ? const Chip(label: Text("Current"))
                : null,
          );
        }).toList(),
      ),
    );
  }

  // ===================== SKILLS =====================

  Widget _skills(ThemeData theme) {
    if (_user!.skills.isEmpty) return const SizedBox();

    return _section(
      title: "Skills",
      child: Wrap(
        spacing: 8,
        children:
        _user!.skills.map((s) => Chip(label: Text(s))).toList(),
      ),
    );
  }

  // ===================== EDUCATION =====================

  Widget _education(ThemeData theme) {
    if (_user!.educations.isEmpty) return const SizedBox();

    return _section(
      title: "Education",
      child: Column(
        children: _user!.educations.map((e) {
          return ListTile(
            leading: const Icon(Icons.school_outlined),
            title: Text(e.school),
            subtitle: Text(e.degree ?? ''),

          );
        }).toList(),
      ),
    );
  }

  // ===================== HELPERS =====================

  Widget _divider(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Divider(color: theme.dividerColor, height: 48),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // ===================== ACTIONS =====================

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatScreen()),
    );
  }

  void _followUser() {
    // TODO: Call follow API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Followed")),
    );
  }
}

// ===================== STAT ITEM =====================

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
