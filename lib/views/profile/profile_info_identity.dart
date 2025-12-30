import 'package:flutter/material.dart';

class ProfileInfoIdentity extends StatelessWidget {
  final String name;
  final String headline;
  final String location;
  final String openTo;
  final String availability;
  final String preference;
  final VoidCallback onEditProfile;
  final VoidCallback onEditIdentity;

  const ProfileInfoIdentity({
    super.key,
    required this.name,
    required this.headline,
    required this.location,
    required this.openTo,
    required this.availability,
    required this.preference,
    required this.onEditProfile,
    required this.onEditIdentity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.verified, color: Color(0xFF6366F1), size: 24),
              const SizedBox(width: 8),
              const Text("• 2nd", style: TextStyle(color: Colors.white38, fontSize: 18)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white38, size: 28),
                onPressed: onEditProfile,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            headline,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, height: 1.3),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              Text(
                "$location  •  ",
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Contact info",
                  style: TextStyle(color: Color(0xFF6366F1), fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "500+ connections",
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onEditIdentity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _identityRow("OPEN TO:", openTo, const Color(0xFF1E293B), const Color(0xFF60A5FA)),
                const SizedBox(height: 8),
                _identityRow("AVAILABILITY:", availability, const Color(0xFF064E3B), const Color(0xFF34D399)),
                const SizedBox(height: 8),
                _identityRow("PREFERENCE:", preference, const Color(0xFF1E293B), const Color(0xFF60A5FA)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _identityRow(String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
