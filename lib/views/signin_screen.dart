import 'package:flutter/material.dart';

import '../services/validator.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool keepLoggedIn = false;
  bool showPassword = false;
  bool isLoading = false;

  final AuthService _authService = AuthService();

  final LinearGradient appGradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  // ---------------- TEMP SIGN IN (MOCK) ----------------
  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => isLoading = true);

    final success = await _authService.login(
      email: emailCtrl.text.trim(),
      password: passCtrl.text.trim(),
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
      );
    } else {
      _showSnack("Login failed");
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30,
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _logoHeader(),
                  const SizedBox(height: 28),

                  const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Welcome back! Enter your details below.",
                    style: TextStyle(color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 24),

                  _input(
                    "Email address",
                    "Your email address",
                    Icons.email,
                    emailCtrl,
                    AppValidator.validateEmail,
                    TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  _passwordInput(),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: keepLoggedIn,
                        activeColor: const Color(0xFFEC4899),
                        onChanged: isLoading
                            ? null
                            : (v) =>
                            setState(() => keepLoggedIn = v!),
                      ),
                      const Text(
                        "Keep me logged in",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot password?",
                          style:
                          TextStyle(color: Color(0xFF7C83FF)),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 🔥 Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: InkWell(
                      onTap: isLoading ? null : _signInWithEmail,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: isLoading ? null : appGradient,
                          color: isLoading ? Colors.grey : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: const [
                      Expanded(
                          child:
                          Divider(color: Colors.white12)),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OR",
                          style:
                          TextStyle(color: Colors.white54),
                        ),
                      ),
                      Expanded(
                          child:
                          Divider(color: Colors.white12)),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: _socialBtn(
                            "GitHub", Icons.code, () {}),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _socialBtn("Google",
                            Icons.g_mobiledata, () {}),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style:
                          TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xFFEC4899),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _logoHeader() {
    return Column(
      children: const [
        Center(
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFF7C83FF),
            child: Icon(Icons.work, color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Cocpit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Connect. Grow. Get Hired.",
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  // ---------------- INPUTS ----------------
  Widget _input(
      String label,
      String hint,
      IconData icon,
      TextEditingController controller,
      String? Function(String?) validator,
      TextInputAction action,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          textInputAction: action,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white54),
            hintText: hint,
            hintStyle:
            const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF111827),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: passCtrl,
          obscureText: !showPassword,
          validator: AppValidator.validatePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _signInWithEmail(),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon:
            const Icon(Icons.lock, color: Colors.white54),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white54,
              ),
              onPressed: () =>
                  setState(() => showPassword = !showPassword),
            ),
            hintText: "Password",
            hintStyle:
            const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF111827),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialBtn(
      String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 6),
            Text(text,
                style:
                const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
