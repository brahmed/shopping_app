import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../screens/tab_pages/bookmarks_page.dart';
import '../../screens/tab_pages/home_page.dart';
import '../../screens/tab_pages/profile_page.dart';
import '../../screens/tab_pages/search_page.dart';
import 'home_page.dart';

class TabsManager extends StatefulWidget {
  const TabsManager({Key? key}) : super(key: key);

  @override
  State<TabsManager> createState() => _TabsManagerState();
}

class _TabsManagerState extends State<TabsManager> {
  /// Page controller
  final PageController _pageController = PageController(initialPage: 0);

  /// Current page index
  int _selectedIndex = 0;

  /// Tab pages
  final List<Widget> _tabPages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
    const ProfilePage()
  ];

  /// Tab page icons
  final List<IconData> _tabIcons = [
    Icons.home_outlined,
    Icons.search,
    Icons.favorite_outline,
    Icons.person_outline,
  ];

  /// On Item Tapped Handler
  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) => _tabPages.elementAt(index),
        onPageChanged: _onItemTapped,
        itemCount: _tabPages.length,
        controller: _pageController,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        navigationItems: List.generate(
          _tabPages.length,
          (index) => Container(
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? Theme.of(context).primaryColor
                  : null,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: IconButton(
              onPressed: () => _onItemTapped(index),
              icon: Icon(
                _tabIcons.elementAt(index),
                color: _selectedIndex == index ? Colors.white : Colors.grey,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Bottom Navigation Bar
class AppBottomNavigationBar extends StatelessWidget {
  final List<Widget> navigationItems;

  const AppBottomNavigationBar({required this.navigationItems, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: appContainersBackgroundColorLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: navigationItems,
      ),
    );
  }
}
