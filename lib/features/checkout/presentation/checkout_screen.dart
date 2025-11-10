import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/theme/app_colors.dart' as bazaar;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _deliveryAddress = "123 Main St, Anytown, USA"; // Placeholder for editable address

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: bazaar.AppColors.primary, // Using a primary color
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Order Summary'),
            _buildOrderSummary(),
            const SizedBox(height: 24),
            _buildSectionTitle('Delivery Address'),
            _buildDeliveryAddress(),
            const SizedBox(height: 24),
            _buildSectionTitle('Payment Method'),
            _buildPaymentMethod(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _placeOrder(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bazaar.AppColors.accent, // Using an accent color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: bazaar.AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    // Placeholder for original checkout details
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow('Product Total:', '\$150.00'),
            _buildSummaryRow('Shipping:', '\$10.00'),
            _buildSummaryRow('Tax:', '\$5.00'),
            const Divider(),
            _buildSummaryRow('Total:', '\$165.00', isTotal: true),
            const SizedBox(height: 8),
            const Text(
              'Items: Product A (x1), Product B (x2)',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? bazaar.AppColors.primary : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? bazaar.AppColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current Address:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: bazaar.AppColors.accent),
                  onPressed: () {
                    _editDeliveryAddress(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _deliveryAddress,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _editDeliveryAddress(BuildContext context) {
    TextEditingController addressController = TextEditingController(text: _deliveryAddress);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Delivery Address'),
          content: TextField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter new address',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _deliveryAddress = addressController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentMethod() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Responsive touch effect, could be more elaborate
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cash on Delivery selected!')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bazaar.AppColors.accent, width: 2),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.money, color: bazaar.AppColors.accent),
                    SizedBox(width: 12),
                    Text(
                      'Cash on Delivery',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(Icons.check_circle, color: bazaar.AppColors.accent),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    // Implement order placement logic here
    // For now, just show a confirmation and navigate back or to an order confirmation screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order Placed Successfully!')),
    );
    // Example: Navigate to a confirmation screen or home
    context.go('/order_placed');
  }
}