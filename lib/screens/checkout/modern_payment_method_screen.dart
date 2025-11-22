import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PaymentCard {
  final String id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardType;
  final bool isDefault;

  PaymentCard({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardType,
    this.isDefault = false,
  });

  String get maskedNumber => '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
}

class ModernPaymentMethodScreen extends StatefulWidget {
  const ModernPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<ModernPaymentMethodScreen> createState() => _ModernPaymentMethodScreenState();
}

class _ModernPaymentMethodScreenState extends State<ModernPaymentMethodScreen> {
  String? selectedPaymentId;
  bool _isLoading = false;

  // TODO: Replace with actual data from provider
  final List<PaymentCard> savedCards = [
    PaymentCard(
      id: '1',
      cardNumber: '4532123456789012',
      cardHolder: 'JOHN DOE',
      expiryDate: '12/25',
      cardType: 'visa',
      isDefault: true,
    ),
    PaymentCard(
      id: '2',
      cardNumber: '5412345678901234',
      cardHolder: 'JOHN DOE',
      expiryDate: '09/26',
      cardType: 'mastercard',
      isDefault: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Select default payment method
    if (savedCards.isNotEmpty) {
      selectedPaymentId = savedCards.firstWhere((c) => c.isDefault, orElse: () => savedCards.first).id;
    }
  }

  void _handleContinue() {
    if (selectedPaymentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Navigate to order review screen
    Navigator.pushNamed(
      context,
      '/checkout/review',
      arguments: selectedPaymentId,
    );
  }

  void _handleAddNewCard() {
    // Navigate to add card screen
    Navigator.pushNamed(context, '/checkout/add-card');
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
          'Payment Method',
          style: AppTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(2),

          // Payment methods
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Digital wallets
                  Text(
                    'Digital Wallets',
                    style: AppTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildDigitalWalletOption('Apple Pay', Icons.apple, 'apple-pay'),
                  const SizedBox(height: AppTheme.spacing8),
                  _buildDigitalWalletOption('Google Pay', Icons.g_mobiledata_rounded, 'google-pay'),

                  const SizedBox(height: AppTheme.spacing24),
                  const Divider(color: AppTheme.gray300),
                  const SizedBox(height: AppTheme.spacing24),

                  // Saved cards
                  Text(
                    'Saved Cards',
                    style: AppTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppTheme.spacing12),

                  if (savedCards.isEmpty)
                    _buildEmptyCardState()
                  else
                    ...savedCards.map((card) => _buildCardOption(card)).toList(),

                  const SizedBox(height: AppTheme.spacing12),
                  _buildAddNewCardButton(),
                ],
              ),
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

  Widget _buildDigitalWalletOption(String name, IconData icon, String id) {
    final isSelected = selectedPaymentId == id;

    return InkWell(
      onTap: () {
        setState(() => selectedPaymentId = id);
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
        ),
        child: Row(
          children: [
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
            Icon(icon, size: 32, color: AppTheme.textPrimary),
            const SizedBox(width: AppTheme.spacing12),
            Text(
              name,
              style: AppTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardOption(PaymentCard card) {
    final isSelected = selectedPaymentId == card.id;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: InkWell(
        onTap: () {
          setState(() => selectedPaymentId = card.id);
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : AppTheme.gray300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
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
                    color: isSelected ? Colors.white : AppTheme.gray300,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: AppTheme.spacing16),

              // Card icon
              _buildCardIcon(card.cardType, isSelected),

              const SizedBox(width: AppTheme.spacing16),

              // Card details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          card.maskedNumber,
                          style: AppTheme.headlineSmall.copyWith(
                            color: isSelected ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        if (card.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : AppTheme.successColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Default',
                              style: AppTheme.labelSmall.copyWith(
                                color: isSelected ? Colors.white : AppTheme.successColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Expires ${card.expiryDate}',
                      style: AppTheme.bodySmall.copyWith(
                        color: isSelected ? Colors.white.withOpacity(0.8) : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit button
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                ),
                onPressed: () {
                  // Show edit/delete options
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardIcon(String cardType, bool isSelected) {
    IconData icon;
    switch (cardType.toLowerCase()) {
      case 'visa':
        icon = Icons.credit_card;
        break;
      case 'mastercard':
        icon = Icons.credit_card;
        break;
      default:
        icon = Icons.credit_card;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : AppTheme.gray100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : AppTheme.primaryColor,
        size: 24,
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return OutlinedButton(
      onPressed: _handleAddNewCard,
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
            'Add New Card',
            style: AppTheme.labelLarge.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCardState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing24),
      decoration: BoxDecoration(
        color: AppTheme.gray100,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.credit_card_outlined,
              size: 48,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              'No saved cards',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
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
                    'Continue to Review',
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
