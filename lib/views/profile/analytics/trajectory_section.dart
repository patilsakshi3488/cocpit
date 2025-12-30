import 'package:flutter/material.dart';
import 'analytics_charts.dart';

class TrajectorySection extends StatelessWidget {
  final Color primary;
  final Color textColor;

  const TrajectorySection({
    super.key,
    required this.primary,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.track_changes, color: primary, size: 24),
              const SizedBox(width: 12),
              const Text(
                "Career Trajectory & Skill Gap",
                style: TextStyle(color: Color(0xFF0B1220), fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Compare your current skills against your dream role.",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Senior Product Designer", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CustomPaint(
                painter: RadarChartPainter(primary: primary, textColor: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Role Readiness", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500)),
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
          const SizedBox(height: 12),
          const Text("You are on track for this role.", style: TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 32),
          const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text("Priority Focus Areas", style: TextStyle(color: Color(0xFF0B1220), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          _skillProgress(context, "Leadership", "+30% needed", 0.7),
          _skillProgress(context, "Design Systems", "+25% needed", 0.75),
          _skillProgress(context, "Strategy", "+20% needed", 0.8),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primary.withValues(alpha: 0.2)),
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

  Widget _skillProgress(BuildContext context, String label, String needed, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
              Text(needed, style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black.withValues(alpha: 0.05),
              color: Colors.orange,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
