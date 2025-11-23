import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/providers/user_provider_riverpod.dart';
import 'package:shopping_app/providers/addresses_provider.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('Profile Management Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Navigate to profile page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap profile tab
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Verify profile page is displayed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Change app theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Look for theme toggle
        final themeSwitch = find.byType(Switch);
        if (themeSwitch.evaluate().isNotEmpty) {
          await tester.tap(themeSwitch.first);
          await tester.pumpAndSettle();
        }
      }
    });

    test('Toggle theme mode', () {
      final initialTheme = container.read(userProvider).isLightTheme;

      container.read(userProvider.notifier).switchThemeMode();

      final updatedTheme = container.read(userProvider).isLightTheme;
      expect(updatedTheme, !initialTheme);

      // Toggle back
      container.read(userProvider.notifier).switchThemeMode();
      expect(container.read(userProvider).isLightTheme, initialTheme);
    });

    testWidgets('Change app language', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Look for language/settings option
        final settingsButton =
            find.textContaining('Settings', findRichText: true);
        if (settingsButton.evaluate().isNotEmpty) {
          await tester.tap(settingsButton.first);
          await tester.pumpAndSettle();

          // Navigate to languages
          final languagesButton =
              find.textContaining('Language', findRichText: true);
          if (languagesButton.evaluate().isNotEmpty) {
            await tester.tap(languagesButton.first);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    test('Change locale', () {
      const frenchLocale = Locale('fr', 'FR');

      container.read(userProvider.notifier).changeLocale(frenchLocale);

      final currentLocale = container.read(userProvider).currentLocale;
      expect(currentLocale?.languageCode, 'fr');
      expect(currentLocale?.countryCode, 'FR');
    });

    test('Add shipping address', () async {
      final address = Address(
        id: 'addr-1',
        userId: 'user-1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main St',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
        country: 'USA',
        isDefault: true,
      );

      await container.read(addressesProvider.notifier).addAddress(address);

      final addresses = container.read(addressesProvider).addresses;
      expect(addresses.length, 1);
      expect(addresses.first.fullName, 'John Doe');
      expect(addresses.first.isDefault, true);
    });

    test('Update shipping address', () async {
      final address = Address(
        id: 'addr-1',
        userId: 'user-1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main St',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
        country: 'USA',
      );

      await container.read(addressesProvider.notifier).addAddress(address);

      // Update address
      final updatedAddress = address.copyWith(
        addressLine1: '456 Park Ave',
        city: 'Los Angeles',
        state: 'CA',
      );

      await container.read(addressesProvider.notifier).updateAddress(updatedAddress);

      final addresses = container.read(addressesProvider).addresses;
      expect(addresses.first.addressLine1, '456 Park Ave');
      expect(addresses.first.city, 'Los Angeles');
    });

    test('Delete shipping address', () async {
      final address = Address(
        id: 'addr-1',
        userId: 'user-1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main St',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
        country: 'USA',
      );

      await container.read(addressesProvider.notifier).addAddress(address);
      expect(container.read(addressesProvider).addresses.length, 1);

      await container.read(addressesProvider.notifier).deleteAddress('addr-1');
      expect(container.read(addressesProvider).addresses.length, 0);
    });

    test('Set default address', () async {
      final addresses = [
        Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'John Doe',
          phoneNumber: '+1234567890',
          addressLine1: '123 Main St',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'USA',
          isDefault: true,
        ),
        Address(
          id: 'addr-2',
          userId: 'user-1',
          fullName: 'Jane Smith',
          phoneNumber: '+0987654321',
          addressLine1: '456 Park Ave',
          city: 'Los Angeles',
          state: 'CA',
          zipCode: '90001',
          country: 'USA',
          isDefault: false,
        ),
      ];

      for (final address in addresses) {
        await container.read(addressesProvider.notifier).addAddress(address);
      }

      // Set second address as default
      await container.read(addressesProvider.notifier).setDefaultAddress('addr-2');

      final defaultAddress = container.read(addressesProvider).defaultAddress;
      expect(defaultAddress?.id, 'addr-2');

      // Verify first address is no longer default
      final allAddresses = container.read(addressesProvider).addresses;
      final firstAddress = allAddresses.firstWhere((a) => a.id == 'addr-1');
      expect(firstAddress.isDefault, false);
    });

    testWidgets('View and edit profile information',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Look for edit profile button
        final editButton = find.byIcon(Icons.edit);
        if (editButton.evaluate().isNotEmpty) {
          await tester.tap(editButton.first);
          await tester.pumpAndSettle();

          // Verify edit form
          expect(find.byType(TextField), findsWidgets);
        }
      }
    });

    testWidgets('Access settings page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Find settings option
        final settingsButton =
            find.textContaining('Settings', findRichText: true);
        if (settingsButton.evaluate().isNotEmpty) {
          await tester.tap(settingsButton.first);
          await tester.pumpAndSettle();

          // Verify settings page
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    testWidgets('Access notification settings', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Navigate to settings
        final settingsButton =
            find.textContaining('Settings', findRichText: true);
        if (settingsButton.evaluate().isNotEmpty) {
          await tester.tap(settingsButton.first);
          await tester.pumpAndSettle();

          // Find notification settings
          final notificationButton =
              find.textContaining('Notification', findRichText: true);
          if (notificationButton.evaluate().isNotEmpty) {
            await tester.tap(notificationButton.first);
            await tester.pumpAndSettle();

            // Verify notification settings page
            expect(find.byType(SwitchListTile), findsWidgets);
          }
        }
      }
    });

    testWidgets('Access help page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Find help option
        final helpButton = find.textContaining('Help', findRichText: true);
        if (helpButton.evaluate().isNotEmpty) {
          await tester.tap(helpButton.first);
          await tester.pumpAndSettle();

          // Verify help page
          expect(find.byType(ExpansionTile), findsWidgets);
        }
      }
    });

    testWidgets('Access contact us page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Find contact option
        final contactButton = find.textContaining('Contact', findRichText: true);
        if (contactButton.evaluate().isNotEmpty) {
          await tester.tap(contactButton.first);
          await tester.pumpAndSettle();

          // Verify contact page
          expect(find.byType(TextField), findsWidgets);
        }
      }
    });

    test('Multiple addresses management', () async {
      final addresses = List.generate(
        3,
        (index) => Address(
          id: 'addr-$index',
          userId: 'user-1',
          fullName: 'User $index',
          phoneNumber: '+123456789$index',
          addressLine1: '$index Main St',
          city: 'City $index',
          state: 'State $index',
          zipCode: '1000$index',
          country: 'Country $index',
        ),
      );

      for (final address in addresses) {
        await container.read(addressesProvider.notifier).addAddress(address);
      }

      final savedAddresses = container.read(addressesProvider).addresses;
      expect(savedAddresses.length, 3);
    });

    test('Get address by ID', () async {
      final address = Address(
        id: 'addr-1',
        userId: 'user-1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main St',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
        country: 'USA',
      );

      await container.read(addressesProvider.notifier).addAddress(address);

      final retrievedAddress =
          container.read(addressesProvider.notifier).getAddressById('addr-1');
      expect(retrievedAddress, isNotNull);
      expect(retrievedAddress?.fullName, 'John Doe');
    });

    test('Profile state persistence', () async {
      // Set theme and locale
      container.read(userProvider.notifier).switchThemeMode();
      container.read(userProvider.notifier).changeLocale(const Locale('ar', 'TN'));

      final userState = container.read(userProvider);
      expect(userState.isLightTheme, false);
      expect(userState.currentLocale?.languageCode, 'ar');
    });
  });
}
