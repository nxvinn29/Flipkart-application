import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/theme/app_colors.dart';
import 'package:bazaar/core/utils/constants.dart';
import 'package:bazaar/core/utils/extensions.dart'; // For toPrice() extension
import 'package:bazaar/features/cart/presentation/cart_provider.dart'; // To access cart data

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  int _selectedPaymentMethod = 0; // 0 for Cash on Delivery

  // Placeholder for delivery address
  String _deliveryAddressName = 'John Doe';
  String _deliveryAddressStreet = '123 Main Street, Apt 4B';
  String _deliveryAddressCityStateZip = 'Anytown, CA 90210';
  String _deliveryAddressCountry = 'USA';
  String _deliveryAddressPhone = '+1 (555) 123-4567';

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: _buildCurrentStepWidget(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
      color: AppColors.primary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStepIndicator(0, 'Address'),
          _buildStepIndicator(1, 'Summary'),
          _buildStepIndicator(2, 'Payment'),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String title) {
    final bool isActive = _currentStep == step;
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.5),
          child: Text(
            '${step + 1}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }

  Widget _buildCurrentStepWidget() {
    _animationController.reset();
    _animationController.forward();
    switch (_currentStep) {
      case 0:
        return _buildAddressStep();
      case 1:
        return _buildSummaryStep();
      case 2:
        return _buildPaymentStep();
      default:
        return const Center(child: Text('Unknown Step'));
    }
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          FadeTransition(
            opacity: _animationController,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: _deliveryAddressName,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deliveryAddressName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _deliveryAddressStreet,
                      decoration: const InputDecoration(
                        labelText: 'Street Address',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deliveryAddressStreet = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _deliveryAddressCityStateZip,
                      decoration: const InputDecoration(
                        labelText: 'City, State, Zip',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deliveryAddressCityStateZip = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _deliveryAddressCountry,
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deliveryAddressCountry = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _deliveryAddressPhone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deliveryAddressPhone = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Address updated!')),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('SAVE ADDRESS'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add New Address functionality coming soon')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('ADD NEW ADDRESS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStep() {
    final cartAsync = ref.watch(cartProvider);
    final cartTotal = ref.watch(cartTotalProvider);

    return cartAsync.when(
      data: (cartItems) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              FadeTransition(
                opacity: _animationController,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items (${cartItems.length})',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return _buildSummaryItem(context, item.title, '${item.quantity} x ${item.price.toPrice()}');
                          },
                        ),
                        const Divider(),
                        _buildSummaryRow(context, 'Total Price', cartTotal['total']!.toPrice(), isBold: true),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              FadeTransition(
                opacity: _animationController,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Details',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate back to address step for editing
                                setState(() {
                                  _currentStep = 0;
                                });
                              },
                              child: const Text('EDIT', style: TextStyle(color: AppColors.primary)),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(_deliveryAddressName, style: Theme.of(context).textTheme.bodyMedium),
                        Text(_deliveryAddressStreet, style: Theme.of(context).textTheme.bodyMedium),
                        Text(_deliveryAddressCityStateZip, style: Theme.of(context).textTheme.bodyMedium),
                        Text(_deliveryAddressCountry, style: Theme.of(context).textTheme.bodyMedium),
                        Text('Phone: $_deliveryAddressPhone', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        Text('Expected Delivery: 3-5 business days', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error loading cart: $error')),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium)),
          Text(price, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          FadeTransition(
            opacity: _animationController,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 0; // Select Cash on Delivery
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cash on Delivery selected')),
                  );
                },
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedPaymentMethod == 0 ? AppColors.primary.withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    border: Border.all(
                      color: _selectedPaymentMethod == 0 ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cash on Delivery selected')),
                          );
                        },
                        activeColor: AppColors.primary,
                      ),
                      const Icon(Icons.money, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        'Cash on Delivery',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          ScaleTransition(
            scale: _scaleAnimation,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedPaymentMethod == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Placing Order with Cash on Delivery...')),
                    );
                    // Simulate order placement and navigate to confirmation
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        context.go('/order_confirmation'); // Assuming this route exists
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a payment method')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                ),
                child: const Text(
                  'PLACE ORDER',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    ),
                  ),
                  child: const Text('BACK'),
                ),
              ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep++;
                    });
                  } else {
                    // This will be handled by the PLACE ORDER button in the payment step
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please click PLACE ORDER to complete')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                ),
                child: Text(_currentStep == 2 ? 'REVIEW & PAY' : 'CONTINUE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
