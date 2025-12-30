import 'package:flutter/material.dart';
import 'analytics_charts.dart';

class EngagementSection extends StatelessWidget {
  final Color primary;
  final Color textColor;

  const EngagementSection({
    super.key,
    required this.primary,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Engagement Overview", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Profile interactions over time", style: TextStyle(color: Colors.white54, fontSize: 14)),
          const SizedBox(height: 24),
          Row(
            children: [
              _chartLegend(Colors.tealAccent, "Interactions"),
              const SizedBox(width: 16),
              _chartLegend(primary, "Profile Views"),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CustomPaint(
              painter: LineChartPainter(primary: primary, accent: Colors.tealAccent, textColor: Colors.white24),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dec 5", style: TextStyle(color: Colors.white38, fontSize: 12)),
              Text("Dec 13", style: TextStyle(color: Colors.white38, fontSize: 12)),
              Text("Dec 21", style: TextStyle(color: Colors.white38, fontSize: 12)),
              Text("Dec 30", style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chartLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}
