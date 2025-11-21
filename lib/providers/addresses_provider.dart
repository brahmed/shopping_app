import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/address_model.dart';

// Addresses State
class AddressesState {
  final List<Address> addresses;
  final bool isLoading;
  final String? error;

  const AddressesState({
    this.addresses = const [],
    this.isLoading = false,
    this.error,
  });

  Address? get defaultAddress {
    try {
      return addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }

  bool get hasAddresses => addresses.isNotEmpty;

  AddressesState copyWith({
    List<Address>? addresses,
    bool? isLoading,
    String? error,
  }) {
    return AddressesState(
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Addresses Notifier
class AddressesNotifier extends StateNotifier<AddressesState> {
  static const String _addressesKey = 'user_addresses';

  AddressesNotifier() : super(const AddressesState()) {
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressesData = prefs.getString(_addressesKey);
      if (addressesData != null) {
        final List<dynamic> decodedData = json.decode(addressesData);
        final addresses = decodedData.map((address) => Address.fromJson(address)).toList();
        state = AddressesState(addresses: addresses, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _saveAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressesData =
          json.encode(state.addresses.map((address) => address.toJson()).toList());
      await prefs.setString(_addressesKey, addressesData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addAddress(Address address) async {
    List<Address> addresses = [...state.addresses];

    // If this is marked as default, unmark all others
    if (address.isDefault) {
      addresses = addresses.map((a) => a.copyWith(isDefault: false)).toList();
    }

    // If this is the first address, make it default
    if (addresses.isEmpty) {
      address = address.copyWith(isDefault: true);
    }

    addresses.add(address);
    state = state.copyWith(addresses: addresses);
    await _saveAddresses();
  }

  Future<void> updateAddress(Address address) async {
    List<Address> addresses = state.addresses.map((a) {
      if (a.id == address.id) {
        return address;
      }
      // If setting this as default, unmark others
      if (address.isDefault && a.isDefault) {
        return a.copyWith(isDefault: false);
      }
      return a;
    }).toList();

    state = state.copyWith(addresses: addresses);
    await _saveAddresses();
  }

  Future<void> deleteAddress(String addressId) async {
    final deletedAddress = state.addresses.firstWhere((a) => a.id == addressId);
    List<Address> addresses = state.addresses.where((a) => a.id != addressId).toList();

    // If deleted address was default and there are remaining addresses, set first as default
    if (deletedAddress.isDefault && addresses.isNotEmpty) {
      addresses[0] = addresses[0].copyWith(isDefault: true);
    }

    state = state.copyWith(addresses: addresses);
    await _saveAddresses();
  }

  Future<void> setDefaultAddress(String addressId) async {
    final addresses = state.addresses.map((address) {
      if (address.id == addressId) {
        return address.copyWith(isDefault: true);
      }
      return address.copyWith(isDefault: false);
    }).toList();

    state = state.copyWith(addresses: addresses);
    await _saveAddresses();
  }

  Address? getAddressById(String addressId) {
    try {
      return state.addresses.firstWhere((address) => address.id == addressId);
    } catch (e) {
      return null;
    }
  }

  List<Address> getAddressesByType(AddressType type) {
    return state.addresses.where((address) => address.type == type).toList();
  }
}

// Provider
final addressesProvider = StateNotifierProvider<AddressesNotifier, AddressesState>((ref) {
  return AddressesNotifier();
});
