import 'package:flutter/material.dart';
import '../edit_profile_screen.dart';
import '../bottom_navigation.dart';
import '../settings_screen.dart';

import 'profile_models.dart';
import 'profile_header.dart';
import 'profile_info_identity.dart';
import 'profile_stats.dart';
import 'profile_living_resume.dart';
import 'profile_about_section.dart';
import 'profile_experience_section.dart';
import 'profile_education_section.dart';
import 'profile_skills_section.dart';
import 'profile_posts_section.dart';
import 'profile_suggested_section.dart';
import 'profile_modals.dart';
import 'photo_action_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  String? coverImage; // Added cover image state

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

  void _handleProfilePhotoActions() {
    PhotoActionHelper.showPhotoActions(
      context: context,
      title: "Profile Photo",
      imagePath: profileImage,
      heroTag: 'profile_hero',
      onUpdate: () {
        // Placeholder for image picker logic
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile photo update coming soon")));
      },
      onDelete: () {
        setState(() => profileImage = '');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile photo deleted")));
      },
    );
  }

  void _handleCoverPhotoActions() {
    PhotoActionHelper.showPhotoActions(
      context: context,
      title: "Cover Photo",
      imagePath: coverImage,
      heroTag: 'cover_hero',
      onUpdate: () {
        // Placeholder for image picker logic
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cover photo update coming soon")));
      },
      onDelete: () {
        setState(() => coverImage = null);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cover photo deleted")));
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bg,
      endDrawer: _buildMenuDrawer(),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              profileImage: profileImage,
              coverImage: coverImage,
              onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              onCameraPressed: _handleProfilePhotoActions,
              onCoverCameraPressed: _handleCoverPhotoActions,
              backgroundColor: bg,
            ),
            const SizedBox(height: 60),
            ProfileInfoIdentity(
              name: name,
              headline: headline,
              location: location,
              openTo: openTo,
              availability: availability,
              preference: preference,
              onEditProfile: _navigateToEditProfile,
            ),
            _buildDivider(),
            const ProfileStats(),
            _buildDivider(),
            ProfileLivingResume(
              isOverviewSelected: isOverviewSelected,
              onTabChanged: (selected) => setState(() => isOverviewSelected = selected),
              onUploadResume: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const UploadResumeModal(),
                );
              },
              onDownloadPDF: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Resume download will be available soon.")),
                );
              },
            ),
            _buildDivider(),
            ProfileAboutSection(about: about),
            _buildDivider(),
            ProfileExperienceSection(
              experiences: experiences,
              onAddEditExperience: _showExperienceModal,
            ),
            _buildDivider(),
            ProfileEducationSection(
              educations: educations,
              onAddEditEducation: _showEducationModal,
            ),
            _buildDivider(),
            ProfileSkillsSection(
              skills: skills,
              onAddSkill: _showSkillsModal,
            ),
            _buildDivider(),
            ProfileLatestPostsSection(
              posts: posts,
              userName: name,
              onSeeAllPosts: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllPostsScreen(posts: posts, userName: name),
                ),
              ),
            ),
            _buildDivider(),
            ProfileSuggestedSection(suggestedUsers: suggestedUsers),
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
}
