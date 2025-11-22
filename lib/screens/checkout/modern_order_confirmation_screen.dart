import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../core/theme/app_theme.dart';

class ModernOrderConfirmationScreen extends StatefulWidget {
  const ModernOrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ModernOrderConfirmationScreen> createState() => _ModernOrderConfirmationScreenState();
}

class _ModernOrderConfirmationScreenState extends State<ModernOrderConfirmationScreen> {
  late ConfettiController _confettiController;

  // TODO: Get from actual order
  final String orderNumber = 'ORD-2025-11-22-001';
  final String estimatedDelivery = 'Nov 27, 2025';
  final double orderTotal = 150.98;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Show confetti after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing24),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Success icon
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppTheme.successColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.successColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacing32),

                            // Success message
                            Text(
                              'Order Placed!',
                              style: AppTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: AppTheme.spacing8),

                            Text(
                              'Your order has been successfully placed',
                              style: AppTheme.bodyLarge.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: AppTheme.spacing40),

                            // Order details card
                            Container(
                              padding: const EdgeInsets.all(AppTheme.spacing24),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceColor,
                                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildDetailRow(
                                    'Order Number',
                                    orderNumber,
                                    Icons.receipt_long_outlined,
                                  ),
                                  const SizedBox(height: AppTheme.spacing20),
                                  const Divider(color: AppTheme.gray200),
                                  const SizedBox(height: AppTheme.spacing20),
                                  _buildDetailRow(
                                    'Estimated Delivery',
                                    estimatedDelivery,
                                    Icons.local_shipping_outlined,
                                  ),
                                  const SizedBox(height: AppTheme.spacing20),
                                  const Divider(color: AppTheme.gray200),
                                  const SizedBox(height: AppTheme.spacing20),
                                  _buildDetailRow(
                                    'Order Total',
                                    '\$${orderTotal.toStringAsFixed(2)}',
                                    Icons.payments_outlined,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacing32),

                            // Info message
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
                                      'A confirmation email has been sent to your registered email address.',
                                      style: AppTheme.bodySmall.copyWith(
                                        color: AppTheme.textSecondary,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Action buttons
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to track order
                            Navigator.pushNamed(context, '/track-order');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Track Order',
                            style: AppTheme.labelLarge.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing12),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigate to home
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                          ),
                          child: Text(
                            'Continue Shopping',
                            style: AppTheme.labelLarge.copyWith(
                              color: AppTheme.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 3.14 / 2, // Down
                maxBlastForce: 5,
                minBlastForce: 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
                colors: const [
                  AppTheme.primaryColor,
                  AppTheme.accentColor,
                  AppTheme.successColor,
                  AppTheme.warningColor,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
