import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/theme_service.dart';
import '../../bottom_navigation.dart';
import 'appearance_settings.dart';
import 'notification_settings.dart';
import 'privacy_settings.dart';
import 'account_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppTheme _selectedTheme;
  late bool _isCompactMode;
  String _activeSection = 'Appearance';
  
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _messageNotifications = true;
  bool _jobAlerts = true;

  bool _profileVisibility = true;
  bool _showActivityStatus = true;
  bool _searchEngineIndexing = true;

  @override
  void initState() {
    super.initState();
    final themeService = Provider.of<ThemeService>(context, listen: false);
    _selectedTheme = themeService.currentTheme;
    _isCompactMode = false; 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeService = Provider.of<ThemeService>(context);
    final primary = theme.primaryColor;
    final textColor = theme.textTheme.displaySmall?.color ?? theme.colorScheme.onSurface;
    final subTextColor = theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurface.withValues(alpha: 0.7);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Manage your account preferences and privacy settings",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Section Selection Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildNavCard(
                    theme: theme,
                    title: "Appearance",
                    subtitle: "Customize your visual experience",
                    icon: Icons.palette_outlined,
                    isActive: _activeSection == 'Appearance',
                    onTap: () => setState(() => _activeSection = 'Appearance'),
                  ),
                  _buildNavCard(
                    theme: theme,
                    title: "Notifications",
                    subtitle: "Manage notification preferences",
                    icon: Icons.notifications_none,
                    isActive: _activeSection == 'Notifications',
                    onTap: () => setState(() => _activeSection = 'Notifications'),
                  ),
                  _buildNavCard(
                    theme: theme,
                    title: "Privacy & Security",
                    subtitle: "Control how you share your information",
                    icon: Icons.lock_outline,
                    isActive: _activeSection == 'Privacy',
                    onTap: () => setState(() => _activeSection = 'Privacy'),
                  ),
                  _buildNavCard(
                    theme: theme,
                    title: "Account",
                    subtitle: "Manage your account settings",
                    icon: Icons.person_outline,
                    isActive: _activeSection == 'Account',
                    onTap: () => setState(() => _activeSection = 'Account'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Active Section Title and Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _activeSection,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getActiveSubtitle(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: subTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildActiveSectionContent(),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Save Changes Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  themeService.setTheme(_selectedTheme);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Changes saved successfully"),
                      backgroundColor: primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            _buildSuggestedSection(theme, subTextColor, primary),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _getActiveSubtitle() {
    switch (_activeSection) {
      case 'Appearance': return "Customize your visual experience";
      case 'Notifications': return "Manage notification preferences";
      case 'Privacy': return "Control how you share your information";
      case 'Account': return "Manage your account settings";
      default: return "";
    }
  }

  Widget _buildActiveSectionContent() {
    switch (_activeSection) {
      case 'Appearance':
        return AppearanceSettings(
          selectedTheme: _selectedTheme,
          isCompactMode: _isCompactMode,
          onThemeChanged: (val) => setState(() => _selectedTheme = val),
          onCompactModeChanged: (val) => setState(() => _isCompactMode = val),
        );
      case 'Notifications':
        return NotificationSettings(
          emailNotifications: _emailNotifications,
          pushNotifications: _pushNotifications,
          messageNotifications: _messageNotifications,
          jobAlerts: _jobAlerts,
          onEmailChanged: (val) => setState(() => _emailNotifications = val),
          onPushChanged: (val) => setState(() => _pushNotifications = val),
          onMessageChanged: (val) => setState(() => _messageNotifications = val),
          onJobAlertsChanged: (val) => setState(() => _jobAlerts = val),
        );
      case 'Privacy':
        return PrivacySettings(
          profileVisibility: _profileVisibility,
          showActivityStatus: _showActivityStatus,
          searchEngineIndexing: _searchEngineIndexing,
          onProfileVisibilityChanged: (val) => setState(() => _profileVisibility = val),
          onActivityStatusChanged: (val) => setState(() => _showActivityStatus = val),
          onIndexingChanged: (val) => setState(() => _searchEngineIndexing = val),
        );
      case 'Account':
        return const AccountSettings();
      default:
        return const SizedBox();
    }
  }

  Widget _buildNavCard({
    required ThemeData theme,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final primary = theme.primaryColor;
    final cardColor = isActive ? primary : theme.colorScheme.surface;
    final iconColor = isActive ? Colors.white : primary;
    final titleColor = isActive ? Colors.white : theme.textTheme.titleMedium?.color;
    final subtitleColor = isActive ? Colors.white.withValues(alpha: 0.7) : theme.textTheme.bodyMedium?.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isActive ? null : Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedSection(ThemeData theme, Color subTextColor, Color primary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suggested for you",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: Text("See all", style: TextStyle(color: primary))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 28, backgroundImage: AssetImage('lib/images/profile3.jpg')),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Sarah Williams", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Icon(Icons.verified, color: primary, size: 16),
                          ],
                        ),
                        Text("UX Designer", style: theme.textTheme.bodyMedium?.copyWith(color: subTextColor)),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close, color: subTextColor, size: 20)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2.3k followers", style: theme.textTheme.bodySmall?.copyWith(color: subTextColor)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      elevation: 0,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 20),
                        SizedBox(width: 6),
                        Text("Follow", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 12),
              Center(
                child: Text("View more suggestions →", style: theme.textTheme.bodyMedium?.copyWith(color: subTextColor)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
