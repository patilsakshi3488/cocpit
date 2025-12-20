import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:video_player/video_player.dart';

class CreateCareerMomentScreen extends StatefulWidget {
  const CreateCareerMomentScreen({super.key});

  @override
  State<CreateCareerMomentScreen> createState() =>
      _CreateCareerMomentScreenState();
}

class _CreateCareerMomentScreenState
    extends State<CreateCareerMomentScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _mediaFile;
  bool _isVideo = false;
  VideoPlayerController? _videoController;

  final TextEditingController _captionController = TextEditingController();
  bool _showEmojiPicker = false;

  // 🔥 POLL
  bool _showPoll = false;
  final TextEditingController _pollQ = TextEditingController();
  final TextEditingController _pollA = TextEditingController();
  final TextEditingController _pollB = TextEditingController();

  @override
  void dispose() {
    _videoController?.dispose();
    _captionController.dispose();
    _pollQ.dispose();
    _pollA.dispose();
    _pollB.dispose();
    super.dispose();
  }

  // ---------------- MEDIA PICK ----------------

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _mediaFile = File(image.path);
      _isVideo = false;
      _videoController?.dispose();
      _videoController = null;
    });
  }

  Future<void> _pickVideo() async {
    final XFile? video =
    await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    _videoController?.dispose();
    _videoController = VideoPlayerController.file(File(video.path))
      ..initialize().then((_) {
        setState(() {
          _mediaFile = File(video.path);
          _isVideo = true;
          _videoController!.play();
          _videoController!.setLooping(true);
        });
      });
  }

  void _removeMedia() {
    setState(() {
      _mediaFile = null;
      _isVideo = false;
      _videoController?.dispose();
      _videoController = null;
    });
  }

  // ---------------- POST ----------------

  void _postMoment() {
    if (_mediaFile == null &&
        _captionController.text.trim().isEmpty &&
        !_showPoll) {
      return;
    }

    // 🔥 Firebase later:
    // mediaUrl, caption, poll, createdAt, expiresAt = now + 24h

    Navigator.pop(context); // ✅ NO WHITE SCREEN
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(child: _content()),
            _bottomControls(),
            if (_showEmojiPicker) _emojiPicker(),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          TextButton(
            onPressed: _postMoment,
            child: const Text(
              "Post",
              style: TextStyle(
                color: Color(0xFF7C83FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CONTENT ----------------

  Widget _content() {
    if (_mediaFile == null) {
      return _emptyState();
    }

    return Stack(
      children: [
        Positioned.fill(
          child: _isVideo
              ? VideoPlayer(_videoController!)
              : Image.file(_mediaFile!, fit: BoxFit.cover),
        ),

        // REMOVE MEDIA
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _removeMedia,
          ),
        ),

        // TEXT OVERLAY
        Positioned(
          bottom: _showPoll ? 160 : 80,
          left: 16,
          right: 16,
          child: TextField(
            controller: _captionController,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Add a career moment...",
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
          ),
        ),

        // POLL OVERLAY
        if (_showPoll)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: _pollCard(),
          ),
      ],
    );
  }

  // ---------------- EMPTY ----------------

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pickBtn(Icons.image, "Add Image", _pickImage),
          const SizedBox(height: 14),
          _pickBtn(Icons.videocam, "Add Video", _pickVideo),
        ],
      ),
    );
  }

  Widget _pickBtn(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1F2937),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  // ---------------- POLL ----------------

  Widget _pollCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          TextField(
            controller: _pollQ,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Poll question",
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 6),
          _pollOption(_pollA, "Option 1"),
          _pollOption(_pollB, "Option 2"),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => setState(() => _showPoll = false),
              child: const Text("Remove Poll",
                  style: TextStyle(color: Colors.redAccent)),
            ),
          )
        ],
      ),
    );
  }

  Widget _pollOption(TextEditingController c, String hint) {
    return TextField(
      controller: c,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }

  // ---------------- BOTTOM CONTROLS ----------------

  Widget _bottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: const Color(0xFF0B1220),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined,
                color: Colors.white),
            onPressed: () =>
                setState(() => _showEmojiPicker = !_showEmojiPicker),
          ),
          IconButton(
            icon: const Icon(Icons.poll_outlined, color: Colors.white),
            onPressed: () => setState(() => _showPoll = !_showPoll),
          ),
          const SizedBox(width: 8),
          const Text(
            "#Hashtags   @Mentions",
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  // ---------------- EMOJI ----------------

  Widget _emojiPicker() {
    return SizedBox(
      height: 300,
      child: EmojiPicker(
        onEmojiSelected: (_, emoji) {
          _captionController.text += emoji.emoji;
        },
        config: const Config(
          emojiViewConfig:
          EmojiViewConfig(backgroundColor: Color(0xFF1F2937)),
        ),
      ),
    );
  }
}
