import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/images.dart';
import '../../providers/favorites_provider_riverpod.dart';
import '../../widgets/cards/product_card.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          if (!favoritesState.isEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Favorites'),
                    content: const Text(
                      'Are you sure you want to remove all favorites?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).clearFavorites();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Clear All'),
            ),
        ],
      ),
      body: SafeArea(
        child: favoritesState.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      emptyShelfImage,
                      width: 200,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No favorites yet',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add products to your favorites to see them here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: favoritesState.favorites.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: favoritesState.favorites[index]);
                },
              ),
      ),
    );
  }
}
