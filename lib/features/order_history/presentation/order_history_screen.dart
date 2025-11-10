import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/features/order_history/presentation/providers/order_provider.dart';
import 'package:intl/intl.dart'; // For date formatting

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsyncValue = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ordersAsyncValue.when(
        data: (orders) {
          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders found.'),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID: ${order.id}', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text('Date: ${DateFormat('yyyy-MM-dd HH:mm').format(order.orderDate)}'),
                      Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                      Text('Status: ${order.status}'),
                      const SizedBox(height: 8),
                      Text('Items:', style: Theme.of(context).textTheme.titleSmall),
                      ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text('${item.name} x${item.quantity} (\$${item.price.toStringAsFixed(2)} each)'),
                      )).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
