import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';
import '../../config/images.dart';
import '../../models/product_model.dart';
import '../../providers/products_provider.dart';
import '../../widgets/cards/app_card.dart';
import '../../widgets/cards/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  double? _minPrice;
  double? _maxPrice;

  void _onTextChangedSearch(String text) {
    setState(() {
      _searchQuery = text;
    });
  }

  void _cancelSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _selectedCategory = null;
      _minPrice = null;
      _maxPrice = null;
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final productsProvider = Provider.of<ProductsProvider>(context, listen: false);

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedCategory = null;
                              _minPrice = null;
                              _maxPrice = null;
                            });
                            setState(() {});
                          },
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Category Filter
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: productsProvider.categories.map((category) {
                        final isSelected = _selectedCategory == category.id;
                        return FilterChip(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              _selectedCategory = selected ? category.id : null;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Price Range
                    Text(
                      'Price Range',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('minPrice_${_minPrice}'),
                            initialValue: _minPrice?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Min Price',
                              prefixText: '\$',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setModalState(() {
                                _minPrice = double.tryParse(value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('maxPrice_${_maxPrice}'),
                            initialValue: _maxPrice?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Max Price',
                              prefixText: '\$',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setModalState(() {
                                _maxPrice = double.tryParse(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Apply Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Product> _getFilteredProducts(ProductsProvider productsProvider) {
    List<Product> products = productsProvider.products;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      products = products.where((product) {
        return product.name.toLowerCase().contains(lowerQuery) ||
            product.description.toLowerCase().contains(lowerQuery) ||
            product.brand.toLowerCase().contains(lowerQuery) ||
            product.category.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // Apply other filters
    return productsProvider.filterProducts(
      products: products,
      category: _selectedCategory,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Search bar
            AppCard(
              margin: 12,
              padding: 8,
              radius: 12,
              child: Row(
                children: [
                  /// Search Icon
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search, color: ColorsSet.grayLight),
                  ),

                  /// Search TextField
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onTextChangedSearch,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        hintText: "Search products...",
                        hintStyle: TextStyle(color: ColorsSet.grayLight),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(4.0),
                      ),
                    ),
                  ),

                  /// Clear Icon
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      onPressed: _cancelSearch,
                      icon: const Icon(Icons.clear),
                    ),

                  /// Filter Icon
                  IconButton(
                    onPressed: _showFilterDialog,
                    icon: Icon(
                      Icons.filter_list,
                      color: (_selectedCategory != null || _minPrice != null || _maxPrice != null)
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            /// Search Results
            Expanded(
              child: Consumer<ProductsProvider>(
                builder: (context, productsProvider, child) {
                  if (productsProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final filteredProducts = _getFilteredProducts(productsProvider);

                  if (_searchQuery.isEmpty && _selectedCategory == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            emptyBoxImage,
                            width: 200,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Search for products',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find exactly what you\'re looking for',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (filteredProducts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            emptyBoxImage,
                            width: 200,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'No products found',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
