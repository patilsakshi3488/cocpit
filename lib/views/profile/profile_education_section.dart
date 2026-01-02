import 'package:flutter/material.dart';
import 'profile_models.dart';

class ProfileEducationSection extends StatelessWidget {
  final List<Education> educations;
  final Function({Education? education, int? index}) onAddEditEducation;

  const ProfileEducationSection({
    super.key,
    required this.educations,
    required this.onAddEditEducation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Education",
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => onAddEditEducation(),
                child: Text("Add", style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...educations.asMap().entries.map((entry) {
            int idx = entry.key;
            Education edu = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.school, color: theme.colorScheme.onPrimary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(edu.school, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.edit_outlined, color: theme.iconTheme.color?.withValues(alpha: 0.5), size: 20),
                              onPressed: () => onAddEditEducation(education: edu, index: idx),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Text("${edu.degree}, ${edu.fieldOfStudy}", style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 4),
                        Text(
                          "${edu.startYear} - ${edu.currentlyStudying ? 'Present' : edu.endYear}",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          edu.description,
                          style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
