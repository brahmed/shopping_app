import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ModernForgotPasswordScreen extends StatefulWidget {
  const ModernForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ModernForgotPasswordScreen> createState() => _ModernForgotPasswordScreenState();
}

class _ModernForgotPasswordScreenState extends State<ModernForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Implement actual password reset logic with Firebase
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: _emailSent ? _buildSuccessView() : _buildFormView(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              size: 40,
              color: AppTheme.accentColor,
            ),
          ),

          const SizedBox(height: AppTheme.spacing32),

          // Title
          Text(
            'Forgot Password?',
            style: AppTheme.displayMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppTheme.spacing8),

          // Subtitle
          Text(
            'No worries, we\'ll send you reset instructions',
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

          const SizedBox(height: AppTheme.spacing24),

          // Reset button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleResetPassword,
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
                      'Reset Password',
                      style: AppTheme.labelLarge.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: AppTheme.spacing24),

          // Back to login
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Back to Sign In',
                    style: AppTheme.labelLarge.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Success icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 40,
            color: AppTheme.successColor,
          ),
        ),

        const SizedBox(height: AppTheme.spacing32),

        // Title
        Text(
          'Check Your Email',
          style: AppTheme.displayMedium,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppTheme.spacing8),

        // Subtitle
        Text(
          'We\'ve sent password reset instructions to',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppTheme.spacing8),

        // Email
        Text(
          _emailController.text,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppTheme.spacing40),

        // Info card
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.infoColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            border: Border.all(
              color: AppTheme.infoColor.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppTheme.infoColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Text(
                  'Didn\'t receive the email? Check your spam folder or try resending.',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppTheme.spacing32),

        // Resend button
        SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              setState(() => _emailSent = false);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: Text(
              'Resend Email',
              style: AppTheme.labelLarge.copyWith(
                color: AppTheme.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppTheme.spacing16),

        // Back to login
        SizedBox(
          height: 56,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: AppTheme.labelLarge.copyWith(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
