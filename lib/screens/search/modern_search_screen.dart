import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/product_model.dart';
import '../../widgets/common/modern_product_card.dart';

class ModernSearchScreen extends StatefulWidget {
  const ModernSearchScreen({Key? key}) : super(key: key);

  @override
  State<ModernSearchScreen> createState() => _ModernSearchScreenState();
}

class _ModernSearchScreenState extends State<ModernSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _isSearching = false;
  String _searchQuery = '';

  // TODO: Replace with actual data from provider
  final List<String> recentSearches = [
    'Running Shoes',
    'T-Shirts',
    'Wireless Headphones',
    'Smartwatch',
  ];

  final List<String> trendingSearches = [
    'Winter Jackets',
    'Yoga Pants',
    'Gaming Laptop',
    'Basketball Shoes',
    'Sunglasses',
  ];

  final List<Product> searchResults = [
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
  ];

  @override
  void initState() {
    super.initState();
    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });

    // TODO: Implement actual search logic
    if (query.isNotEmpty) {
      // Add to recent searches
      if (!recentSearches.contains(query)) {
        recentSearches.insert(0, query);
        if (recentSearches.length > 10) {
          recentSearches.removeLast();
        }
      }
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
    _searchFocusNode.requestFocus();
  }

  void _selectSearch(String query) {
    setState(() {
      _searchController.text = query;
      _handleSearch(query);
    });
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
        title: _buildSearchField(),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppTheme.textPrimary),
              onPressed: () => _showFilterSheet(),
            ),
        ],
      ),
      body: _isSearching && _searchQuery.isNotEmpty
          ? _buildSearchResults()
          : _buildSearchSuggestions(),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppTheme.gray100,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.textSecondary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: _handleSearch,
        onSubmitted: _handleSearch,
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: AppTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {
                    setState(() => recentSearches.clear());
                  },
                  child: Text(
                    'Clear',
                    style: AppTheme.labelMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            ...recentSearches.map((search) => _buildSearchItem(
                  search,
                  Icons.history,
                  () => _selectSearch(search),
                  onRemove: () {
                    setState(() => recentSearches.remove(search));
                  },
                )),
            const SizedBox(height: AppTheme.spacing24),
          ],

          // Trending searches
          Text(
            'Trending Searches',
            style: AppTheme.headlineSmall,
          ),
          const SizedBox(height: AppTheme.spacing12),
          ...trendingSearches.map((search) => _buildSearchItem(
                search,
                Icons.trending_up,
                () => _selectSearch(search),
              )),

          const SizedBox(height: AppTheme.spacing24),

          // Popular categories
          Text(
            'Popular Categories',
            style: AppTheme.headlineSmall,
          ),
          const SizedBox(height: AppTheme.spacing12),
          Wrap(
            spacing: AppTheme.spacing8,
            runSpacing: AppTheme.spacing8,
            children: [
              'Electronics',
              'Fashion',
              'Home & Garden',
              'Sports',
              'Beauty',
              'Books',
            ].map((category) => _buildCategoryChip(category)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchItem(
    String text,
    IconData icon,
    VoidCallback onTap, {
    VoidCallback? onRemove,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Text(
                text,
                style: AppTheme.bodyMedium,
              ),
            ),
            if (onRemove != null)
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppTheme.textSecondary,
                  size: 18,
                ),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return GestureDetector(
      onTap: () => _selectSearch(category),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: AppTheme.gray300),
        ),
        child: Text(
          category,
          style: AppTheme.labelMedium,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return _buildNoResults();
    }

    return Column(
      children: [
        // Results header
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          color: AppTheme.surfaceColor,
          child: Row(
            children: [
              Text(
                '${searchResults.length} Results',
                style: AppTheme.headlineSmall,
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showSortSheet(),
                icon: const Icon(Icons.sort, size: 18),
                label: const Text('Sort'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Results grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: AppTheme.spacing12,
              mainAxisSpacing: AppTheme.spacing12,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final product = searchResults[index];
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
          ),
        ),
      ],
    );
  }

  Widget _buildNoResults() {
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
                Icons.search_off,
                size: 60,
                color: AppTheme.textSecondary,
              ),
            ),

            const SizedBox(height: AppTheme.spacing24),

            Text(
              'No Results Found',
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppTheme.spacing8),

            Text(
              'Try adjusting your search or filters to find what you\'re looking for',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLarge)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacing16),
              ...[
                'Relevance',
                'Price: Low to High',
                'Price: High to Low',
                'Newest',
                'Best Rating',
                'Most Popular',
              ].map((option) => ListTile(
                    title: Text(option),
                    onTap: () {
                      // TODO: Implement sorting
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLarge)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: AppTheme.headlineMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          // Clear filters
                        },
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price Range',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing8),
                          // TODO: Add price range slider

                          const SizedBox(height: AppTheme.spacing24),

                          Text(
                            'Category',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing8),
                          // TODO: Add category checkboxes

                          const SizedBox(height: AppTheme.spacing24),

                          Text(
                            'Brand',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing8),
                          // TODO: Add brand checkboxes

                          const SizedBox(height: AppTheme.spacing24),

                          Text(
                            'Rating',
                            style: AppTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppTheme.spacing8),
                          // TODO: Add rating filter
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
