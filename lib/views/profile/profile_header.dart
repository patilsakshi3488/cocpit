import 'package:flutter/material.dart';
import '../fullscreen_image.dart';

class ProfileHeader extends StatelessWidget {
  final String profileImage;
  final String? coverImage;
  final VoidCallback onMenuPressed;
  final VoidCallback onCameraPressed;
  final VoidCallback onCoverCameraPressed;
  final Color backgroundColor;

  const ProfileHeader({
    super.key,
    required this.profileImage,
    this.coverImage,
    required this.onMenuPressed,
    required this.onCameraPressed,
    required this.onCoverCameraPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover Photo / Header Background
        GestureDetector(
          onTap: () {
            if (coverImage != null && coverImage!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImage(
                    imagePath: coverImage!,
                    tag: 'cover_hero',
                  ),
                ),
              );
            }
          },
          child: Hero(
            tag: 'cover_hero',
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: coverImage == null || coverImage!.isEmpty
                    ? const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFFD946EF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                image: coverImage != null && coverImage!.isNotEmpty
                    ? DecorationImage(image: AssetImage(coverImage!), fit: BoxFit.cover)
                    : null,
              ),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Cover Camera Icon
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28),
                          onPressed: onCoverCameraPressed,
                          tooltip: 'Edit Cover Photo',
                        ),
                        // Menu Icon
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                          onPressed: onMenuPressed,
                          tooltip: 'Open Menu',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Profile Photo
        Positioned(
          bottom: -50,
          left: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  if (profileImage.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImage(
                          imagePath: profileImage,
                          tag: 'profile_hero',
                        ),
                      ),
                    );
                  }
                },
                child: Hero(
                  tag: 'profile_hero',
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: profileImage.isNotEmpty ? AssetImage(profileImage) : null,
                      child: profileImage.isEmpty ? const Icon(Icons.person, color: Colors.white, size: 60) : null,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onCameraPressed,
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFFD946EF)]),
                      shape: BoxShape.circle,
                      border: Border.all(color: backgroundColor, width: 3),
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
