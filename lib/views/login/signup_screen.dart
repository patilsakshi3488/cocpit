import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../services/secure_storage.dart';
import '../feed/home_screen.dart';
import 'signin_screen.dart';

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
    'User',
    'Employer',
  ];

  bool isLoading = false;
  bool isPasswordVisible = false;

  String _mapAccountType(String role) {
    return role == 'Employer' ? 'Employer' : 'User';
  }

  Future<void> _createAccount() async {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        passCtrl.text.isEmpty) {
      _showMsg("All fields are required");
      return;
    }

    if (selectedRole == 'Select your role') {
      _showMsg("Please select your role");
      return;
    }

    try {
      setState(() => isLoading = true);

      final url =
      Uri.parse("http://192.168.1.2:5000/api/auth/register");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": nameCtrl.text.trim(),
          "email": emailCtrl.text.trim().toLowerCase(),
          "password": passCtrl.text.trim(),
          "accountType": _mapAccountType(selectedRole),
        }),
      );

      final body =
      response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Save tokens (professional mobile flow)
        if (body?['accessToken'] != null) {
          await SecureStorage.saveAccessToken(body['accessToken']);
        }

        if (body?['refreshToken'] != null) {
          await SecureStorage.saveRefreshToken(body['refreshToken']);
        }

        _showMsg("Account created successfully");

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
              (_) => false,
        );
      } else {
        _showMsg(body?['message'] ?? "Signup failed");
      }
    } catch (e) {
      debugPrint("Signup error: $e");
      _showMsg("Server error. Please try again.");
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
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create your account",
                  style: theme.textTheme.headlineSmall),
              const SizedBox(height: 32),

              _field("Full Name", nameCtrl),
              _field("Email", emailCtrl),
              _field("Password", passCtrl,
                  obscure: !isPasswordVisible,
                  suffix: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                  )),

              const SizedBox(height: 16),
              _roleDropdown(theme),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _createAccount,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Create Account"),
                ),
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SignInScreen()),
                  );
                },
                child: const Text("Already have an account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl,
      {bool obscure = false, Widget? suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _roleDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      items: roles
          .map((r) => DropdownMenuItem(value: r, child: Text(r)))
          .toList(),
      onChanged: (v) => setState(() => selectedRole = v!),
      decoration: const InputDecoration(labelText: "I am a"),
    );
  }
}
