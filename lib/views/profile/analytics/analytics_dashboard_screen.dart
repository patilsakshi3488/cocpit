import 'package:flutter/material.dart';
import '../../bottom_navigation.dart';
import 'analytics_stat_card.dart';
import 'analytics_time_range.dart';
import 'trajectory_section.dart';
import 'engagement_section.dart';
import 'funnel_section.dart';
import 'demographics_section.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  String selectedRange = "LAST 30 DAYS";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.primaryColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.4);
    final dividerColor = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "ANALYTICS",
          style: TextStyle(
            color: textColor, 
            fontSize: 40, 
            fontWeight: FontWeight.w900, 
            letterSpacing: -2,
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "TRACK YOUR PROFESSIONAL GROWTH AND REACH.",
                style: TextStyle(color: subTextColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 48),
            
            AnalyticsTimeRange(
              selectedRange: selectedRange,
              onRangeSelected: (range) => setState(() => selectedRange = range),
            ),
            
            const SizedBox(height: 48),
            
            AnalyticsStatCard(
              icon: Icons.visibility_outlined,
              label: "PROFILE VIEWS",
              value: "4,340",
              trend: "+12.5%",
              isPositive: true,
            ),
            _buildDivider(dividerColor),
            AnalyticsStatCard(
              icon: Icons.search,
              label: "SEARCH APPEARANCES",
              value: "1,575",
              trend: "+5.2%",
              isPositive: true,
            ),
            _buildDivider(dividerColor),
            AnalyticsStatCard(
              icon: Icons.person_add_outlined,
              label: "CONNECTION REQUESTS",
              value: "297.5",
              trend: "-2.1%",
              isPositive: false,
            ),
            _buildDivider(dividerColor),
            AnalyticsStatCard(
              icon: Icons.chat_bubble_outline,
              label: "DIRECT MESSAGES",
              value: "84",
              trend: "+18.0%",
              isPositive: true,
            ),
            
            _buildHeavyDivider(dividerColor),
            
            _buildSectionHeader("CAREER TRAJECTORY", "COMPARE YOUR SKILLS AGAINST YOUR TARGET ROLE.", textColor, subTextColor),
            const SizedBox(height: 32),
            TrajectorySection(primary: primary, textColor: textColor),
            
            _buildHeavyDivider(dividerColor),
            
            _buildSectionHeader("ENGAGEMENT", "PROFILE INTERACTIONS OVER TIME.", textColor, subTextColor),
            const SizedBox(height: 32),
            EngagementSection(primary: primary, textColor: textColor),
            
            _buildHeavyDivider(dividerColor),
            
            _buildSectionHeader("RECRUITER FUNNEL", "FROM SEARCH TO CONVERSATION.", textColor, subTextColor),
            const SizedBox(height: 32),
            FunnelSection(textColor: textColor, subTextColor: subTextColor, primary: primary),
            
            _buildHeavyDivider(dividerColor),
            
            _buildSectionHeader("DEMOGRAPHICS", "WHO IS VIEWING YOUR PROFILE.", textColor, subTextColor),
            const SizedBox(height: 32),
            DemographicsSection(primary: primary, textColor: textColor),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, Color textColor, Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(color: subTextColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildDivider(Color dividerColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Divider(color: dividerColor, thickness: 1),
    );
  }

  Widget _buildHeavyDivider(Color dividerColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Divider(color: dividerColor, thickness: 8),
    );
  }
}
