/*import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'bottom_navigation.dart';
import 'settings_screen.dart';
import 'fullscreen_image.dart';

class Experience {
  String title;
  String company;
  String startDate;
  String endDate;
  bool currentlyWorking;
  String location;
  String description;

  Experience({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.currentlyWorking,
    required this.location,
    required this.description,
  });
}

class Education {
  String school;
  String degree;
  String fieldOfStudy;
  String startYear;
  String endYear;
  bool currentlyStudying;
  String description;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.currentlyStudying,
    required this.description,
  });
}

class UserPost {
  final String title;
  final String content;
  final String date;
  final int likes;
  final int comments;
  final int shares;
  final String category;

  UserPost({
    required this.title,
    required this.content,
    required this.date,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.category,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color bg = const Color(0xFF0B1220);
  final Color primary = const Color(0xFF6366F1);
  final Color dividerColor = Colors.white.withOpacity(0.1);

  // Profile Data
  String name = "Sally Liang";
  String headline = "Senior Financial Analyst at Johnson & Johnson";
  String jobTitle = "Senior Financial Analyst";
  String company = "Johnson & Johnson";
  String school = "Stanford University";
  String degree = "MBA in Business Administration";
  String location = "Berkeley, California, United States";
  String about = "Passionate product manager with 7+ years of experience building user-centric solutions that drive business growth. Proven track record in agile development, user research, and cross-functional team leadership. Successfully launched 15+ features that improved user engagement by 40% and increased revenue by \$2M annually.";
  
  String openTo = "Full-time";
  String availability = "Immediate";
  String preference = "Hybrid";
  String profileImage = 'lib/images/profile.jpg';

  List<Experience> experiences = [
    Experience(
      title: "Senior Product Manager",
      company: "TechCorp Inc.",
      startDate: "01-01-2021",
      endDate: "",
      currentlyWorking: true,
      location: "San Francisco, CA",
      description: "Leading product strategy and roadmap for core platform features. Managing cross-functional teams and driving product vision.",
    ),
    Experience(
      title: "Product Manager",
      company: "StartupXYZ",
      startDate: "01-01-2018",
      endDate: "31-12-2021",
      currentlyWorking: false,
      location: "San Francisco, CA",
      description: "Launched 10+ features from concept to market. Collaborated with engineering and design teams to deliver user-centric solutions.",
    ),
  ];

  List<Education> educations = [
    Education(
      school: "Stanford University",
      degree: "MBA",
      fieldOfStudy: "Business Administration",
      startYear: "2016",
      endYear: "2018",
      currentlyStudying: false,
      description: "Focus on Product Management and Entrepreneurship",
    ),
  ];

  List<String> skills = ["Product Management", "Financial Analysis", "Agile Development", "User Research", "Data Strategy"];

  final List<UserPost> posts = [
    UserPost(
      title: "Just finished a deep dive into data analysis trends for 2024.",
      content: "Just finished a deep dive into data analysis trends for 2024. The shift towards AI-driven forecasting is fascinating! #DataAnalysis #FinTech",
      date: "1d ago",
      likes: 1200,
      comments: 15,
      shares: 8,
      category: "Professional",
    ),
    UserPost(
      title: "Great session on Product Strategy today.",
      content: "Great session on Product Strategy today. Always learning! 📚",
      date: "3d ago",
      likes: 850,
      comments: 12,
      shares: 3,
      category: "Personal",
    ),
    UserPost(
      title: "Honored to be recognized as Top Contributor of the Month!",
      content: "Honored to be recognized as Top Contributor of the Month! 🏆 Thanks to my amazing team.",
      date: "1w ago",
      likes: 2100,
      comments: 45,
      shares: 12,
      category: "Professional",
    ),
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

  bool isOverviewSelected = true;

  void _showEditIdentityModal() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditIdentityModal(
        initialOpenTo: openTo,
        initialAvailability: availability,
        initialPreference: preference,
      ),
    );

    if (result != null) {
      setState(() {
        openTo = result['openTo']!;
        availability = result['availability']!;
        preference = result['preference']!;
      });
    }
  }

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          initialData: {
            'name': name,
            'headline': headline,
            'jobTitle': jobTitle,
            'company': company,
            'school': school,
            'degree': degree,
            'location': location,
            'about': about,
          },
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        name = result['name'] ?? name;
        headline = result['headline'] ?? headline;
        jobTitle = result['jobTitle'] ?? jobTitle;
        company = result['company'] ?? company;
        school = result['school'] ?? school;
        degree = result['degree'] ?? degree;
        location = result['location'] ?? location;
        about = result['about'] ?? about;
      });
    }
  }

  void _showExperienceModal({Experience? experience, int? index}) async {
    final result = await showModalBottomSheet<Experience?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExperienceModal(experience: experience),
    );

    setState(() {
      if (index != null) {
        if (result == null) {
          experiences.removeAt(index);
        } else {
          experiences[index] = result;
        }
      } else if (result != null) {
        experiences.add(result);
      }
    });
  }

  void _showEducationModal({Education? education, int? index}) async {
    final result = await showModalBottomSheet<Education?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EducationModal(education: education),
    );

    setState(() {
      if (index != null) {
        if (result == null) {
          educations.removeAt(index);
        } else {
          educations[index] = result;
        }
      } else if (result != null) {
        educations.add(result);
      }
    });
  }

  void _showSkillsModal() async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SkillsModal(initialSkills: List.from(skills)),
    );

    if (result != null) {
      setState(() {
        skills = result;
      });
    }
  }

  void _showProfileImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOptionItem(Icons.edit_outlined, "Edit Image", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Edit image options coming soon")));
          }),
          _buildOptionItem(Icons.cloud_upload_outlined, "Update", () {
            Navigator.pop(context);
            _showUpdateOptions();
          }),
          _buildOptionItem(Icons.delete_outline, "Delete", () {
            Navigator.pop(context);
            setState(() => profileImage = '');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile image deleted")));
          }, color: Colors.redAccent),
        ],
      ),
    );
  }

  void _showUpdateOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOptionItem(Icons.camera_alt_outlined, "Take Photo", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Camera access coming soon")));
          }),
          _buildOptionItem(Icons.image_outlined, "Upload from Gallery", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Gallery access coming soon")));
          }),
        ],
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.white70}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      endDrawer: _buildMenuDrawer(),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 60),
            _buildProfileInfoAndIdentity(),
            _buildDivider(),
            _buildStats(),
            _buildDivider(),
            _buildLivingResume(),
            _buildDivider(),
            _buildAboutSection(),
            _buildDivider(),
            _buildExperienceSection(),
            _buildDivider(),
            _buildEducationSection(),
            _buildDivider(),
            _buildSkillsSection(),
            _buildDivider(),
            _buildLatestPostsSection(),
            _buildDivider(),
            _buildSuggestedSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0F172A),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: profileImage.isNotEmpty ? AssetImage(profileImage) : null,
                    child: profileImage.isEmpty ? const Icon(Icons.person, color: Colors.white) : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const Text("View Profile", style: TextStyle(color: Colors.white38, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10),
            _buildDrawerItem(Icons.settings_outlined, "Settings", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            }),
            _buildDrawerItem(Icons.analytics_outlined, "Analytics", () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Analytics coming soon")));
            }),
            const Spacer(),
            const Divider(color: Colors.white10),
            _buildDrawerItem(Icons.logout, "Logout", () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logging out...")));
            }, color: Colors.redAccent),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.white70}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: dividerColor, thickness: 8, height: 32);
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFFD946EF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  if (profileImage.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenImage(imagePath: profileImage, tag: 'profile_hero')));
                  }
                },
                child: Hero(
                  tag: 'profile_hero',
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: profileImage.isNotEmpty ? AssetImage(profileImage) : null,
                      child: profileImage.isEmpty ? const Icon(Icons.person, color: Colors.white, size: 60) : null,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _showProfileImageOptions,
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFFD946EF)]),
                      shape: BoxShape.circle,
                      border: Border.all(color: bg, width: 3),
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfoAndIdentity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.verified, color: Color(0xFF6366F1), size: 24),
              const SizedBox(width: 8),
              const Text("• 2nd", style: TextStyle(color: Colors.white38, fontSize: 18)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white38, size: 28),
                onPressed: _navigateToEditProfile,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            headline,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, height: 1.3),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              Text(
                "$location  •  ",
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Contact info",
                  style: TextStyle(color: Color(0xFF6366F1), fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "500+ connections",
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 24),
          _identityRow("OPEN TO:", openTo, const Color(0xFF1E293B), const Color(0xFF60A5FA)),
          const SizedBox(height: 8),
          _identityRow("AVAILABILITY:", availability, const Color(0xFF064E3B), const Color(0xFF34D399)),
          const SizedBox(height: 8),
          _identityRow("PREFERENCE:", preference, const Color(0xFF1E293B), const Color(0xFF60A5FA)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _identityRow(String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem("500+", "Connections"),
          Container(height: 40, width: 1, color: Colors.white10),
          _statItem("1,234", "Profile Views"),
          Container(height: 40, width: 1, color: Colors.white10),
          _statItem("87", "Posts"),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 14)),
      ],
    );
  }

  Widget _buildLivingResume() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_outlined, color: Color(0xFF6366F1), size: 24),
              SizedBox(width: 12),
              Text(
                "Living Resume",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const UploadResumeModal(),
                    );
                  },
                  icon: const Icon(Icons.upload_outlined, size: 18),
                  label: const Text("Add Custom\nResume", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    foregroundColor: Colors.white70,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Resume download will be available soon.")),
                    );
                  },
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text("Download\nPDF", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildResumeTab("Overview", isOverviewSelected),
              const SizedBox(width: 24),
              _buildResumeTab("Metrics", !isOverviewSelected),
            ],
          ),
          const SizedBox(height: 24),
          if (isOverviewSelected) ...[
            _buildResumeCard("7+ years experience", "across product management & strategy"),
            const SizedBox(height: 16),
            _buildResumeCard("30+ features shipped", "driving user growth & revenue"),
            const SizedBox(height: 24),
            const Text(
              "Product leader with 7+ years of experience in high-growth tech environments. Specializing in data-driven product strategy and user-centric design.",
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResumeTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => isOverviewSelected = (label == "Overview")),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6366F1) : Colors.white38,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(height: 2, width: 40, color: const Color(0xFF6366F1)),
        ],
      ),
    );
  }

  Widget _buildResumeCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            about,
            style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Experience",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => _showExperienceModal(),
                child: const Text("Add", style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...experiences.asMap().entries.map((entry) {
            int idx = entry.key;
            Experience exp = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.business_center, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(exp.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: Colors.white38, size: 20),
                              onPressed: () => _showExperienceModal(experience: exp, index: idx),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Text(exp.company, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          "${exp.startDate} - ${exp.currentlyWorking ? 'Present' : exp.endDate} • ${exp.location}",
                          style: const TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          exp.description,
                          style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Education",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => _showEducationModal(),
                child: const Text("Add", style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...educations.asMap().entries.map((entry) {
            int idx = entry.key;
            Education edu = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.school, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(edu.school, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: Colors.white38, size: 20),
                              onPressed: () => _showEducationModal(education: edu, index: idx),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Text("${edu.degree}, ${edu.fieldOfStudy}", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          "${edu.startYear} - ${edu.currentlyStudying ? 'Present' : edu.endYear}",
                          style: const TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          edu.description,
                          style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Skills",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _showSkillsModal,
                child: const Text("Add", style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(skill, style: const TextStyle(color: Colors.white, fontSize: 14)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestPostsSection() {
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
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AllPostsScreen(posts: posts, userName: name))),
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

  Widget _buildSuggestedSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth > 600 ? 250 : 180;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text("Suggested for you", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: suggestedUsers.length,
            itemBuilder: (context, index) {
              final user = suggestedUsers[index];
              return Container(
                width: cardWidth,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
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
                    Text(user['role'], style: const TextStyle(color: Colors.white54, fontSize: 12), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
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
      ],
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

class EditIdentityModal extends StatefulWidget {
  final String initialOpenTo;
  final String initialAvailability;
  final String initialPreference;

  const EditIdentityModal({
    super.key,
    required this.initialOpenTo,
    required this.initialAvailability,
    required this.initialPreference,
  });

  @override
  State<EditIdentityModal> createState() => _EditIdentityModalState();
}

class _EditIdentityModalState extends State<EditIdentityModal> {
  late String openTo;
  late String availability;
  late String preference;

  @override
  void initState() {
    super.initState();
    openTo = widget.initialOpenTo;
    availability = widget.initialAvailability;
    preference = widget.initialPreference;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Edit Professional Identity",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white38),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection("Open to", ["Full-time", "Freelance", "Consulting", "Mentorship"], openTo, (val) => setState(() => openTo = val)),
          const SizedBox(height: 32),
          _buildSection("Availability", ["Immediate", "30 Days", "Casual Networking"], availability, (val) => setState(() => availability = val), activeColor: const Color(0xFF10B981)),
          const SizedBox(height: 32),
          _buildSection("Work Preference", ["Remote", "Hybrid", "Onsite"], preference, (val) => setState(() => preference = val)),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'openTo': openTo,
              'availability': availability,
              'preference': preference,
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white38, fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> options, String current, Function(String) onSelect, {Color activeColor = const Color(0xFF4F46E5)}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((opt) {
            bool isSelected = opt == current;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? activeColor : Colors.white.withOpacity(0.05)),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white38,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class UploadResumeModal extends StatelessWidget {
  const UploadResumeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              const Text(
                "Upload Custom Resume",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white38),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Upload a PDF or DOCX file to attach to your profile.",
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.upload_outlined, color: Color(0xFF6366F1), size: 48),
                SizedBox(height: 16),
                Text("Click to upload", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("PDF or DOCX (Max 5MB)", style: TextStyle(color: Colors.white38, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white38, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class ExperienceModal extends StatefulWidget {
  final Experience? experience;

  const ExperienceModal({super.key, this.experience});

  @override
  State<ExperienceModal> createState() => _ExperienceModalState();
}

class _ExperienceModalState extends State<ExperienceModal> {
  late TextEditingController _titleController;
  late TextEditingController _companyController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late bool _currentlyWorking;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.experience?.title ?? "");
    _companyController = TextEditingController(text: widget.experience?.company ?? "");
    _startDateController = TextEditingController(text: widget.experience?.startDate ?? "dd-mm-yyyy");
    _endDateController = TextEditingController(text: widget.experience?.endDate ?? "dd-mm-yyyy");
    _locationController = TextEditingController(text: widget.experience?.location ?? "");
    _descriptionController = TextEditingController(text: widget.experience?.description ?? "");
    _currentlyWorking = widget.experience?.currentlyWorking ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.experience != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text(
                  isEdit ? "Edit Experience" : "Add Experience",
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white38),
                  onPressed: () => Navigator.pop(context, widget.experience),
                ),
              ],
            ),
            Center(
              child: Text(
                isEdit ? "Edit the details of your experience." : "Add a new experience to your profile.",
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel("Title"),
            _buildTextField(_titleController, "Ex: Product Manager"),
            _buildLabel("Company"),
            _buildTextField(_companyController, "Ex: Microsoft"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Start Date"),
                      _buildDateField(_startDateController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("End Date"),
                      _buildDateField(_endDateController, enabled: !_currentlyWorking),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _currentlyWorking,
                  onChanged: (val) => setState(() => _currentlyWorking = val ?? false),
                  side: const BorderSide(color: Colors.white38),
                  activeColor: const Color(0xFF6366F1),
                ),
                const Text("I currently work here", style: TextStyle(color: Colors.white)),
              ],
            ),
            _buildLabel("Location"),
            _buildTextField(_locationController, "Ex: London, UK"),
            _buildLabel("Description"),
            _buildTextField(_descriptionController, "Describe your responsibilities...", maxLines: 4),
            const SizedBox(height: 32),
            Row(
              children: [
                if (isEdit)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, widget.experience),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.white10),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          Experience(
                            title: _titleController.text,
                            company: _companyController.text,
                            startDate: _startDateController.text,
                            endDate: _endDateController.text,
                            currentlyWorking: _currentlyWorking,
                            location: _locationController.text,
                            description: _descriptionController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(color: enabled ? Colors.white : Colors.white24),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.white38, size: 18),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      readOnly: true,
      onTap: () async {
        if (!enabled) return;
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
        }
      },
    );
  }
}

class EducationModal extends StatefulWidget {
  final Education? education;

  const EducationModal({super.key, this.education});

  @override
  State<EducationModal> createState() => _EducationModalState();
}

class _EducationModalState extends State<EducationModal> {
  late TextEditingController _schoolController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldController;
  late TextEditingController _startYearController;
  late TextEditingController _endYearController;
  late TextEditingController _descriptionController;
  late bool _currentlyStudying;

  @override
  void initState() {
    super.initState();
    _schoolController = TextEditingController(text: widget.education?.school ?? "");
    _degreeController = TextEditingController(text: widget.education?.degree ?? "");
    _fieldController = TextEditingController(text: widget.education?.fieldOfStudy ?? "");
    _startYearController = TextEditingController(text: widget.education?.startYear ?? "Select year...");
    _endYearController = TextEditingController(text: widget.education?.endYear ?? "Select year...");
    _descriptionController = TextEditingController(text: widget.education?.description ?? "");
    _currentlyStudying = widget.education?.currentlyStudying ?? false;
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.education != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text(
                  isEdit ? "Edit Education" : "Add Education",
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white38),
                  onPressed: () => Navigator.pop(context, widget.education),
                ),
              ],
            ),
            Center(
              child: Text(
                isEdit ? "Edit the details of your education." : "Add a new education to your profile.",
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel("School"),
            _buildTextField(_schoolController, "Ex: Stanford University"),
            _buildLabel("Degree"),
            _buildTextField(_degreeController, "Ex: MBA"),
            _buildLabel("Field of Study"),
            _buildTextField(_fieldController, "Ex: Business Administration"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Start Year"),
                      _buildYearPicker(_startYearController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("End Year"),
                      _buildYearPicker(_endYearController, enabled: !_currentlyStudying),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _currentlyStudying,
                  onChanged: (val) => setState(() => _currentlyStudying = val ?? false),
                  side: const BorderSide(color: Colors.white38),
                  activeColor: const Color(0xFF6366F1),
                ),
                const Text("I'm still studying", style: TextStyle(color: Colors.white)),
              ],
            ),
            _buildLabel("Description"),
            _buildTextField(_descriptionController, "Describe your activities, societies, etc.", maxLines: 4),
            const SizedBox(height: 32),
            Row(
              children: [
                if (isEdit)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, widget.education),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.white10),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          Education(
                            school: _schoolController.text,
                            degree: _degreeController.text,
                            fieldOfStudy: _fieldController.text,
                            startYear: _startYearController.text,
                            endYear: _endYearController.text,
                            currentlyStudying: _currentlyStudying,
                            description: _descriptionController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildYearPicker(TextEditingController controller, {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0F172A),
              title: const Text("Select Year", style: TextStyle(color: Colors.white)),
              content: SizedBox(
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                  selectedDate: DateTime.now(),
                  onChanged: (DateTime dateTime) {
                    controller.text = dateTime.year.toString();
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      } : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text,
              style: TextStyle(color: enabled ? Colors.white : Colors.white24),
            ),
            const Icon(Icons.unfold_more, color: Colors.white38, size: 20),
          ],
        ),
      ),
    );
  }
}

class SkillsModal extends StatefulWidget {
  final List<String> initialSkills;

  const SkillsModal({super.key, required this.initialSkills});

  @override
  State<SkillsModal> createState() => _SkillsModalState();
}

class _SkillsModalState extends State<SkillsModal> {
  late List<String> _currentSkills;
  final TextEditingController _skillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentSkills = List.from(widget.initialSkills);
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_skillController.text.trim().isNotEmpty) {
      setState(() {
        _currentSkills.add(_skillController.text.trim());
        _skillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              const Text(
                "Manage Skills",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white38),
                onPressed: () => Navigator.pop(context, widget.initialSkills),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _skillController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Add a new skill...",
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: const Color(0xFF1E293B),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _addSkill(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _addSkill,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _currentSkills.map((skill) => Container(
              padding: const EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(skill, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white38, size: 16),
                    onPressed: () => setState(() => _currentSkills.remove(skill)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )).toList(),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _currentSkills),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}*/
