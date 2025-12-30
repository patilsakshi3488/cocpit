import 'package:flutter/material.dart';
import '../fullscreen_image.dart';

class PhotoActionHelper {
  static void showPhotoActions({
    required BuildContext context,
    required String title,
    required String? imagePath,
    required String heroTag,
    required VoidCallback onUpdate,
    required VoidCallback onDelete,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF0F172A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => _buildMenu(context, title, imagePath, heroTag, onUpdate, onDelete),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: const Color(0xFF0F172A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: _buildMenu(context, title, imagePath, heroTag, onUpdate, onDelete),
          ),
        ),
      );
    }
  }

  static Widget _buildMenu(
    BuildContext context,
    String title,
    String? imagePath,
    String heroTag,
    VoidCallback onUpdate,
    VoidCallback onDelete,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(color: Colors.white10),
        _buildOptionItem(
          icon: Icons.visibility_outlined,
          title: "View Photo",
          onTap: () {
            Navigator.pop(context);
            if (imagePath != null && imagePath.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImage(imagePath: imagePath, tag: heroTag),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No image to view")),
              );
            }
          },
        ),
        _buildOptionItem(
          icon: Icons.edit_outlined,
          title: "Edit Photo",
          onTap: () {
            Navigator.pop(context);
            _showEditSubMenu(context, onUpdate, onDelete);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  static void _showEditSubMenu(BuildContext context, VoidCallback onUpdate, VoidCallback onDelete) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOptionItem(
            icon: Icons.cloud_upload_outlined,
            title: "Update Photo",
            onTap: () {
              Navigator.pop(context);
              _showUpdateOptions(context, onUpdate);
            },
          ),
          _buildOptionItem(
            icon: Icons.delete_outline,
            title: "Delete Photo",
            color: Colors.redAccent,
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, onDelete);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void _showUpdateOptions(BuildContext context, VoidCallback onUpdate) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOptionItem(
            icon: Icons.camera_alt_outlined,
            title: "Take Photo",
            onTap: () {
              Navigator.pop(context);
              onUpdate();
            },
          ),
          _buildOptionItem(
            icon: Icons.image_outlined,
            title: "Upload from Gallery",
            onTap: () {
              Navigator.pop(context);
              onUpdate();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void _showDeleteConfirmation(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Delete Photo", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to remove this photo?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  static Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.white70,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
