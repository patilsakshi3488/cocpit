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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.verified, color: theme.primaryColor, size: 24),
              const SizedBox(width: 8),
              Text("• 2nd", style: theme.textTheme.bodyLarge?.copyWith(color: theme.textTheme.bodySmall?.color)),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.edit_outlined, color: theme.iconTheme.color?.withValues(alpha: 0.5), size: 28),
                onPressed: onEditProfile,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            headline,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              Text(
                "$location  •  ",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Contact info",
                  style: TextStyle(color: theme.primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "500+ connections",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onEditIdentity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _identityRow(context, "OPEN TO:", openTo, colorScheme.surfaceContainer, theme.primaryColor),
                const SizedBox(height: 8),
                _identityRow(context, "AVAILABILITY:", availability, Colors.green.withValues(alpha: 0.1), Colors.green),
                const SizedBox(height: 8),
                _identityRow(context, "PREFERENCE:", preference, colorScheme.surfaceContainer, theme.primaryColor),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _identityRow(BuildContext context, String label, String value, Color bgColor, Color textColor) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: theme.dividerColor),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 11, fontWeight: FontWeight.bold),
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
