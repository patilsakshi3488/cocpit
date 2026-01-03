import 'package:flutter/material.dart';
import '../../services/validator.dart';
import '../../services/auth_service.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../feed/home_screen.dart';

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
  bool isPasswordVisible = false;
  bool isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => isLoading = true);

    try {
      final success = await _authService.login(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (!mounted) return;
      
      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        _showSnack("Invalid email or password");
      }
    } catch (e) {
      _showSnack("Server connection failed");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogoSection(theme),
                  const SizedBox(height: 48),
                  Text(
                    "Sign in",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Welcome back! Enter your details below.",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 36),
                  
                  _fieldLabel(theme, "Email address"),
                  _buildTextField(
                    theme: theme,
                    controller: emailCtrl,
                    hint: "you@example.com",
                    validator: AppValidator.validateEmail,
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 24),
                  
                  _fieldLabel(theme, "Password"),
                  _buildTextField(
                    theme: theme,
                    controller: passCtrl,
                    hint: "Enter your password",
                    obscureText: !isPasswordVisible,
                    validator: AppValidator.validatePassword,
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: theme.textTheme.bodySmall?.color,
                        size: 20,
                      ),
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  _buildOptionsRow(theme),
                  
                  const SizedBox(height: 48),
                  _buildSubmitButton(theme),
                  
                  const SizedBox(height: 32),
                  _buildOrDivider(theme),
                  
                  const SizedBox(height: 24),
                  _buildSocialButtons(theme),
                  
                  const SizedBox(height: 32),
                  _buildSignupFooter(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(ThemeData theme) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.business_center_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 14),
        Text(
          "Cocpit",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.textTheme.titleLarge?.color,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required ThemeData theme,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(icon, color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6), size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _buildOptionsRow(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: keepLoggedIn,
            activeColor: theme.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (v) => setState(() => keepLoggedIn = v!),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "Keep me logged in",
          style: theme.textTheme.bodySmall,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
            );
          },
          child: Text(
            "Forgot password?",
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor.withValues(alpha: 0.8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24, width: 24, 
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              )
            : const Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildOrDivider(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: Divider(color: theme.dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("OR", style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Divider(color: theme.dividerColor)),
      ],
    );
  }

  Widget _buildSocialButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: _socialBtn(theme, "GitHub", Icons.code_rounded)),
        const SizedBox(width: 16),
        Expanded(child: _socialBtn(theme, "Google", Icons.g_mobiledata_rounded)),
      ],
    );
  }

  Widget _socialBtn(ThemeData theme, String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 24, color: theme.iconTheme.color),
      label: Text(label, style: theme.textTheme.bodyLarge),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.dividerColor),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSignupFooter(ThemeData theme) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: theme.textTheme.bodyMedium,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
