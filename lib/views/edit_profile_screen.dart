import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, String> initialData;

  const EditProfileScreen({super.key, required this.initialData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _headlineController;
  late TextEditingController _jobTitleController;
  late TextEditingController _companyController;
  late TextEditingController _schoolController;
  late TextEditingController _degreeController;
  late TextEditingController _locationController;
  late TextEditingController _aboutController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name']);
    _headlineController = TextEditingController(text: widget.initialData['headline']);
    _jobTitleController = TextEditingController(text: widget.initialData['jobTitle']);
    _companyController = TextEditingController(text: widget.initialData['company']);
    _schoolController = TextEditingController(text: widget.initialData['school']);
    _degreeController = TextEditingController(text: widget.initialData['degree']);
    _locationController = TextEditingController(text: widget.initialData['location']);
    _aboutController = TextEditingController(text: widget.initialData['about']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _headlineController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    _schoolController.dispose();
    _degreeController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const Expanded(
              child: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'headline': _headlineController.text,
                    'jobTitle': _jobTitleController.text,
                    'company': _companyController.text,
                    'school': _schoolController.text,
                    'degree': _degreeController.text,
                    'location': _locationController.text,
                    'about': _aboutController.text,
                  });
                }
              },
              icon: const Icon(Icons.save_outlined, size: 18),
              label: const Text("Save Changes", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputLabel("Full Name"),
                _buildTextField(_nameController, "Enter your name"),
                _buildInputLabel("Headline"),
                _buildTextField(_headlineController, "Enter your professional headline"),
                _buildInputLabel("Job Title"),
                _buildTextField(_jobTitleController, "Enter your job title"),
                _buildInputLabel("Company Name"),
                _buildTextField(_companyController, "Enter your company name"),
                _buildInputLabel("Education (School)"),
                _buildTextField(_schoolController, "Enter your school"),
                _buildInputLabel("Degree"),
                _buildTextField(_degreeController, "Enter your degree"),
                _buildInputLabel("Location"),
                _buildTextField(_locationController, "Enter your location"),
                _buildInputLabel("About"),
                _buildTextField(_aboutController, "Tell us about yourself", maxLines: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF0F172A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}
