import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/cart_provider_riverpod.dart';
import '../../models/cart_item_model.dart';

class ModernCartScreen extends ConsumerWidget {
  const ModernCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Shopping Cart'),
            if (cartState.items.isNotEmpty)
              Text(
                '${cartState.items.length} ${cartState.items.length == 1 ? 'item' : 'items'}',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
          ],
        ),
        actions: [
          if (cartState.items.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
              },
              child: const Text('Clear'),
            ),
        ],
      ),
      body: cartState.items.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    itemCount: cartState.items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppTheme.spacing12),
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return _buildCartItem(context, ref, item);
                    },
                  ),
                ),
                _buildCheckoutSection(context, cartState),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: AppTheme.gray300,
          ),
          const SizedBox(height: AppTheme.spacing24),
          Text(
            'Your cart is empty',
            style: AppTheme.headlineMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Add items to get started',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textTertiary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing32),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, WidgetRef ref, CartItem item) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            child: CachedNetworkImage(
              imageUrl: item.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.gray100,
              ),
            ),
          ),

          const SizedBox(width: AppTheme.spacing12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacing4),
                if (item.selectedSize != null || item.selectedColor != null)
                  Text(
                    [
                      if (item.selectedSize != null) 'Size: ${item.selectedSize}',
                      if (item.selectedColor != null) 'Color: ${item.selectedColor}',
                    ].join(' • '),
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                  ),
                const SizedBox(height: AppTheme.spacing8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: AppTheme.headlineSmall.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    // Quantity controls
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.gray100,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      ),
                      child: Row(
                        children: [
                          _buildQuantityButton(
                            Icons.remove,
                            () {
                              if (item.quantity > 1) {
                                ref.read(cartProvider.notifier).updateQuantity(
                                      item.id,
                                      item.quantity - 1,
                                    );
                              } else {
                                ref.read(cartProvider.notifier).removeFromCart(item.id);
                              }
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing12,
                            ),
                            child: Text(
                              item.quantity.toString(),
                              style: AppTheme.labelMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            Icons.add,
                            () {
                              ref.read(cartProvider.notifier).updateQuantity(
                                    item.id,
                                    item.quantity + 1,
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete button
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {
              ref.read(cartProvider.notifier).removeFromCart(item.id);
            },
            color: AppTheme.textTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing8),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartState cartState) {
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
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '\$${cartState.subtotal.toStringAsFixed(2)}',
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.spacing8),

            // Shipping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  'FREE',
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.successColor,
                  ),
                ),
              ],
            ),

            const Divider(height: AppTheme.spacing24),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTheme.headlineMedium,
                ),
                Text(
                  '\$${cartState.total.toStringAsFixed(2)}',
                  style: AppTheme.headlineLarge.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.spacing16),

            // Checkout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to checkout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacing16,
                  ),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
