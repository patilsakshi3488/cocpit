import 'package:flutter/material.dart';

class ProfileLivingResume extends StatelessWidget {
  final bool isOverviewSelected;
  final Function(bool) onTabChanged;
  final VoidCallback onUploadResume;
  final VoidCallback onDownloadPDF;

  const ProfileLivingResume({
    super.key,
    required this.isOverviewSelected,
    required this.onTabChanged,
    required this.onUploadResume,
    required this.onDownloadPDF,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_outlined, color: Color(0xFF6366F1), size: 24),
              SizedBox(width: 12),
              Text(
                "Living Resume",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onUploadResume,
                  icon: const Icon(Icons.upload_outlined, size: 18),
                  label: const Text("Add Custom\nResume", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    foregroundColor: Colors.white70,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onDownloadPDF,
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text("Download\nPDF", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildResumeTab("Overview", isOverviewSelected),
              const SizedBox(width: 24),
              _buildResumeTab("Metrics", !isOverviewSelected),
            ],
          ),
          const SizedBox(height: 24),
          if (isOverviewSelected) ...[
            _buildResumeCard("7+ years experience", "across product management & strategy"),
            const SizedBox(height: 16),
            _buildResumeCard("30+ features shipped", "driving user growth & revenue"),
            const SizedBox(height: 24),
            const Text(
              "Product leader with 7+ years of experience in high-growth tech environments. Specializing in data-driven product strategy and user-centric design.",
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResumeTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => onTabChanged(label == "Overview"),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6366F1) : Colors.white38,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(height: 2, width: 40, color: const Color(0xFF6366F1)),
        ],
      ),
    );
  }

  Widget _buildResumeCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 14)),
        ],
      ),
    );
  }
}
