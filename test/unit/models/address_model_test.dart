import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('Address Model Tests', () {
    late Address testAddress;

    setUp(() {
      testAddress = Address(
        id: 'addr1',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main Street',
        addressLine2: 'Apt 4B',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
        landmark: 'Near Central Park',
        isDefault: true,
        type: AddressType.home,
      );
    });

    test('should create Address instance with all fields', () {
      expect(testAddress.id, 'addr1');
      expect(testAddress.userId, 'user1');
      expect(testAddress.fullName, 'John Doe');
      expect(testAddress.phoneNumber, '+1234567890');
      expect(testAddress.addressLine1, '123 Main Street');
      expect(testAddress.addressLine2, 'Apt 4B');
      expect(testAddress.city, 'New York');
      expect(testAddress.state, 'NY');
      expect(testAddress.country, 'USA');
      expect(testAddress.zipCode, '10001');
      expect(testAddress.landmark, 'Near Central Park');
      expect(testAddress.isDefault, true);
      expect(testAddress.type, AddressType.home);
    });

    test('should have default values for optional fields', () {
      final address = Address(
        id: 'addr2',
        userId: 'user2',
        fullName: 'Jane Doe',
        phoneNumber: '+9876543210',
        addressLine1: '456 Oak Ave',
        city: 'Boston',
        state: 'MA',
        country: 'USA',
        zipCode: '02101',
      );

      expect(address.addressLine2, '');
      expect(address.landmark, null);
      expect(address.isDefault, false);
      expect(address.type, AddressType.home);
    });

    test('should generate fullAddress correctly', () {
      final fullAddress = testAddress.fullAddress;

      expect(fullAddress, contains('123 Main Street'));
      expect(fullAddress, contains('Apt 4B'));
      expect(fullAddress, contains('Near Central Park'));
      expect(fullAddress, contains('New York'));
      expect(fullAddress, contains('NY'));
      expect(fullAddress, contains('10001'));
      expect(fullAddress, contains('USA'));
    });

    test('should generate fullAddress without empty addressLine2', () {
      final address = Address(
        id: 'addr3',
        userId: 'user3',
        fullName: 'Test User',
        phoneNumber: '1234567890',
        addressLine1: '789 Pine St',
        city: 'Los Angeles',
        state: 'CA',
        country: 'USA',
        zipCode: '90001',
      );

      final fullAddress = address.fullAddress;

      expect(fullAddress, isNot(contains(', ,')));
      expect(fullAddress, '789 Pine St, Los Angeles, CA, 90001, USA');
    });

    test('should generate fullAddress without null landmark', () {
      final address = Address(
        id: 'addr4',
        userId: 'user4',
        fullName: 'Test User',
        phoneNumber: '1234567890',
        addressLine1: '321 Elm St',
        city: 'Chicago',
        state: 'IL',
        country: 'USA',
        zipCode: '60601',
        landmark: null,
      );

      final fullAddress = address.fullAddress;

      expect(fullAddress, '321 Elm St, Chicago, IL, 60601, USA');
    });

    test('should serialize to JSON correctly', () {
      final json = testAddress.toJson();

      expect(json['id'], 'addr1');
      expect(json['userId'], 'user1');
      expect(json['fullName'], 'John Doe');
      expect(json['phoneNumber'], '+1234567890');
      expect(json['addressLine1'], '123 Main Street');
      expect(json['addressLine2'], 'Apt 4B');
      expect(json['city'], 'New York');
      expect(json['state'], 'NY');
      expect(json['country'], 'USA');
      expect(json['zipCode'], '10001');
      expect(json['landmark'], 'Near Central Park');
      expect(json['isDefault'], true);
      expect(json['type'], 'home');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'addr5',
        'userId': 'user5',
        'fullName': 'Alice Smith',
        'phoneNumber': '+1122334455',
        'addressLine1': '555 Broadway',
        'addressLine2': 'Suite 200',
        'city': 'Seattle',
        'state': 'WA',
        'country': 'USA',
        'zipCode': '98101',
        'landmark': 'Near Space Needle',
        'isDefault': false,
        'type': 'work',
      };

      final address = Address.fromJson(json);

      expect(address.id, 'addr5');
      expect(address.userId, 'user5');
      expect(address.fullName, 'Alice Smith');
      expect(address.phoneNumber, '+1122334455');
      expect(address.addressLine1, '555 Broadway');
      expect(address.addressLine2, 'Suite 200');
      expect(address.city, 'Seattle');
      expect(address.state, 'WA');
      expect(address.country, 'USA');
      expect(address.zipCode, '98101');
      expect(address.landmark, 'Near Space Needle');
      expect(address.isDefault, false);
      expect(address.type, AddressType.work);
    });

    test('should handle all AddressType enum values', () {
      for (final type in AddressType.values) {
        final address = Address(
          id: 'test',
          userId: 'test',
          fullName: 'Test',
          phoneNumber: '123',
          addressLine1: 'Test',
          city: 'Test',
          state: 'Test',
          country: 'Test',
          zipCode: 'Test',
          type: type,
        );

        final json = address.toJson();
        final recreatedAddress = Address.fromJson(json);

        expect(recreatedAddress.type, type);
      }
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'addr6',
        'userId': 'user6',
        'fullName': 'Bob Johnson',
        'phoneNumber': '9998887777',
        'addressLine1': '777 Market St',
        'city': 'San Francisco',
        'state': 'CA',
        'country': 'USA',
        'zipCode': '94102',
      };

      final address = Address.fromJson(json);

      expect(address.addressLine2, '');
      expect(address.landmark, null);
      expect(address.isDefault, false);
      expect(address.type, AddressType.home);
    });

    test('should copyWith correctly - updating single field', () {
      final updatedAddress = testAddress.copyWith(fullName: 'Jane Doe');

      expect(updatedAddress.id, testAddress.id);
      expect(updatedAddress.fullName, 'Jane Doe');
      expect(updatedAddress.phoneNumber, testAddress.phoneNumber);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updatedAddress = testAddress.copyWith(
        city: 'Los Angeles',
        state: 'CA',
        zipCode: '90001',
        isDefault: false,
      );

      expect(updatedAddress.city, 'Los Angeles');
      expect(updatedAddress.state, 'CA');
      expect(updatedAddress.zipCode, '90001');
      expect(updatedAddress.isDefault, false);
      expect(updatedAddress.id, testAddress.id);
      expect(updatedAddress.fullName, testAddress.fullName);
    });

    test('should copyWith correctly - no changes', () {
      final copiedAddress = testAddress.copyWith();

      expect(copiedAddress.id, testAddress.id);
      expect(copiedAddress.userId, testAddress.userId);
      expect(copiedAddress.fullName, testAddress.fullName);
      expect(copiedAddress.phoneNumber, testAddress.phoneNumber);
      expect(copiedAddress.addressLine1, testAddress.addressLine1);
      expect(copiedAddress.city, testAddress.city);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testAddress.toJson();
      final recreatedAddress = Address.fromJson(json);

      expect(recreatedAddress.id, testAddress.id);
      expect(recreatedAddress.userId, testAddress.userId);
      expect(recreatedAddress.fullName, testAddress.fullName);
      expect(recreatedAddress.phoneNumber, testAddress.phoneNumber);
      expect(recreatedAddress.addressLine1, testAddress.addressLine1);
      expect(recreatedAddress.addressLine2, testAddress.addressLine2);
      expect(recreatedAddress.city, testAddress.city);
      expect(recreatedAddress.state, testAddress.state);
      expect(recreatedAddress.country, testAddress.country);
      expect(recreatedAddress.zipCode, testAddress.zipCode);
      expect(recreatedAddress.landmark, testAddress.landmark);
      expect(recreatedAddress.isDefault, testAddress.isDefault);
      expect(recreatedAddress.type, testAddress.type);
    });

    test('should handle AddressType.other correctly', () {
      final address = Address(
        id: 'addr7',
        userId: 'user7',
        fullName: 'Test',
        phoneNumber: '123',
        addressLine1: 'Test',
        city: 'Test',
        state: 'Test',
        country: 'Test',
        zipCode: 'Test',
        type: AddressType.other,
      );

      final json = address.toJson();
      expect(json['type'], 'other');

      final recreatedAddress = Address.fromJson(json);
      expect(recreatedAddress.type, AddressType.other);
    });
  });
}
