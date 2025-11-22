import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/colors.dart';
import '../../config/images.dart';
import '../../navigation/app_router.dart';
import '../../providers/cart_provider_riverpod.dart';
import '../../providers/products_provider_riverpod.dart';
import '../../widgets/buttons/app_filled_button.dart';
import '../../widgets/cards/category_card.dart';
import '../../widgets/cards/product_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final productsState = ref.watch(productsProvider);
    final l = AppLocalizations.of(context)!;

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
              flexibleSpace: Semantics(
                header: true,
                label: 'Home page app bar',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExcludeSemantics(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          appImage,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),

                    /// Cart icon
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButtonFilled(
                        height: 60,
                        width: 60,
                        radius: 15,
                        semanticLabel:
                            'Shopping cart with ${cartState.totalItemsCount} ${cartState.totalItemsCount == 1 ? "item" : "items"}',
                        semanticHint: 'Double tap to view shopping cart',
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart_sharp,
                                color: appBackgroundColorLight),
                            Text(
                              "${cartState.totalItemsCount}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: appBackgroundColorLight),
                            ),
                          ],
                        ),
                        onClick: () {
                          context.push(AppRoutes.cart);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ExcludeSemantics(child: const Divider()),
            ),

            /// Categories
            SliverToBoxAdapter(
              child: productsState.categories.isEmpty
                  ? const SizedBox.shrink()
                  : Semantics(
                      label: 'Product categories',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Semantics(
                              header: true,
                              child: Text(
                                l.categories,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                          ),
                          Semantics(
                            label: 'Horizontal scrollable list of categories',
                            hint:
                                'Swipe left or right to browse ${productsState.categories.length} categories',
                            child: SizedBox(
                              height: 110,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: productsState.categories.length,
                                itemBuilder: (context, index) {
                                  final category =
                                      productsState.categories[index];
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
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
            ),

            /// Products Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Semantics(
                  header: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Semantics(
                        header: true,
                        label: selectedCategory != null
                            ? 'Filtered Products section'
                            : 'All Products section',
                        child: Text(
                          selectedCategory != null
                              ? l.filteredProducts
                              : l.allProducts,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      if (selectedCategory != null)
                        Semantics(
                          label: 'Clear category filter',
                          hint: 'Double tap to show all products',
                          button: true,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = null;
                              });
                            },
                            child: Text(l.clearFilter),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            /// Products Grid
            if (productsState.isLoading)
              SliverFillRemaining(
                child: Semantics(
                  label: 'Loading products',
                  liveRegion: true,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (productsState.error != null)
              SliverFillRemaining(
                child: Semantics(
                  label: 'Error loading products: ${productsState.error}',
                  liveRegion: true,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExcludeSemantics(
                          child: const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        Semantics(
                          label: '${l.error}: ${productsState.error}',
                          child: Text('${l.error}: ${productsState.error}'),
                        ),
                        const SizedBox(height: 16),
                        Semantics(
                          label: 'Retry loading products',
                          hint: 'Double tap to reload products',
                          button: true,
                          child: ElevatedButton(
                            onPressed: () => ref
                                .read(productsProvider.notifier)
                                .loadProducts(),
                            child: Text(l.retry),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Builder(
                builder: (context) {
                  final products = selectedCategory != null
                      ? ref
                          .read(productsProvider.notifier)
                          .getProductsByCategory(selectedCategory!)
                      : productsState.products;

                  if (products.isEmpty) {
                    return SliverFillRemaining(
                      child: Semantics(
                        label: 'No products available',
                        liveRegion: true,
                        child: Center(
                          child: Text(l.noProductsAvailable),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: Semantics(
                      label:
                          'Products grid with ${products.length} ${products.length == 1 ? "product" : "products"}',
                      child: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Semantics(
                              sortKey: OrdinalSortKey(index.toDouble()),
                              child: ProductCard(product: products[index]),
                            );
                          },
                          childCount: products.length,
                        ),
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
