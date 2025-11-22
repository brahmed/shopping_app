import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class OrderItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String? size;
  final String? color;

  OrderItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.size,
    this.color,
  });

  double get total => price * quantity;
}

class ModernOrderReviewScreen extends StatefulWidget {
  const ModernOrderReviewScreen({Key? key}) : super(key: key);

  @override
  State<ModernOrderReviewScreen> createState() => _ModernOrderReviewScreenState();
}

class _ModernOrderReviewScreenState extends State<ModernOrderReviewScreen> {
  bool _isLoading = false;

  // TODO: Replace with actual data
  final List<OrderItem> items = [
    OrderItem(
      name: 'Modern Sneakers',
      imageUrl: 'https://via.placeholder.com/80',
      price: 89.99,
      quantity: 1,
      size: 'US 10',
      color: 'White',
    ),
    OrderItem(
      name: 'Classic T-Shirt',
      imageUrl: 'https://via.placeholder.com/80',
      price: 29.99,
      quantity: 2,
      size: 'L',
      color: 'Black',
    ),
  ];

  final String shippingAddress = '123 Main Street, Apt 4B\nNew York, NY 10001\nUnited States';
  final String paymentMethod = '**** **** **** 9012';
  final double shipping = 9.99;
  final double tax = 15.00;

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get total => subtotal + shipping + tax;

  Future<void> _handlePlaceOrder() async {
    setState(() => _isLoading = true);

    // TODO: Implement actual order placement logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/checkout/confirmation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Review',
          style: AppTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(3),

          // Order details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Items section
                  _buildSectionHeader('Order Items', items.length),
                  const SizedBox(height: AppTheme.spacing12),
                  ...items.map((item) => _buildOrderItem(item)).toList(),

                  const SizedBox(height: AppTheme.spacing24),

                  // Shipping address section
                  _buildSectionHeader('Shipping Address', null),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildInfoCard(
                    Icons.location_on_outlined,
                    shippingAddress,
                    onEdit: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: AppTheme.spacing16),

                  // Payment method section
                  _buildSectionHeader('Payment Method', null),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildInfoCard(
                    Icons.credit_card_outlined,
                    'Visa $paymentMethod',
                    onEdit: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: AppTheme.spacing24),

                  // Price breakdown
                  _buildPriceBreakdown(),

                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),

          // Bottom bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    final steps = ['Address', 'Payment', 'Review'];

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      color: AppTheme.surfaceColor,
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep - 1;
          final isCompleted = index < currentStep - 1;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive ? AppTheme.primaryColor : AppTheme.gray200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(Icons.check, color: Colors.white, size: 18)
                              : Text(
                                  '${index + 1}',
                                  style: AppTheme.labelMedium.copyWith(
                                    color: isActive ? Colors.white : AppTheme.textSecondary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[index],
                        style: AppTheme.bodySmall.copyWith(
                          color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: isCompleted ? AppTheme.primaryColor : AppTheme.gray200,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int? count) {
    return Row(
      children: [
        Text(
          title,
          style: AppTheme.headlineSmall,
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: AppTheme.labelSmall.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.gray100,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: AppTheme.textSecondary,
            ),
          ),

          const SizedBox(width: AppTheme.spacing12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if (item.size != null || item.color != null)
                  Text(
                    [
                      if (item.size != null) item.size,
                      if (item.color != null) item.color,
                    ].join(' • '),
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item.quantity}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Price
          Text(
            '\$${item.total.toStringAsFixed(2)}',
            style: AppTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text, {VoidCallback? onEdit}) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Text(
              text,
              style: AppTheme.bodyMedium,
            ),
          ),
          if (onEdit != null)
            TextButton(
              onPressed: onEdit,
              child: Text(
                'Edit',
                style: AppTheme.labelMedium.copyWith(
                  color: AppTheme.accentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', subtotal),
          const SizedBox(height: AppTheme.spacing12),
          _buildPriceRow('Shipping', shipping),
          const SizedBox(height: AppTheme.spacing12),
          _buildPriceRow('Tax', tax),
          const SizedBox(height: AppTheme.spacing16),
          const Divider(color: AppTheme.gray300),
          const SizedBox(height: AppTheme.spacing16),
          _buildPriceRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTheme.headlineMedium
              : AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? AppTheme.headlineMedium.copyWith(
                  color: AppTheme.primaryColor,
                )
              : AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTheme.headlineMedium,
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTheme.headlineMedium.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handlePlaceOrder,
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
                        'Place Order',
                        style: AppTheme.labelLarge.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
