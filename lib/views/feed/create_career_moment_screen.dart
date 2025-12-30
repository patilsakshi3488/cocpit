import 'package:flutter/material.dart';

class CreateCareerMomentScreen extends StatelessWidget {
  const CreateCareerMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create Story",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text("Upload Image", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 12),
              _uploadBox(
                context,
                title: "Upload an image for your story",
                btnText: "Upload Image",
                icon: Icons.image_outlined,
              ),
              const SizedBox(height: 32),
              const Text("Upload Video", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 12),
              _uploadBox(
                context,
                title: "Upload a video for your story",
                btnText: "Upload Video",
                icon: Icons.videocam_outlined,
              ),
              const SizedBox(height: 32),
              const Text("Description", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: const TextField(
                    maxLines: null,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Add a description to your story...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      icon: Icon(Icons.description_outlined, color: Colors.white38),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.white10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F70F0),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Create Story", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _uploadBox(BuildContext context, {required String title, required String btnText, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4F70F0).withOpacity(0.5), style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: const Color(0xFF4F70F0), size: 20),
                const SizedBox(width: 8),
                Text(btnText, style: const TextStyle(color: Color(0xFF4F70F0), fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
