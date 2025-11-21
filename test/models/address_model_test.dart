import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('Address Model Tests', () {
    late Address testAddress;

    setUp(() {
      testAddress = Address(
        id: 'address_1',
        userId: 'user_1',
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

    test('should create an Address instance', () {
      expect(testAddress, isA<Address>());
      expect(testAddress.id, equals('address_1'));
      expect(testAddress.userId, equals('user_1'));
      expect(testAddress.fullName, equals('John Doe'));
      expect(testAddress.phoneNumber, equals('+1234567890'));
      expect(testAddress.addressLine1, equals('123 Main Street'));
      expect(testAddress.addressLine2, equals('Apt 4B'));
      expect(testAddress.city, equals('New York'));
      expect(testAddress.state, equals('NY'));
      expect(testAddress.country, equals('USA'));
      expect(testAddress.zipCode, equals('10001'));
      expect(testAddress.landmark, equals('Near Central Park'));
      expect(testAddress.isDefault, isTrue);
      expect(testAddress.type, equals(AddressType.home));
    });

    test('should generate full address string correctly', () {
      final fullAddress = testAddress.fullAddress;

      expect(fullAddress, contains('123 Main Street'));
      expect(fullAddress, contains('Apt 4B'));
      expect(fullAddress, contains('Near Central Park'));
      expect(fullAddress, contains('New York'));
      expect(fullAddress, contains('NY'));
      expect(fullAddress, contains('10001'));
      expect(fullAddress, contains('USA'));
    });

    test('should handle missing optional fields in full address', () {
      final minimalAddress = Address(
        id: 'address_2',
        userId: 'user_1',
        fullName: 'Jane Smith',
        phoneNumber: '+9876543210',
        addressLine1: '456 Oak Avenue',
        city: 'Boston',
        state: 'MA',
        country: 'USA',
        zipCode: '02101',
      );

      final fullAddress = minimalAddress.fullAddress;

      expect(fullAddress, contains('456 Oak Avenue'));
      expect(fullAddress, contains('Boston'));
      expect(fullAddress, isNot(contains('Apt')));
    });

    test('should serialize to JSON correctly', () {
      final json = testAddress.toJson();

      expect(json['id'], equals('address_1'));
      expect(json['userId'], equals('user_1'));
      expect(json['fullName'], equals('John Doe'));
      expect(json['phoneNumber'], equals('+1234567890'));
      expect(json['addressLine1'], equals('123 Main Street'));
      expect(json['addressLine2'], equals('Apt 4B'));
      expect(json['city'], equals('New York'));
      expect(json['state'], equals('NY'));
      expect(json['country'], equals('USA'));
      expect(json['zipCode'], equals('10001'));
      expect(json['landmark'], equals('Near Central Park'));
      expect(json['isDefault'], isTrue);
      expect(json['type'], equals('home'));
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'address_3',
        'userId': 'user_2',
        'fullName': 'Bob Johnson',
        'phoneNumber': '+5555555555',
        'addressLine1': '789 Pine Road',
        'addressLine2': '',
        'city': 'Chicago',
        'state': 'IL',
        'country': 'USA',
        'zipCode': '60601',
        'landmark': null,
        'isDefault': false,
        'type': 'work',
      };

      final address = Address.fromJson(json);

      expect(address.id, equals('address_3'));
      expect(address.userId, equals('user_2'));
      expect(address.fullName, equals('Bob Johnson'));
      expect(address.phoneNumber, equals('+5555555555'));
      expect(address.addressLine1, equals('789 Pine Road'));
      expect(address.addressLine2, isEmpty);
      expect(address.city, equals('Chicago'));
      expect(address.state, equals('IL'));
      expect(address.country, equals('USA'));
      expect(address.zipCode, equals('60601'));
      expect(address.landmark, isNull);
      expect(address.isDefault, isFalse);
      expect(address.type, equals(AddressType.work));
    });

    test('should handle default values when fromJson', () {
      final json = {
        'id': 'address_4',
        'userId': 'user_3',
        'fullName': 'Alice Brown',
        'phoneNumber': '+1111111111',
        'addressLine1': '321 Elm Street',
        'city': 'Miami',
        'state': 'FL',
        'country': 'USA',
        'zipCode': '33101',
      };

      final address = Address.fromJson(json);

      expect(address.addressLine2, isEmpty);
      expect(address.landmark, isNull);
      expect(address.isDefault, isFalse);
      expect(address.type, equals(AddressType.home));
    });

    test('should create a copy with updated values', () {
      final updatedAddress = testAddress.copyWith(
        isDefault: false,
        addressLine2: 'Suite 10',
      );

      expect(updatedAddress.id, equals(testAddress.id));
      expect(updatedAddress.isDefault, isFalse);
      expect(updatedAddress.addressLine2, equals('Suite 10'));
      expect(updatedAddress.addressLine1, equals(testAddress.addressLine1));
    });

    test('should handle all AddressType values', () {
      final homeAddress = testAddress.copyWith(type: AddressType.home);
      expect(homeAddress.type, equals(AddressType.home));

      final workAddress = testAddress.copyWith(type: AddressType.work);
      expect(workAddress.type, equals(AddressType.work));

      final otherAddress = testAddress.copyWith(type: AddressType.other);
      expect(otherAddress.type, equals(AddressType.other));
    });

    test('should correctly round-trip JSON serialization', () {
      final json = testAddress.toJson();
      final deserialized = Address.fromJson(json);

      expect(deserialized.id, equals(testAddress.id));
      expect(deserialized.userId, equals(testAddress.userId));
      expect(deserialized.fullName, equals(testAddress.fullName));
      expect(deserialized.phoneNumber, equals(testAddress.phoneNumber));
      expect(deserialized.addressLine1, equals(testAddress.addressLine1));
      expect(deserialized.addressLine2, equals(testAddress.addressLine2));
      expect(deserialized.city, equals(testAddress.city));
      expect(deserialized.state, equals(testAddress.state));
      expect(deserialized.country, equals(testAddress.country));
      expect(deserialized.zipCode, equals(testAddress.zipCode));
      expect(deserialized.landmark, equals(testAddress.landmark));
      expect(deserialized.isDefault, equals(testAddress.isDefault));
      expect(deserialized.type, equals(testAddress.type));
    });

    test('should handle null landmark in full address', () {
      final addressWithoutLandmark = testAddress.copyWith(landmark: null);
      final fullAddress = addressWithoutLandmark.fullAddress;

      expect(fullAddress, isNot(contains('null')));
      expect(fullAddress, contains('123 Main Street'));
    });

    test('should handle empty addressLine2', () {
      final addressWithoutLine2 = Address(
        id: 'address_5',
        userId: 'user_1',
        fullName: 'Test User',
        phoneNumber: '+0000000000',
        addressLine1: '999 Test St',
        addressLine2: '',
        city: 'TestCity',
        state: 'TC',
        country: 'TestCountry',
        zipCode: '00000',
      );

      final fullAddress = addressWithoutLine2.fullAddress;
      expect(fullAddress, isNot(contains(', ,')));
    });

    test('should preserve all data through copy', () {
      final copied = testAddress.copyWith();

      expect(copied.id, equals(testAddress.id));
      expect(copied.userId, equals(testAddress.userId));
      expect(copied.fullName, equals(testAddress.fullName));
      expect(copied.phoneNumber, equals(testAddress.phoneNumber));
      expect(copied.addressLine1, equals(testAddress.addressLine1));
      expect(copied.addressLine2, equals(testAddress.addressLine2));
      expect(copied.city, equals(testAddress.city));
      expect(copied.state, equals(testAddress.state));
      expect(copied.country, equals(testAddress.country));
      expect(copied.zipCode, equals(testAddress.zipCode));
      expect(copied.landmark, equals(testAddress.landmark));
      expect(copied.isDefault, equals(testAddress.isDefault));
      expect(copied.type, equals(testAddress.type));
    });
  });
}
