import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color bg = const Color(0xFF0B1220);
  final Color cardBg = const Color(0xFF0F172A);
  final Color primary = const Color(0xFF6366F1);
  
  String selectedTheme = 'Dark Mode';
  bool isCompactMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Settings", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Manage your account preferences and privacy settings", 
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingCard(
              icon: Icons.palette_outlined,
              title: "Appearance",
              subtitle: "Customize your visual experience",
              color: primary,
              isHighlighted: true,
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              icon: Icons.notifications_none,
              title: "Notifications",
              subtitle: "Manage notification preferences",
              color: cardBg,
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              icon: Icons.lock_outline,
              title: "Privacy & Security",
              subtitle: "Control how you share your information",
              color: cardBg,
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              icon: Icons.person_outline,
              title: "Account",
              subtitle: "Manage your account settings",
              color: cardBg,
            ),
            
            const SizedBox(height: 32),
            const Text("Appearance", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Customize your visual experience", style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14)),
            
            const SizedBox(height: 24),
            _buildThemeSection(),
            
            const SizedBox(height: 24),
            _buildDisplaySection(),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            
            const SizedBox(height: 32),
            _buildSuggestedSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({required IconData icon, required String title, required String subtitle, required Color color, bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: isHighlighted ? 0.7 : 0.5), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Theme", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildThemeOption(Icons.bolt, "Navy Mode", "The classic experience"),
          _buildThemeOption(Icons.light_mode_outlined, "Light Mode", "Clean and bright interface"),
          _buildThemeOption(Icons.dark_mode_outlined, "Dark Mode", "Easy on the eyes, perfect for night"),
          _buildThemeOption(Icons.computer, "System", "Follow your device's setting"),
        ],
      ),
    );
  }

  Widget _buildThemeOption(IconData icon, String title, String subtitle) {
    bool isSelected = selectedTheme == title;
    return GestureDetector(
      onTap: () => setState(() => selectedTheme = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? primary : Colors.white.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? primary : Colors.white54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? primary : Colors.white38, width: 2),
              ),
              child: isSelected ? Center(child: Container(width: 10, height: 10, decoration: BoxDecoration(color: primary, shape: BoxShape.circle))) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Display", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Compact mode", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Show more content in less space", style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)),
                ],
              ),
              Switch(
                value: isCompactMode,
                onChanged: (val) => setState(() => isCompactMode = val),
                activeColor: primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Suggested for you", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text("See all", style: TextStyle(color: primary))),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 24, backgroundImage: AssetImage('lib/images/profile3.jpg')),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Sarah Williams", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(width: 4),
                            Icon(Icons.verified, color: Color(0xFF6366F1), size: 14),
                          ],
                        ),
                        Text("UX Designer", style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close, color: Colors.white38, size: 18)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("2.3k followers", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              const Divider(color: Colors.white10),
              const SizedBox(height: 8),
              Center(
                child: Text("View more suggestions →", style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
