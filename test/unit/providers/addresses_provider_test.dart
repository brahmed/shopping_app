import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/addresses_provider.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('AddressesProvider Tests', () {
    late ProviderContainer container;
    late Address testAddress1;
    late Address testAddress2;
    late Address testAddress3;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testAddress1 = Address(
        id: 'addr1',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '1234567890',
        addressLine1: '123 Main St',
        addressLine2: 'Apt 4B',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
        landmark: 'Near Central Park',
        isDefault: true,
        type: AddressType.home,
      );

      testAddress2 = Address(
        id: 'addr2',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '1234567890',
        addressLine1: '456 Office Blvd',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10002',
        isDefault: false,
        type: AddressType.work,
      );

      testAddress3 = Address(
        id: 'addr3',
        userId: 'user1',
        fullName: 'Jane Doe',
        phoneNumber: '0987654321',
        addressLine1: '789 Other St',
        city: 'Boston',
        state: 'MA',
        country: 'USA',
        zipCode: '02101',
        type: AddressType.other,
      );

      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(addressesProvider);

        expect(state.addresses, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
        expect(state.hasAddresses, false);
        expect(state.defaultAddress, isNull);
      });
    });

    group('Add Address', () {
      test('should add address', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.length, 1);
        expect(state.addresses.first.id, testAddress1.id);
      });

      test('should set first address as default', () async {
        final notifier = container.read(addressesProvider.notifier);

        final nonDefaultAddress = testAddress1.copyWith(isDefault: false);
        await notifier.addAddress(nonDefaultAddress);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.first.isDefault, true);
      });

      test('should unmark other addresses when adding default', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // default
        await Future.delayed(const Duration(milliseconds: 50));

        final newDefaultAddress = testAddress2.copyWith(isDefault: true);
        await notifier.addAddress(newDefaultAddress);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.where((a) => a.isDefault).length, 1);
        expect(state.addresses.last.isDefault, true);
      });

      test('should add multiple addresses', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await notifier.addAddress(testAddress2);
        await notifier.addAddress(testAddress3);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(addressesProvider);
        expect(state.addresses.length, 3);
      });
    });

    group('Update Address', () {
      test('should update address', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 50));

        final updatedAddress = testAddress1.copyWith(
          addressLine1: '999 Updated St',
        );

        await notifier.updateAddress(updatedAddress);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.first.addressLine1, '999 Updated St');
      });

      test('should handle setting address as default', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // default
        await notifier.addAddress(testAddress2); // not default
        await Future.delayed(const Duration(milliseconds: 100));

        final updatedAddress2 = testAddress2.copyWith(isDefault: true);
        await notifier.updateAddress(updatedAddress2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        // Only one should be default
        expect(state.addresses.where((a) => a.isDefault).length, 1);
        expect(state.addresses.last.isDefault, true);
      });
    });

    group('Delete Address', () {
      test('should delete address', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.deleteAddress(testAddress1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses, isEmpty);
      });

      test('should set new default when deleting default address', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // default
        await notifier.addAddress(testAddress2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.deleteAddress(testAddress1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.length, 1);
        expect(state.addresses.first.isDefault, true);
      });

      test('should delete correct address from multiple', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await notifier.addAddress(testAddress2);
        await notifier.addAddress(testAddress3);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.deleteAddress(testAddress2.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.length, 2);
        expect(state.addresses.any((a) => a.id == testAddress2.id), false);
      });
    });

    group('Set Default Address', () {
      test('should set address as default', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await notifier.addAddress(testAddress2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.setDefaultAddress(testAddress2.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.where((a) => a.isDefault).length, 1);
        expect(
            state.addresses.firstWhere((a) => a.id == testAddress2.id).isDefault,
            true);
      });

      test('should unmark previous default', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // default
        await notifier.addAddress(testAddress2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.setDefaultAddress(testAddress2.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(
            state.addresses.firstWhere((a) => a.id == testAddress1.id).isDefault,
            false);
      });
    });

    group('Get Address By ID', () {
      test('should get address by ID', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 50));

        final address = notifier.getAddressById(testAddress1.id);

        expect(address, isNotNull);
        expect(address?.id, testAddress1.id);
      });

      test('should return null for non-existent ID', () {
        final notifier = container.read(addressesProvider.notifier);

        final address = notifier.getAddressById('non_existent');

        expect(address, isNull);
      });
    });

    group('Get Addresses By Type', () {
      test('should filter addresses by type', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // home
        await notifier.addAddress(testAddress2); // work
        await notifier.addAddress(testAddress3); // other
        await Future.delayed(const Duration(milliseconds: 100));

        final homeAddresses =
            notifier.getAddressesByType(AddressType.home);
        final workAddresses =
            notifier.getAddressesByType(AddressType.work);

        expect(homeAddresses.length, 1);
        expect(workAddresses.length, 1);
        expect(homeAddresses.first.type, AddressType.home);
        expect(workAddresses.first.type, AddressType.work);
      });
    });

    group('State Getters', () {
      test('should get default address', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1); // default
        await notifier.addAddress(testAddress2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(addressesProvider);
        expect(state.defaultAddress, isNotNull);
        expect(state.defaultAddress?.id, testAddress1.id);
      });

      test('should return first address if no default set', () async {
        final notifier = container.read(addressesProvider.notifier);

        final addr1NoDefault = testAddress1.copyWith(isDefault: false);
        final addr2NoDefault = testAddress2.copyWith(isDefault: false);

        await notifier.addAddress(addr1NoDefault);
        await notifier.addAddress(addr2NoDefault);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(addressesProvider);
        expect(state.defaultAddress, isNotNull);
      });

      test('should check hasAddresses', () async {
        final notifier = container.read(addressesProvider.notifier);

        expect(container.read(addressesProvider).hasAddresses, false);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(addressesProvider).hasAddresses, true);
      });
    });

    group('Persistence', () {
      test('should save addresses to SharedPreferences', () async {
        final notifier = container.read(addressesProvider.notifier);

        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('user_addresses'), isNotNull);
      });

      test('should load addresses from SharedPreferences', () async {
        final notifier = container.read(addressesProvider.notifier);
        await notifier.addAddress(testAddress1);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(addressesProvider);
        expect(state.addresses, isNotEmpty);
      });
    });

    group('Address Model', () {
      test('should generate full address string', () {
        final fullAddress = testAddress1.fullAddress;

        expect(fullAddress, contains('123 Main St'));
        expect(fullAddress, contains('Apt 4B'));
        expect(fullAddress, contains('New York'));
        expect(fullAddress, contains('Near Central Park'));
      });

      test('should handle address without optional fields', () {
        final minimalAddress = Address(
          id: 'addr_min',
          userId: 'user1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Street',
          city: 'City',
          state: 'State',
          country: 'Country',
          zipCode: '12345',
        );

        final fullAddress = minimalAddress.fullAddress;
        expect(fullAddress, isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle many addresses', () async {
        final notifier = container.read(addressesProvider.notifier);

        for (int i = 0; i < 50; i++) {
          final address = Address(
            id: 'addr_$i',
            userId: 'user1',
            fullName: 'User $i',
            phoneNumber: '123456789$i',
            addressLine1: '$i Street',
            city: 'City',
            state: 'State',
            country: 'Country',
            zipCode: '1000$i',
          );
          await notifier.addAddress(address);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(addressesProvider);
        expect(state.addresses.length, 50);
      });

      test('should handle address with very long fields', () async {
        final notifier = container.read(addressesProvider.notifier);

        final longAddress = testAddress1.copyWith(
          addressLine1: 'A' * 500,
          landmark: 'B' * 500,
        );

        await notifier.addAddress(longAddress);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.first.addressLine1.length, 500);
      });

      test('should handle special characters in address', () async {
        final notifier = container.read(addressesProvider.notifier);

        final specialAddress = testAddress1.copyWith(
          addressLine1: '123 Main St #@!',
          landmark: 'Near café & résturant',
        );

        await notifier.addAddress(specialAddress);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(addressesProvider);
        expect(state.addresses.first.addressLine1, contains('#@!'));
      });
    });
  });
}
