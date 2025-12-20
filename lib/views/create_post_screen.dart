import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController postCtrl = TextEditingController();

  File? imageFile;
  File? videoFile;

  bool showPoll = false;
  final pollQCtrl = TextEditingController();
  final pollOpt1 = TextEditingController();
  final pollOpt2 = TextEditingController();

  final bg = const Color(0xFF0B1220);
  final card = const Color(0xFF111827);
  final accent = const Color(0xFF7C83FF);

  bool get canPost {
    if (postCtrl.text.trim().isNotEmpty) return true;
    if (imageFile != null || videoFile != null) return true;
    if (showPoll &&
        pollQCtrl.text.isNotEmpty &&
        pollOpt1.text.isNotEmpty &&
        pollOpt2.text.isNotEmpty) return true;
    return false;
  }

  // ───────── IMAGE PICK ─────────
  Future<void> pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        imageFile = File(img.path);
        videoFile = null;
        showPoll = false;
      });
    }
  }

  // ───────── VIDEO PICK ─────────
  Future<void> pickVideo() async {
    final vid = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (vid != null) {
      setState(() {
        videoFile = File(vid.path);
        imageFile = null;
        showPoll = false;
      });
    }
  }

  // ───────── POLL ─────────
  void addPoll() {
    setState(() {
      showPoll = true;
      imageFile = null;
      videoFile = null;
    });
  }

  void removePoll() {
    setState(() {
      showPoll = false;
      pollQCtrl.clear();
      pollOpt1.clear();
      pollOpt2.clear();
    });
  }

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context), // ✅ FIXED
        ),
        title: const Text("Create a post"),
        actions: [
          TextButton(
            onPressed: canPost ? () {} : null,
            child: Text(
              "Post",
              style: TextStyle(
                color: canPost ? accent : Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _author(),
            const SizedBox(height: 12),
            _postInput(),
            if (imageFile != null) _imagePreview(),
            if (videoFile != null) _videoPreview(),
            if (showPoll) _pollUI(),
            const SizedBox(height: 20),
            _actions(),
          ],
        ),
      ),
    );
  }

  Widget _author() {
    return Row(
      children: const [
        CircleAvatar(radius: 22),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("John Doe",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("Post to Anyone",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        )
      ],
    );
  }

  Widget _postInput() {
    return TextField(
      controller: postCtrl,
      maxLines: null,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: const InputDecoration(
        hintText: "What do you want to share?",
        hintStyle: TextStyle(color: Colors.white38),
        border: InputBorder.none,
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _imagePreview() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(imageFile!, fit: BoxFit.cover),
          ),
          _removeButton(() => setState(() => imageFile = null)),
        ],
      ),
    );
  }

  Widget _videoPreview() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.play_circle, size: 60, color: Colors.white),
        ),
      ),
    );
  }

  Widget _pollUI() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text("Create Poll",
                    style: TextStyle(color: Colors.white)),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: removePoll,
              )
            ],
          ),
          _pollField("Question", pollQCtrl),
          _pollField("Option 1", pollOpt1),
          _pollField("Option 2", pollOpt2),
        ],
      ),
    );
  }

  Widget _pollField(String hint, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: c,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: const Color(0xFF0B1220),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _action(Icons.image, "Photo", pickImage),
        _action(Icons.videocam, "Video", pickVideo),
        _action(Icons.poll, "Poll", addPoll),
      ],
    );
  }

  Widget _action(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _removeButton(VoidCallback onTap) {
    return Positioned(
      top: 8,
      right: 8,
      child: InkWell(
        onTap: onTap,
        child: const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.black54,
          child: Icon(Icons.close, size: 16, color: Colors.white),
        ),
      ),
    );
  }
}
