import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../models/product_model.dart';

class ModernProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ModernProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ModernProductDetailsScreen> createState() => _ModernProductDetailsScreenState();
}

class _ModernProductDetailsScreenState extends State<ModernProductDetailsScreen> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Product images
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: AppTheme.surfaceColor,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, size: 20),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: widget.product.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.gray100,
                    ),
                  ),
                ),
              ),

              // Product details
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.radiusXLarge),
                      topRight: Radius.circular(AppTheme.radiusXLarge),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacing24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand
                        Text(
                          widget.product.brand ?? '',
                          style: AppTheme.labelMedium.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacing8),

                        // Product name
                        Text(
                          widget.product.name,
                          style: AppTheme.displaySmall,
                        ),

                        const SizedBox(height: AppTheme.spacing12),

                        // Rating and reviews
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < widget.product.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 20,
                                  color: AppTheme.warningColor,
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.product.rating.toStringAsFixed(1)} (${widget.product.reviewCount} reviews)',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppTheme.spacing24),

                        // Price
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: AppTheme.displayMedium.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                        ),

                        const SizedBox(height: AppTheme.spacing24),

                        // Size selector
                        if (widget.product.sizes != null && widget.product.sizes!.isNotEmpty) ...[
                          Text(
                            'Size',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing12),
                          Wrap(
                            spacing: AppTheme.spacing8,
                            runSpacing: AppTheme.spacing8,
                            children: widget.product.sizes!.map((size) {
                              final isSelected = selectedSize == size;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
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
                                    border: Border.all(
                                      color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    size,
                                    style: AppTheme.labelMedium.copyWith(
                                      color: isSelected ? Colors.white : AppTheme.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: AppTheme.spacing24),
                        ],

                        // Color selector
                        if (widget.product.colors != null && widget.product.colors!.isNotEmpty) ...[
                          Text(
                            'Color',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing12),
                          Wrap(
                            spacing: AppTheme.spacing8,
                            runSpacing: AppTheme.spacing8,
                            children: widget.product.colors!.map((color) {
                              final isSelected = selectedColor == color;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = color;
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
                                    border: Border.all(
                                      color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    color,
                                    style: AppTheme.labelMedium.copyWith(
                                      color: isSelected ? Colors.white : AppTheme.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: AppTheme.spacing24),
                        ],

                        // Quantity selector
                        Text(
                          'Quantity',
                          style: AppTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        Row(
                          children: [
                            _buildQuantityButton(
                              Icons.remove,
                              () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                              child: Text(
                                quantity.toString(),
                                style: AppTheme.headlineMedium,
                              ),
                            ),
                            _buildQuantityButton(
                              Icons.add,
                              () => setState(() => quantity++),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppTheme.spacing32),

                        // Description
                        Text(
                          'Description',
                          style: AppTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        Text(
                          widget.product.description,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 100), // Space for bottom bar
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom action bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: widget.product.inStock ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.spacing16,
                          ),
                        ),
                        child: Text(
                          widget.product.inStock ? 'Add to Cart' : 'Out of Stock',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        decoration: BoxDecoration(
          color: AppTheme.gray100,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
