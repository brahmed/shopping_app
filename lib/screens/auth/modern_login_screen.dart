import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../core/theme/app_theme.dart';

class ModernLoginScreen extends StatefulWidget {
  const ModernLoginScreen({Key? key}) : super(key: key);

  @override
  State<ModernLoginScreen> createState() => _ModernLoginScreenState();
}

class _ModernLoginScreenState extends State<ModernLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Implement actual login logic with Firebase
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      // Navigate to home
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _handleSocialLogin(String provider) async {
    setState(() => _isLoading = true);

    // TODO: Implement social login
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing32),

                  // Title
                  Text(
                    'Welcome Back',
                    style: AppTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.spacing8),

                  // Subtitle
                  Text(
                    'Sign in to continue shopping',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.spacing40),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: AppTheme.surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: BorderSide(color: AppTheme.gray300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: BorderSide(color: AppTheme.gray300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppTheme.spacing16),

                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      filled: true,
                      fillColor: AppTheme.surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: BorderSide(color: AppTheme.gray300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: BorderSide(color: AppTheme.gray300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppTheme.spacing12),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTheme.labelLarge.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing24),

                  // Login button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Sign In',
                              style: AppTheme.labelLarge.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing32),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppTheme.gray300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                        child: Text(
                          'or continue with',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppTheme.gray300)),
                    ],
                  ),

                  const SizedBox(height: AppTheme.spacing24),

                  // Social login buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          'Google',
                          Icons.g_mobiledata_rounded,
                          () => _handleSocialLogin('google'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: _buildSocialButton(
                          'Apple',
                          Icons.apple,
                          () => _handleSocialLogin('apple'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppTheme.spacing32),

                  // Sign up link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTheme.labelLarge.copyWith(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/signup');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: _isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppTheme.gray300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: AppTheme.textPrimary),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.labelLarge.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
