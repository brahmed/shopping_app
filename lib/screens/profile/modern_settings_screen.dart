import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ModernSettingsScreen extends StatefulWidget {
  const ModernSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ModernSettingsScreen> createState() => _ModernSettingsScreenState();
}

class _ModernSettingsScreenState extends State<ModernSettingsScreen> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = false;
  bool orderUpdates = true;
  bool promotions = false;
  bool darkMode = false;

  String selectedLanguage = 'English';
  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: AppTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications section
            Text(
              'Notifications',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildSwitchTile(
                'Push Notifications',
                'Receive push notifications',
                Icons.notifications_outlined,
                pushNotifications,
                (value) => setState(() => pushNotifications = value),
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildSwitchTile(
                'Email Notifications',
                'Receive email updates',
                Icons.email_outlined,
                emailNotifications,
                (value) => setState(() => emailNotifications = value),
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildSwitchTile(
                'SMS Notifications',
                'Receive SMS updates',
                Icons.sms_outlined,
                smsNotifications,
                (value) => setState(() => smsNotifications = value),
              ),
            ]),

            const SizedBox(height: AppTheme.spacing24),

            // Notification types
            Text(
              'Notification Types',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildSwitchTile(
                'Order Updates',
                'Get notified about order status',
                Icons.shopping_bag_outlined,
                orderUpdates,
                (value) => setState(() => orderUpdates = value),
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildSwitchTile(
                'Promotions & Offers',
                'Receive promotional offers',
                Icons.local_offer_outlined,
                promotions,
                (value) => setState(() => promotions = value),
              ),
            ]),

            const SizedBox(height: AppTheme.spacing24),

            // Appearance
            Text(
              'Appearance',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildSwitchTile(
                'Dark Mode',
                'Use dark theme',
                Icons.dark_mode_outlined,
                darkMode,
                (value) => setState(() => darkMode = value),
              ),
            ]),

            const SizedBox(height: AppTheme.spacing24),

            // Preferences
            Text(
              'Preferences',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildSelectTile(
                'Language',
                selectedLanguage,
                Icons.language_outlined,
                () => _showLanguageSelector(),
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildSelectTile(
                'Currency',
                selectedCurrency,
                Icons.attach_money_outlined,
                () => _showCurrencySelector(),
              ),
            ]),

            const SizedBox(height: AppTheme.spacing24),

            // Privacy & Security
            Text(
              'Privacy & Security',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildActionTile(
                'Privacy Policy',
                'View our privacy policy',
                Icons.privacy_tip_outlined,
                () {},
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildActionTile(
                'Terms of Service',
                'View terms and conditions',
                Icons.description_outlined,
                () {},
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildActionTile(
                'Change Password',
                'Update your password',
                Icons.lock_outline,
                () {},
              ),
            ]),

            const SizedBox(height: AppTheme.spacing24),

            // Data Management
            Text(
              'Data Management',
              style: AppTheme.headlineSmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildSettingsCard([
              _buildActionTile(
                'Clear Cache',
                'Free up storage space',
                Icons.cleaning_services_outlined,
                () => _showClearCacheDialog(),
              ),
              const Divider(height: 1, color: AppTheme.gray200),
              _buildActionTile(
                'Delete Account',
                'Permanently delete your account',
                Icons.delete_forever_outlined,
                () => _showDeleteAccountDialog(),
                isDestructive: true,
              ),
            ]),

            const SizedBox(height: AppTheme.spacing32),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
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

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectTile(
    String title,
    String value,
    IconData icon,
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
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                icon,
                color: AppTheme.accentColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
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
                color: (isDestructive ? AppTheme.errorColor : AppTheme.infoColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppTheme.errorColor : AppTheme.infoColor,
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
                      color: isDestructive ? AppTheme.errorColor : null,
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

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLarge)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacing16),
              ...[
                'English',
                'Spanish',
                'French',
                'German',
                'Arabic',
              ].map((lang) => ListTile(
                    title: Text(lang),
                    trailing: selectedLanguage == lang
                        ? const Icon(Icons.check, color: AppTheme.primaryColor)
                        : null,
                    onTap: () {
                      setState(() => selectedLanguage = lang);
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLarge)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Currency',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacing16),
              ...[
                'USD',
                'EUR',
                'GBP',
                'JPY',
                'AED',
              ].map((currency) => ListTile(
                    title: Text(currency),
                    trailing: selectedCurrency == currency
                        ? const Icon(Icons.check, color: AppTheme.primaryColor)
                        : null,
                    onTap: () {
                      setState(() => selectedCurrency = currency);
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data and free up storage space. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement clear cache logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement delete account logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
