import 'package:flutter/widgets.dart';

import '../../screens/login.dart';
import '../../screens/profile/contact_us_page.dart';
import '../../screens/profile/help_page.dart';
import '../../screens/profile/settings_page.dart';
import '../../screens/tab_pages/bookmarks_page.dart';
import '../../screens/tab_pages/home_page.dart';
import '../../screens/tab_pages/profile_page.dart';
import '../../screens/tab_pages/search_page.dart';
import '../../screens/tab_pages/tabs_manager.dart';

class Routes {
  static String tabs = "/tabs";
  static String home = "/home";
  static String search = "/search";
  static String bookmarks = "/bookmarks";
  static String profile = "/profile";

  static String help = "/help";
  static String contact = "/contact";
  static String settings = "/settings";

  static String login = "/login";
  static String register = "/register";

  static Map<String, WidgetBuilder> routes() => {
        /// Tabs Screens
        tabs: (context) => const TabsManager(),
        home: (context) => const HomePage(),
        search: (context) => const SearchPage(),
        bookmarks: (context) => const BookmarksPage(),
        profile: (context) => const ProfilePage(),

        /// Profile
        help: (context) => const HelpPage(),
        contact: (context) => const ContactUsPage(),
        settings: (context) => const SettingsPage(),

        /// Auth
        login: (context) => const LoginPage(),
      };
}
