import 'package:flutter/material.dart';

class ApplyJobScreen extends StatefulWidget {
  final Map<String, dynamic> job;

  const ApplyJobScreen({super.key, required this.job});

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  /* ================= THEME ================= */
  static const Color bg = Color(0xFF0B1220);
  static const Color card = Color(0xFF111827);
  static const Color border = Color(0xFF1F2937);
  static const Color primary = Color(0xFF7C83FF);

  /* ================= FORM ================= */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController resumeCtrl = TextEditingController();

  bool isSubmitting = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    resumeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Back to Job Listings',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _jobHeader(),
                  const SizedBox(height: 24),
                  _jobDescription(),
                  const SizedBox(height: 24),
                  _applyForm(),
                ],
              ),
            ),
          ),
          _submitButton(),
        ],
      ),
    );
  }

  /* ================= JOB HEADER ================= */

  Widget _jobHeader() {
    final job = widget.job;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(job['company'],
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: [
                    _meta(Icons.location_on_outlined, job['location']),
                    _meta(Icons.work_outline, job['type']),
                    _meta(Icons.schedule, job['time']),
                    Text(job['salary'],
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /* ================= DESCRIPTION ================= */

  Widget _jobDescription() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('About the role'),
          _text(
              'This is a placeholder for the full job description. '
                  'Once backend APIs are connected, this content will be fetched dynamically.'),
          _section('Responsibilities'),
          _bullet('Collaborate with cross-functional teams'),
          _bullet('Design and implement new features'),
          _bullet('Write clean and maintainable code'),
          _bullet('Participate in code reviews'),
          _bullet('Fix bugs and improve performance'),
          _section('Qualifications'),
          _bullet('Bachelor’s degree or equivalent experience'),
          _bullet('3+ years of relevant experience'),
          _bullet('Strong problem-solving skills'),
        ],
      ),
    );
  }

  /* ================= APPLY FORM ================= */

  Widget _applyForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Apply for this Job',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _input('Full Name', nameCtrl),
            _input('Email Address', emailCtrl,
                keyboard: TextInputType.emailAddress),
            _input('Phone Number', phoneCtrl,
                keyboard: TextInputType.phone),
            _input('Resume Link (PDF / Drive URL)', resumeCtrl),
          ],
        ),
      ),
    );
  }

  /* ================= SUBMIT ================= */

  Widget _submitButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: border)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: isSubmitting ? null : _submitApplication,
          child: isSubmitting
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            'Apply for this Job',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  /* ================= BACKEND READY SUBMIT ================= */

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    /// 🔥 BACKEND PAYLOAD (READY)
    final payload = {
      "jobId": widget.job['id'] ?? '',
      "name": nameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "resumeUrl": resumeCtrl.text.trim(),
    };

    /// ⛔ No Firebase
    /// 🔗 Call REST API here later
    /// Example:
    /// await ApiService.applyJob(payload);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => isSubmitting = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application submitted successfully')),
    );

    Navigator.pop(context);
  }

  /* ================= UI HELPERS ================= */

  Widget _input(String hint, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        validator: (v) =>
        v == null || v.isEmpty ? 'This field is required' : null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: bg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white54),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white60)),
      ],
    );
  }

  Widget _section(String t) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 8),
    child: Text(t,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600)),
  );

  Widget _text(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(t,
        style:
        const TextStyle(color: Colors.white70, height: 1.5)),
  );

  Widget _bullet(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(color: Colors.white70)),
        Expanded(
            child: Text(t,
                style: const TextStyle(
                    color: Colors.white70, height: 1.5))),
      ],
    ),
  );
}
