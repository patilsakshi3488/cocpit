import 'package:flutter/material.dart';

class FunnelSection extends StatelessWidget {
  final Color textColor;
  final Color subTextColor;
  final Color primary;

  const FunnelSection({
    super.key,
    required this.textColor,
    required this.subTextColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      {"label": "SEARCH APPEARANCES", "value": "15,750", "percentage": "100%", "color": Colors.blue},
      {"label": "PROFILE CLICKS", "value": "4,340", "percentage": "27.5%", "color": primary},
      {"label": "CONNECTED/FOLLOWED", "value": "630", "percentage": "14.5%", "color": Colors.purpleAccent},
      {"label": "MESSAGE/INQUIRY", "value": "84", "percentage": "13.3%", "color": Colors.deepPurpleAccent},
    ];

    return Column(
      children: steps.map((step) => _funnelItem(
        icon: _getIcon(step["label"] as String),
        label: step["label"] as String,
        value: step["value"] as String,
        percentage: step["percentage"] as String,
        color: step["color"] as Color,
      )).toList(),
    );
  }

  IconData _getIcon(String label) {
    if (label.contains("SEARCH")) return Icons.filter_alt;
    if (label.contains("CLICKS")) return Icons.ads_click;
    if (label.contains("CONNECTED")) return Icons.person_add;
    return Icons.chat_bubble;
  }

  Widget _funnelItem({
    required IconData icon,
    required String label,
    required String value,
    required String percentage,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, radius: 20, child: Icon(icon, color: Colors.white, size: 18)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: subTextColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(20)),
            child: Text(percentage, style: TextStyle(color: subTextColor, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
