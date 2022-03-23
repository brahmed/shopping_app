import 'package:flutter/material.dart';

import '../../config/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                  ),
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
