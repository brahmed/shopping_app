import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';
import '../../config/images.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../screens/cart/cart_page.dart';
import '../../widgets/buttons/app_filled_button.dart';
import '../../widgets/cards/category_card.dart';
import '../../widgets/cards/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// App bar
            SliverAppBar(
              floating: true,
              expandedHeight: 100.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              pinned: true,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      appImage,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),

                  /// Cart icon
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppButtonFilled(
                          height: 60,
                          width: 60,
                          radius: 15,
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_sharp,
                                  color: appBackgroundColorLight),
                              Text(
                                "${cartProvider.totalItemsCount}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: appBackgroundColorLight),
                              ),
                            ],
                          ),
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Divider(),
            ),

            /// Categories
            SliverToBoxAdapter(
              child: Consumer<ProductsProvider>(
                builder: (context, productsProvider, child) {
                  if (productsProvider.categories.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: productsProvider.categories.length,
                          itemBuilder: (context, index) {
                            final category = productsProvider.categories[index];
                            return CategoryCard(
                              category: category,
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                      selectedCategory == category.id
                                          ? null
                                          : category.id;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),

            /// Products Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCategory != null ? 'Filtered Products' : 'All Products',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    if (selectedCategory != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = null;
                          });
                        },
                        child: const Text('Clear Filter'),
                      ),
                  ],
                ),
              ),
            ),

            /// Products Grid
            Consumer<ProductsProvider>(
              builder: (context, productsProvider, child) {
                if (productsProvider.isLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (productsProvider.error != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text('Error: ${productsProvider.error}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => productsProvider.loadProducts(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final products = selectedCategory != null
                    ? productsProvider.getProductsByCategory(selectedCategory!)
                    : productsProvider.products;

                if (products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No products available'),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(product: products[index]);
                      },
                      childCount: products.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
