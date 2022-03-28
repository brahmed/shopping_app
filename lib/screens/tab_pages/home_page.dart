import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/images.dart';
import '../../widgets/buttons/app_filled_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Number of items in cart
  int cartItemsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Add the app bar to the CustomScrollView.
            SliverAppBar(
              floating: true,
              expandedHeight: 100.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              pinned: true,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    appImage,
                    color: Theme.of(context).iconTheme.color,
                  ),

                  /// Cart icon
                  Padding(
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
                            "$cartItemsCount",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: appBackgroundColorLight),
                          ),
                        ],
                      ),
                      onClick: () {},
                    ),
                  )
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Divider(),
            ),

            /// List
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 1000 ListTiles
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
