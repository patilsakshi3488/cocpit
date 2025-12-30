import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'signin_screen.dart';
import '../feed/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String selectedRole = 'Select your role';

  final roles = [
    'Select your role',
    'Student',
    'Professional',
    'Founder',
    'Recruiter',
    'Business Owner',
  ];

  bool isLoading = false;

  final bg = const Color(0xFF0B1220);
  final card = const Color(0xFF0F172A);
  final field = const Color(0xFF111827);
  final border = const Color(0xFF1F2937);

  final gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  Future<void> _createAccount() async {
    if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      _showMsg("All fields are required");
      return;
    }

    if (selectedRole == 'Select your role') {
      _showMsg("Please select your role");
      return;
    }

    try {
      setState(() => isLoading = true);

      final url = Uri.parse("http://10.0.2.2:5000/api/auth/register");
      
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": nameCtrl.text.trim(),
          "email": emailCtrl.text.trim(),
          "password": passCtrl.text.trim(),
          "role": selectedRole,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _showMsg("Account created successfully");

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        _showMsg(responseData['message'] ?? "Signup failed");
      }
    } catch (e) {
      _showMsg("Server connection failed. Please try again.");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 40,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logo(),
                const SizedBox(height: 24),

                const Text(
                  "Create account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Join Cocpit and grow your career",
                  style: TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 28),

                _input("Full Name", "John Doe", nameCtrl),
                const SizedBox(height: 16),

                _input("Email address", "you@example.com", emailCtrl),
                const SizedBox(height: 16),

                _password(),
                const SizedBox(height: 16),

                _roleDropdown(),
                const SizedBox(height: 28),

                _createAccountButton(),
                const SizedBox(height: 24),

                _signinLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: const BoxDecoration(
              color: Color(0xFF818CF8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.work, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            "Cocpit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            "Connect. Grow. Get Hired.",
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _input(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _field(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _field(
          child: TextField(
            controller: passCtrl,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Create a strong password",
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none,
              suffixIcon:
              Icon(Icons.visibility_off, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _roleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("I am a", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _field(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedRole,
              dropdownColor: const Color(0xFF1F2937),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Colors.white),
              style: const TextStyle(color: Colors.white),
              items: roles
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (v) => setState(() => selectedRole = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : _createAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : const Text(
            "Create Account",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _signinLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(color: Colors.white70),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInScreen(),
                ),
              );
            },
            child: const Text(
              "Sign in",
              style: TextStyle(
                color: Color(0xFF818CF8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({required Widget child}) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: field,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
