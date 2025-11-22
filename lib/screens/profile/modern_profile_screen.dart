import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ModernProfileScreen extends StatelessWidget {
  const ModernProfileScreen({Key? key}) : super(key: key);

  // TODO: Replace with actual user data
  static const String userName = 'John Doe';
  static const String userEmail = 'john.doe@example.com';
  static const String userAvatar = 'https://via.placeholder.com/120';
  static const int orderCount = 24;
  static const int pointsBalance = 1250;
  static const int wishlistCount = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App bar with profile header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: AppTheme.gray200,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacing12),

                      // Name
                      Text(
                        userName,
                        style: AppTheme.headlineLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Email
                      Text(
                        userEmail,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile/edit');
                },
              ),
            ],
          ),

          // Stats cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Orders',
                      orderCount.toString(),
                      Icons.shopping_bag_outlined,
                      AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildStatCard(
                      'Points',
                      pointsBalance.toString(),
                      Icons.star_outline,
                      AppTheme.warningColor,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildStatCard(
                      'Wishlist',
                      wishlistCount.toString(),
                      Icons.favorite_outline,
                      AppTheme.errorColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu list
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: AppTheme.headlineSmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildMenuCard([
                    _buildMenuItem(
                      'My Orders',
                      'View order history',
                      Icons.receipt_long_outlined,
                      AppTheme.accentColor,
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'Addresses',
                      'Manage shipping addresses',
                      Icons.location_on_outlined,
                      AppTheme.successColor,
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'Payment Methods',
                      'Manage payment cards',
                      Icons.credit_card_outlined,
                      AppTheme.primaryColor,
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'Wishlist',
                      'Your saved items',
                      Icons.favorite_outline,
                      AppTheme.errorColor,
                      () {
                        Navigator.pushNamed(context, '/wishlist');
                      },
                    ),
                  ]),

                  const SizedBox(height: AppTheme.spacing24),

                  Text(
                    'Preferences',
                    style: AppTheme.headlineSmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildMenuCard([
                    _buildMenuItem(
                      'Settings',
                      'App preferences',
                      Icons.settings_outlined,
                      AppTheme.textSecondary,
                      () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'Notifications',
                      'Manage notifications',
                      Icons.notifications_outlined,
                      AppTheme.warningColor,
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'Language',
                      'English',
                      Icons.language_outlined,
                      AppTheme.infoColor,
                      () {},
                    ),
                  ]),

                  const SizedBox(height: AppTheme.spacing24),

                  Text(
                    'Support',
                    style: AppTheme.headlineSmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildMenuCard([
                    _buildMenuItem(
                      'Help Center',
                      'FAQs and support',
                      Icons.help_outline,
                      AppTheme.infoColor,
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.gray200),
                    _buildMenuItem(
                      'About',
                      'App version 1.0.0',
                      Icons.info_outline,
                      AppTheme.textSecondary,
                      () {},
                    ),
                  ]),

                  const SizedBox(height: AppTheme.spacing24),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.errorColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: AppTheme.errorColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: AppTheme.labelLarge.copyWith(
                              color: AppTheme.errorColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            value,
            style: AppTheme.headlineMedium,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.labelLarge.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout logic
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
