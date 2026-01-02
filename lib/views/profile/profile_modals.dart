import 'package:flutter/material.dart';
import 'profile_models.dart';

class EditIdentityModal extends StatefulWidget {
  final String initialOpenTo;
  final String initialAvailability;
  final String initialPreference;

  const EditIdentityModal({
    super.key,
    required this.initialOpenTo,
    required this.initialAvailability,
    required this.initialPreference,
  });

  @override
  State<EditIdentityModal> createState() => _EditIdentityModalState();
}

class _EditIdentityModalState extends State<EditIdentityModal> {
  late String openTo;
  late String availability;
  late String preference;

  @override
  void initState() {
    super.initState();
    openTo = widget.initialOpenTo;
    availability = widget.initialAvailability;
    preference = widget.initialPreference;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit Professional Identity",
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close, color: colorScheme.onBackground.withValues(alpha: 0.4)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection("Open to", ["Full-time", "Freelance", "Consulting", "Mentorship"], openTo, (val) => setState(() => openTo = val)),
          const SizedBox(height: 32),
          _buildSection("Availability", ["Immediate", "30 Days", "Casual Networking"], availability, (val) => setState(() => availability = val), activeColor: Colors.green),
          const SizedBox(height: 32),
          _buildSection("Work Preference", ["Remote", "Hybrid", "Onsite"], preference, (val) => setState(() => preference = val)),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'openTo': openTo,
              'availability': availability,
              'preference': preference,
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("Save Changes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: colorScheme.onBackground.withValues(alpha: 0.4), fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> options, String current, Function(String) onSelect, {Color? activeColor}) {
    final theme = Theme.of(context);
    final primary = activeColor ?? theme.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((opt) {
            bool isSelected = opt == current;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? primary : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? primary : theme.dividerColor),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class UploadResumeModal extends StatelessWidget {
  const UploadResumeModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              Text(
                "Upload Custom Resume",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close, color: colorScheme.onBackground.withValues(alpha: 0.4)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Upload a PDF or DOCX file to attach to your profile.",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
            ),
            child: Column(
              children: [
                Icon(Icons.upload_outlined, color: theme.primaryColor, size: 48),
                const SizedBox(height: 16),
                Text("Click to upload", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("PDF or DOCX (Max 5MB)", style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: colorScheme.onBackground.withValues(alpha: 0.4), fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class ExperienceModal extends StatefulWidget {
  final Experience? experience;

  const ExperienceModal({super.key, this.experience});

  @override
  State<ExperienceModal> createState() => _ExperienceModalState();
}

class _ExperienceModalState extends State<ExperienceModal> {
  late TextEditingController _titleController;
  late TextEditingController _companyController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late bool _currentlyWorking;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.experience?.title ?? "");
    _companyController = TextEditingController(text: widget.experience?.company ?? "");
    _startDateController = TextEditingController(text: widget.experience?.startDate ?? "");
    _endDateController = TextEditingController(text: widget.experience?.endDate ?? "");
    _locationController = TextEditingController(text: widget.experience?.location ?? "");
    _descriptionController = TextEditingController(text: widget.experience?.description ?? "");
    _currentlyWorking = widget.experience?.currentlyWorking ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isEdit = widget.experience != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text(
                  isEdit ? "Edit Experience" : "Add Experience",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.textTheme.bodySmall?.color),
                  onPressed: () => Navigator.pop(context, widget.experience),
                ),
              ],
            ),
            Center(
              child: Text(
                isEdit ? "Edit the details of your experience." : "Add a new experience to your profile.",
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel("Title"),
            _buildTextField(_titleController, "Ex: Product Manager"),
            _buildLabel("Company"),
            _buildTextField(_companyController, "Ex: Microsoft"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Start Date"),
                      _buildDateField(_startDateController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("End Date"),
                      _buildDateField(_endDateController, enabled: !_currentlyWorking),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _currentlyWorking,
                  onChanged: (val) => setState(() => _currentlyWorking = val ?? false),
                  side: BorderSide(color: theme.dividerColor),
                  activeColor: theme.primaryColor,
                ),
                Text("I currently work here", style: theme.textTheme.bodyMedium),
              ],
            ),
            _buildLabel("Location"),
            _buildTextField(_locationController, "Ex: London, UK"),
            _buildLabel("Description"),
            _buildTextField(_descriptionController, "Describe your responsibilities...", maxLines: 4),
            const SizedBox(height: 32),
            Row(
              children: [
                if (isEdit)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Delete", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, widget.experience),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: theme.dividerColor),
                      ),
                      child: Text("Cancel", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          Experience(
                            title: _titleController.text,
                            company: _companyController.text,
                            startDate: _startDateController.text,
                            endDate: _endDateController.text,
                            currentlyWorking: _currentlyWorking,
                            location: _locationController.text,
                            description: _descriptionController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(label, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, {bool enabled = true}) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      enabled: enabled,
      style: theme.textTheme.bodyLarge?.copyWith(color: enabled ? null : theme.textTheme.bodySmall?.color),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today, color: theme.textTheme.bodySmall?.color, size: 18),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      readOnly: true,
      onTap: () async {
        if (!enabled) return;
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
        }
      },
    );
  }
}

class EducationModal extends StatefulWidget {
  final Education? education;

  const EducationModal({super.key, this.education});

  @override
  State<EducationModal> createState() => _EducationModalState();
}

class _EducationModalState extends State<EducationModal> {
  late TextEditingController _schoolController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldController;
  late TextEditingController _startYearController;
  late TextEditingController _endYearController;
  late TextEditingController _descriptionController;
  late bool _currentlyStudying;

  @override
  void initState() {
    super.initState();
    _schoolController = TextEditingController(text: widget.education?.school ?? "");
    _degreeController = TextEditingController(text: widget.education?.degree ?? "");
    _fieldController = TextEditingController(text: widget.education?.fieldOfStudy ?? "");
    _startYearController = TextEditingController(text: widget.education?.startYear ?? "Select year...");
    _endYearController = TextEditingController(text: widget.education?.endYear ?? "Select year...");
    _descriptionController = TextEditingController(text: widget.education?.description ?? "");
    _currentlyStudying = widget.education?.currentlyStudying ?? false;
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isEdit = widget.education != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text(
                  isEdit ? "Edit Education" : "Add Education",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.textTheme.bodySmall?.color),
                  onPressed: () => Navigator.pop(context, widget.education),
                ),
              ],
            ),
            Center(
              child: Text(
                isEdit ? "Edit the details of your education." : "Add a new education to your profile.",
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel("School"),
            _buildTextField(_schoolController, "Ex: Stanford University"),
            _buildLabel("Degree"),
            _buildTextField(_degreeController, "Ex: MBA"),
            _buildLabel("Field of Study"),
            _buildTextField(_fieldController, "Ex: Business Administration"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Start Year"),
                      _buildYearPicker(_startYearController),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("End Year"),
                      _buildYearPicker(_endYearController, enabled: !_currentlyStudying),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _currentlyStudying,
                  onChanged: (val) => setState(() => _currentlyStudying = val ?? false),
                  side: BorderSide(color: theme.dividerColor),
                  activeColor: theme.primaryColor,
                ),
                Text("I'm still studying", style: theme.textTheme.bodyMedium),
              ],
            ),
            _buildLabel("Description"),
            _buildTextField(_descriptionController, "Describe your activities, societies, etc.", maxLines: 4),
            const SizedBox(height: 32),
            Row(
              children: [
                if (isEdit)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Delete", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, widget.education),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: theme.dividerColor),
                      ),
                      child: Text("Cancel", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          Education(
                            school: _schoolController.text,
                            degree: _degreeController.text,
                            fieldOfStudy: _fieldController.text,
                            startYear: _startYearController.text,
                            endYear: _endYearController.text,
                            currentlyStudying: _currentlyStudying,
                            description: _descriptionController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(label, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildYearPicker(TextEditingController controller, {bool enabled = true}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: enabled ? () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Text("Select Year", style: theme.textTheme.titleLarge),
              content: SizedBox(
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                  selectedDate: DateTime.now(),
                  onChanged: (DateTime dateTime) {
                    controller.text = dateTime.year.toString();
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      } : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text,
              style: theme.textTheme.bodyLarge?.copyWith(color: enabled ? null : theme.textTheme.bodySmall?.color),
            ),
            Icon(Icons.unfold_more, color: theme.textTheme.bodySmall?.color, size: 20),
          ],
        ),
      ),
    );
  }
}

class SkillsModal extends StatefulWidget {
  final List<String> initialSkills;

  const SkillsModal({super.key, required this.initialSkills});

  @override
  State<SkillsModal> createState() => _SkillsModalState();
}

class _SkillsModalState extends State<SkillsModal> {
  late List<String> _currentSkills;
  final TextEditingController _skillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentSkills = List.from(widget.initialSkills);
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_skillController.text.trim().isNotEmpty) {
      setState(() {
        _currentSkills.add(_skillController.text.trim());
        _skillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              Text(
                "Manage Skills",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close, color: theme.textTheme.bodySmall?.color),
                onPressed: () => Navigator.pop(context, widget.initialSkills),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _skillController,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: "Add a new skill...",
                    hintStyle: theme.textTheme.bodySmall,
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: theme.dividerColor)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _addSkill(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _addSkill,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _currentSkills.map((skill) => Container(
              padding: const EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(skill, style: theme.textTheme.bodyMedium),
                  IconButton(
                    icon: Icon(Icons.close, color: theme.textTheme.bodySmall?.color, size: 16),
                    onPressed: () => setState(() => _currentSkills.remove(skill)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )).toList(),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _currentSkills),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Save Changes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
