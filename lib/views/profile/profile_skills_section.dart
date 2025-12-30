import 'package:flutter/material.dart';

class ProfileSkillsSection extends StatelessWidget {
  final List<String> skills;
  final VoidCallback onAddSkill;

  const ProfileSkillsSection({
    super.key,
    required this.skills,
    required this.onAddSkill,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: onAddSkill,
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
}
