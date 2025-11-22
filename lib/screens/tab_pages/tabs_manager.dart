import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/colors.dart';
import '../../providers/user_provider_riverpod.dart';
import '../../screens/tab_pages/bookmarks_page_riverpod.dart';
import '../../screens/tab_pages/home_page_riverpod.dart';
import '../../screens/tab_pages/profile_page.dart';
import '../../screens/tab_pages/search_page_riverpod.dart';

class TabsManager extends ConsumerStatefulWidget {
  const TabsManager({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsManager> createState() => _TabsManagerState();
}

class _TabsManagerState extends ConsumerState<TabsManager> {
  /// Page controller
  final PageController _pageController = PageController(initialPage: 0);

  /// Current page index
  int _selectedIndex = 0;

  /// Logged in user Tabs
  final List<Widget> _loggedUserTabsPages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
    const ProfilePage()
  ];

  final List<IconData> _loggedUserTabsIcons = [
    Icons.home_outlined,
    Icons.search,
    Icons.favorite_outline,
    Icons.person_outline
  ];

  final List<String> _loggedUserTabsLabels = [
    'Home',
    'Search',
    'Bookmarks',
    'Profile'
  ];

  /// Logged in user Tab pages
  final List<Widget> _unLoggedUserTabsPages = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage()
  ];

  final List<IconData> _unLoggedUserTabsIcons = [
    Icons.home_outlined,
    Icons.search,
    Icons.person_outline
  ];

  final List<String> _unLoggedUserTabsLabels = [
    'Home',
    'Search',
    'Profile'
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
    final userState = ref.watch(userProvider);
    final isUserLogged = userState.isUserLogged;

    return Scaffold(
      body: isUserLogged
          ? tabsPageView(_loggedUserTabsPages)
          : tabsPageView(_unLoggedUserTabsPages),
      bottomNavigationBar: isUserLogged
          ? tabsNavigationBar(_loggedUserTabsIcons, _loggedUserTabsLabels)
          : tabsNavigationBar(_unLoggedUserTabsIcons, _unLoggedUserTabsLabels),
    );
  }

  Widget tabsPageView(List<Widget> pages) => Semantics(
        label: 'Main content area',
        child: PageView.builder(
          itemBuilder: (context, index) => pages.elementAt(index),
          onPageChanged: _onItemTapped,
          itemCount: pages.length,
          controller: _pageController,
        ),
      );

  Widget tabsNavigationBar(List<IconData> tabsIcons, List<String> tabsLabels) =>
      AppBottomNavigationBar(
        navigationItems: List.generate(
          tabsIcons.length,
          (index) => Semantics(
            label: '${tabsLabels[index]} tab',
            hint: _selectedIndex == index
                ? 'Selected, ${tabsLabels[index]} tab'
                : 'Double tap to switch to ${tabsLabels[index]} tab',
            selected: _selectedIndex == index,
            button: true,
            child: Container(
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : null,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: IconButton(
                onPressed: () => _onItemTapped(index),
                icon: ExcludeSemantics(
                  child: Icon(
                    tabsIcons.elementAt(index),
                    color: _selectedIndex == index ? Colors.white : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
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
