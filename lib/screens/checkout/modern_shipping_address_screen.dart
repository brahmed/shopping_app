import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/address_model.dart';

class ModernShippingAddressScreen extends StatefulWidget {
  const ModernShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<ModernShippingAddressScreen> createState() => _ModernShippingAddressScreenState();
}

class _ModernShippingAddressScreenState extends State<ModernShippingAddressScreen> {
  String? selectedAddressId;
  bool _isLoading = false;

  // TODO: Replace with actual data from provider
  final List<Address> addresses = [
    Address(
      id: '1',
      userId: 'user1',
      fullName: 'John Doe',
      phoneNumber: '+1 234 567 8900',
      addressLine1: '123 Main Street',
      addressLine2: 'Apt 4B',
      city: 'New York',
      state: 'NY',
      country: 'United States',
      postalCode: '10001',
      isDefault: true,
    ),
    Address(
      id: '2',
      userId: 'user1',
      fullName: 'John Doe',
      phoneNumber: '+1 234 567 8900',
      addressLine1: '456 Office Plaza',
      addressLine2: 'Suite 200',
      city: 'New York',
      state: 'NY',
      country: 'United States',
      postalCode: '10002',
      isDefault: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Select default address
    selectedAddressId = addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first).id;
  }

  void _handleContinue() {
    if (selectedAddressId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a shipping address'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Navigate to payment method screen
    Navigator.pushNamed(
      context,
      '/checkout/payment',
      arguments: selectedAddressId,
    );
  }

  void _handleAddNewAddress() {
    // Navigate to add address screen
    Navigator.pushNamed(context, '/checkout/add-address');
  }

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
          'Shipping Address',
          style: AppTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(1),

          // Address list
          Expanded(
            child: addresses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    itemCount: addresses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == addresses.length) {
                        return _buildAddNewButton();
                      }
                      return _buildAddressCard(addresses[index]);
                    },
                  ),
          ),

          // Bottom bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    final steps = ['Address', 'Payment', 'Review'];

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      color: AppTheme.surfaceColor,
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep - 1;
          final isCompleted = index < currentStep - 1;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive ? AppTheme.primaryColor : AppTheme.gray200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(Icons.check, color: Colors.white, size: 18)
                              : Text(
                                  '${index + 1}',
                                  style: AppTheme.labelMedium.copyWith(
                                    color: isActive ? Colors.white : AppTheme.textSecondary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[index],
                        style: AppTheme.bodySmall.copyWith(
                          color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: isCompleted ? AppTheme.primaryColor : AppTheme.gray200,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    final isSelected = selectedAddressId == address.id;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: InkWell(
        onTap: () {
          setState(() => selectedAddressId = address.id);
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : AppTheme.gray300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              // Radio button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.gray300,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: AppTheme.spacing16),

              // Address details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          address.fullName,
                          style: AppTheme.headlineSmall,
                        ),
                        if (address.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.successColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Default',
                              style: AppTheme.labelSmall.copyWith(
                                color: AppTheme.successColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address.phoneNumber,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      address.fullAddress,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit button
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: AppTheme.textSecondary,
                onPressed: () {
                  // Navigate to edit address
                  Navigator.pushNamed(
                    context,
                    '/checkout/edit-address',
                    arguments: address.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewButton() {
    return Container(
      margin: const EdgeInsets.only(top: AppTheme.spacing8),
      child: OutlinedButton(
        onPressed: _handleAddNewAddress,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          side: BorderSide(color: AppTheme.primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Text(
              'Add New Address',
              style: AppTheme.labelLarge.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.gray100,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              size: 40,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),
          Text(
            'No Addresses Yet',
            style: AppTheme.headlineMedium,
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Add a shipping address to continue',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing32),
          ElevatedButton.icon(
            onPressed: _handleAddNewAddress,
            icon: const Icon(Icons.add),
            label: const Text('Add Address'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing24,
                vertical: AppTheme.spacing16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Continue to Payment',
                    style: AppTheme.labelLarge.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
