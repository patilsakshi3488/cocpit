import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  String selectedRange = "Last 30 Days";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final cardBg = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Analytics Dashboard", style: TextStyle(color: textColor)),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Track your professional growth and reach",
              style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Time Range Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _rangePill("Last 7 Days", cardBg, primary),
                  _rangePill("Last 30 Days", cardBg, primary),
                  _rangePill("Last 90 Days", cardBg, primary),
                  _rangePill("All Time", cardBg, primary),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Section
            _buildStatCard(
              icon: Icons.visibility_outlined,
              label: "Profile Views",
              value: "4,340",
              trend: "+12.5%",
              isPositive: true,
              textColor: textColor,
              cardBg: cardBg,
            ),
            _buildStatCard(
              icon: Icons.search,
              label: "Search Appearances",
              value: "1,575",
              trend: "+5.2%",
              isPositive: true,
              textColor: textColor,
              cardBg: cardBg,
            ),
            _buildStatCard(
              icon: Icons.person_add_outlined,
              label: "Connection Requests",
              value: "297.5",
              trend: "-2.1%",
              isPositive: false,
              textColor: textColor,
              cardBg: cardBg,
            ),
            _buildStatCard(
              icon: Icons.chat_bubble_outline,
              label: "Direct Messages",
              value: "84",
              trend: "+18.0%",
              isPositive: true,
              textColor: textColor,
              cardBg: cardBg,
            ),

            const SizedBox(height: 24),

            // UI Sections matching App Theme
            _buildTrajectoryCard(primary, textColor, cardBg, isDark),
            const SizedBox(height: 24),
            _buildEngagementCard(primary, textColor, cardBg),
            const SizedBox(height: 24),
            _buildFunnelCard(primary, textColor, cardBg),
            const SizedBox(height: 24),
            _buildDemographicsCard(primary, textColor, cardBg),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _rangePill(String label, Color cardBg, Color primary) {
    bool isSelected = selectedRange == label;
    return GestureDetector(
      onTap: () => setState(() => selectedRange = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primary : cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String trend,
    required bool isPositive,
    required Color textColor,
    required Color cardBg,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: textColor.withValues(alpha: 0.5), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPositive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Colors.greenAccent : Colors.redAccent,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    color: isPositive ? Colors.greenAccent : Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrajectoryCard(Color primary, Color textColor, Color cardBg, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.track_changes, color: primary, size: 24),
              const SizedBox(width: 12),
              Text(
                "Career Trajectory & Skill Gap",
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Compare your current skills against your dream role.",
            style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 14),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: textColor.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Senior Product Designer", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
                Icon(Icons.keyboard_arrow_down, color: textColor.withValues(alpha: 0.5)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CustomPaint(
                painter: RadarChartPainter(primary: primary, textColor: textColor.withValues(alpha: 0.5)),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Role Readiness", style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 16, fontWeight: FontWeight.w500)),
              Text("82%", style: TextStyle(color: primary, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.82,
              backgroundColor: primary.withValues(alpha: 0.1),
              color: primary,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text("Priority Focus Areas", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          _skillProgress("Leadership", "+30% needed", 0.7, primary, textColor),
          _skillProgress("Design Systems", "+25% needed", 0.75, primary, textColor),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primary.withValues(alpha: 0.3)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("View Recommended Courses", style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillProgress(String label, String needed, double progress, Color primary, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
              Text(needed, style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: textColor.withValues(alpha: 0.05),
              color: primary,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementCard(Color primary, Color textColor, Color cardBg) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Engagement Overview",
            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(
              painter: LineChartPainter(primary: primary, accent: Colors.tealAccent, textColor: textColor.withValues(alpha: 0.2)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _legendItem("Likes", primary, textColor),
              _legendItem("Comments", Colors.tealAccent, textColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelCard(Color primary, Color textColor, Color cardBg) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recruiter Funnel",
            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _funnelStep("Appearances", "15,750", 1.0, primary, textColor),
          _funnelStep("Profile Clicks", "4,340", 0.7, Colors.tealAccent, textColor),
          _funnelStep("Applications", "630", 0.4, Colors.orangeAccent, textColor),
        ],
      ),
    );
  }

  Widget _funnelStep(String label, String value, double widthFactor, Color color, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 14)),
          ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Container(
                  height: 12,
                  width: 150 * widthFactor,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Text(value, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicsCard(Color primary, Color textColor, Color cardBg) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audience Demographics",
            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CustomPaint(
                  painter: DonutChartPainter(primary: primary, textColor: textColor.withValues(alpha: 0.2)),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _legendItem("Tech", primary, textColor),
                    _legendItem("Finance", Colors.tealAccent, textColor),
                    _legendItem("Healthcare", Colors.orangeAccent, textColor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 12)),
        ],
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final Color primary;
  final Color textColor;
  RadarChartPainter({required this.primary, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paintGrid = Paint()..color = textColor.withValues(alpha: 0.1)..style = PaintingStyle.stroke;
    for (var i = 1; i <= 5; i++) {
      canvas.drawCircle(center, radius * (i / 5), paintGrid);
    }
    final paintFill = Paint()..color = primary.withValues(alpha: 0.2)..style = PaintingStyle.fill;
    final paintBorder = Paint()..color = primary..style = PaintingStyle.stroke..strokeWidth = 2;
    final path = Path();
    path.moveTo(center.dx, center.dy - radius * 0.8);
    path.lineTo(center.dx + radius * 0.7, center.dy - radius * 0.3);
    path.lineTo(center.dx + radius * 0.6, center.dy + radius * 0.5);
    path.lineTo(center.dx, center.dy + radius * 0.9);
    path.lineTo(center.dx - radius * 0.7, center.dy + radius * 0.4);
    path.lineTo(center.dx - radius * 0.6, center.dy - radius * 0.4);
    path.close();
    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LineChartPainter extends CustomPainter {
  final Color primary;
  final Color accent;
  final Color textColor;
  LineChartPainter({required this.primary, required this.accent, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()..color = textColor..style = PaintingStyle.stroke;
    for (var i = 0; i < 5; i++) {
      double y = size.height - (size.height / 4 * i);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }
    final p1 = Path();
    p1.moveTo(0, size.height * 0.6);
    p1.quadraticBezierTo(size.width * 0.2, size.height * 0.7, size.width * 0.4, size.height * 0.4);
    p1.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width * 0.8, size.height * 0.5);
    p1.lineTo(size.width, size.height * 0.3);
    final paint1 = Paint()..color = primary..style = PaintingStyle.stroke..strokeWidth = 3;
    canvas.drawPath(p1, paint1);
    final p2 = Path();
    p2.moveTo(0, size.height * 0.9);
    p2.lineTo(size.width * 0.3, size.height * 0.85);
    p2.lineTo(size.width * 0.6, size.height * 0.88);
    p2.lineTo(size.width, size.height * 0.8);
    final paint2 = Paint()..color = accent..style = PaintingStyle.stroke..strokeWidth = 3;
    canvas.drawPath(p2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DonutChartPainter extends CustomPainter {
  final Color primary;
  final Color textColor;
  DonutChartPainter({required this.primary, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 12;
    paint.color = primary;
    canvas.drawArc(rect, -1.5, 2.5, false, paint);
    paint.color = Colors.tealAccent;
    canvas.drawArc(rect, 1.1, 1.8, false, paint);
    paint.color = Colors.orangeAccent;
    canvas.drawArc(rect, 3.0, 0.8, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
