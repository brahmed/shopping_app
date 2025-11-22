import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/product_model.dart';
import '../../widgets/common/modern_product_card.dart';

class ModernWishlistScreen extends StatefulWidget {
  const ModernWishlistScreen({Key? key}) : super(key: key);

  @override
  State<ModernWishlistScreen> createState() => _ModernWishlistScreenState();
}

class _ModernWishlistScreenState extends State<ModernWishlistScreen> {
  // TODO: Replace with actual wishlist data from provider
  final List<Product> wishlistItems = [
    Product(
      id: '1',
      name: 'Modern Sneakers',
      price: 89.99,
      imageUrl: 'https://via.placeholder.com/300',
      description: 'Comfortable and stylish sneakers',
      category: 'Footwear',
      brand: 'Nike',
      inStock: true,
      rating: 4.5,
      reviewCount: 128,
    ),
    Product(
      id: '2',
      name: 'Classic T-Shirt',
      price: 29.99,
      imageUrl: 'https://via.placeholder.com/300',
      description: 'Premium cotton t-shirt',
      category: 'Clothing',
      brand: 'Adidas',
      inStock: true,
      rating: 4.2,
      reviewCount: 89,
    ),
  ];

  void _removeFromWishlist(String productId) {
    setState(() {
      wishlistItems.removeWhere((item) => item.id == productId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from wishlist'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _addToCart(Product product) {
    // TODO: Implement add to cart logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: AppTheme.successColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearWishlist() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        title: const Text('Clear Wishlist'),
        content: const Text('Are you sure you want to remove all items from your wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => wishlistItems.clear());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wishlist cleared'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
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
          'My Wishlist',
          style: AppTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          if (wishlistItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
              onPressed: _clearWishlist,
            ),
        ],
      ),
      body: wishlistItems.isEmpty ? _buildEmptyState() : _buildWishlistGrid(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.gray100,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              ),
              child: const Icon(
                Icons.favorite_outline,
                size: 60,
                color: AppTheme.textSecondary,
              ),
            ),

            const SizedBox(height: AppTheme.spacing24),

            Text(
              'Your Wishlist is Empty',
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppTheme.spacing8),

            Text(
              'Save items you love and we\'ll keep them here for you',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppTheme.spacing32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                ),
                child: Text(
                  'Start Shopping',
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

  Widget _buildWishlistGrid() {
    return Column(
      children: [
        // Header with item count
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          color: AppTheme.surfaceColor,
          child: Row(
            children: [
              Text(
                '${wishlistItems.length} ${wishlistItems.length == 1 ? 'Item' : 'Items'}',
                style: AppTheme.headlineSmall,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Move all to cart
                  for (var product in wishlistItems) {
                    _addToCart(product);
                  }
                },
                child: Text(
                  'Add All to Cart',
                  style: AppTheme.labelMedium.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Product grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: AppTheme.spacing12,
              mainAxisSpacing: AppTheme.spacing12,
            ),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final product = wishlistItems[index];
              return Stack(
                children: [
                  ModernProductCard(
                    product: product,
                    onTap: () {
                      // Navigate to product details
                      // Navigator.push(...);
                    },
                    onFavorite: () => _removeFromWishlist(product.id),
                    isFavorite: true,
                  ),
                  Positioned(
                    bottom: AppTheme.spacing8,
                    left: AppTheme.spacing8,
                    right: AppTheme.spacing8,
                    child: ElevatedButton.icon(
                      onPressed: () => _addToCart(product),
                      icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spacing8,
                        ),
                        textStyle: AppTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
