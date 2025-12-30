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
  late String _selectedTheme;
  late bool _isCompactMode;
  
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
    _selectedTheme = _themeToString(themeService.currentTheme);
    _isCompactMode = false; 
  }

  String _themeToString(AppTheme theme) {
    switch (theme) {
      case AppTheme.light: return 'LIGHT MODE';
      case AppTheme.dark: return 'DARK MODE';
      case AppTheme.navy: return 'NAVY MODE';
      case AppTheme.system: return 'SYSTEM';
    }
  }

  AppTheme _stringToTheme(String themeStr) {
    switch (themeStr.toUpperCase()) {
      case 'LIGHT MODE': return AppTheme.light;
      case 'DARK MODE': return AppTheme.dark;
      case 'NAVY MODE': return AppTheme.navy;
      case 'SYSTEM':
      default: return AppTheme.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primary = Color(0xFF6366F1);
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.4);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: textColor, 
            fontSize: 24, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "Manage your account preferences and privacy settings",
                style: TextStyle(color: subTextColor, fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSectionCard(
              child: AppearanceSettings(
                selectedTheme: _selectedTheme,
                isCompactMode: _isCompactMode,
                onThemeChanged: (val) => setState(() => _selectedTheme = val),
                onCompactModeChanged: (val) => setState(() => _isCompactMode = val),
              ),
              isDark: isDark,
            ),
            
            _buildSectionCard(
              child: NotificationSettings(
                emailNotifications: _emailNotifications,
                pushNotifications: _pushNotifications,
                messageNotifications: _messageNotifications,
                jobAlerts: _jobAlerts,
                onEmailChanged: (val) => setState(() => _emailNotifications = val),
                onPushChanged: (val) => setState(() => _pushNotifications = val),
                onMessageChanged: (val) => setState(() => _messageNotifications = val),
                onJobAlertsChanged: (val) => setState(() => _jobAlerts = val),
              ),
              isDark: isDark,
            ),
            
            _buildSectionCard(
              child: PrivacySettings(
                profileVisibility: _profileVisibility,
                showActivityStatus: _showActivityStatus,
                searchEngineIndexing: _searchEngineIndexing,
                onProfileVisibilityChanged: (val) => setState(() => _profileVisibility = val),
                onActivityStatusChanged: (val) => setState(() => _showActivityStatus = val),
                onIndexingChanged: (val) => setState(() => _searchEngineIndexing = val),
              ),
              isDark: isDark,
            ),
            
            _buildSectionCard(
              child: const AccountSettings(),
              isDark: isDark,
            ),
            
            const SizedBox(height: 32),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  themeService.setTheme(_stringToTheme(_selectedTheme));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Changes saved successfully"),
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
            _buildSuggestedSection(textColor, subTextColor, primary, isDark),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937).withValues(alpha: 0.5) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildSuggestedSection(Color textColor, Color subTextColor, Color primary, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suggested for you",
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: Text("See all", style: TextStyle(color: primary))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937).withValues(alpha: 0.5) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 24, backgroundImage: AssetImage('lib/images/profile3.jpg')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Sarah Williams", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Icon(Icons.verified, color: primary, size: 14),
                          ],
                        ),
                        Text("UX Designer", style: TextStyle(color: subTextColor, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close, color: subTextColor, size: 18)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2.3k followers", style: TextStyle(color: subTextColor, fontSize: 12)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 0,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text("Follow", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: subTextColor.withValues(alpha: 0.1)),
              const SizedBox(height: 8),
              Center(
                child: Text("View more suggestions →", style: TextStyle(color: subTextColor, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
