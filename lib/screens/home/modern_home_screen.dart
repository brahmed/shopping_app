import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/products_provider_riverpod.dart';
import '../../widgets/common/modern_product_card.dart';

class ModernHomeScreen extends ConsumerStatefulWidget {
  const ModernHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends ConsumerState<ModernHomeScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Modern app bar
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: AppTheme.surfaceColor,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: AppTheme.displaySmall.copyWith(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Find your perfect product',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {
                  // Navigate to search
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {
                  // Navigate to wishlist
                },
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Category chips
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.surfaceColor,
              padding: const EdgeInsets.only(
                left: AppTheme.spacing16,
                right: AppTheme.spacing16,
                bottom: AppTheme.spacing16,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('All', true),
                    _buildCategoryChip('Electronics', false),
                    _buildCategoryChip('Fashion', false),
                    _buildCategoryChip('Home', false),
                    _buildCategoryChip('Sports', false),
                  ],
                ),
              ),
            ),
          ),

          // Product grid
          if (productsState.isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (productsState.products.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: AppTheme.gray300,
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    Text(
                      'No products found',
                      style: AppTheme.headlineMedium.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: AppTheme.spacing12,
                  mainAxisSpacing: AppTheme.spacing12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = productsState.products[index];
                    return ModernProductCard(
                      product: product,
                      onTap: () {
                        // Navigate to product details
                      },
                      onFavorite: () {
                        // Toggle favorite
                      },
                      isFavorite: false,
                    );
                  },
                  childCount: productsState.products.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: AppTheme.spacing8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing20,
            vertical: AppTheme.spacing12,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : AppTheme.gray100,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Text(
            label,
            style: AppTheme.labelMedium.copyWith(
              color: isSelected ? Colors.white : AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
