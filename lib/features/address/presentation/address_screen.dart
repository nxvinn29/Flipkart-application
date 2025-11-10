import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/features/address/presentation/providers/address_provider.dart';
import 'package:bazaar/core/repositories/address_repository.dart';
import 'package:bazaar/core/models/address.dart';
import 'package:bazaar/theme/app_colors.dart'; // Assuming AppColors is defined here
import 'package:bazaar/core/utils/constants.dart'; // Assuming AppConstants is defined here
import 'package:bazaar/features/address/presentation/add_address_screen.dart'; // Import AddAddressScreen

class AddressScreen extends ConsumerWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsyncValue = ref.watch(addressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Addresses'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: addressesAsyncValue.when(
        data: (addresses) {
          if (addresses.isEmpty) {
            return const Center(
              child: Text('No addresses found. Add a new address.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${address.street}, ${address.city}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('${address.state}, ${address.postalCode}'),
                      Text(address.country),
                      if (address.isDefault)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Chip(
                            label: const Text('Default'),
                            backgroundColor: AppColors.accent,
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: AppColors.primary),
                            onPressed: () {
                              // TODO: Implement edit address functionality
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Edit Address coming soon')),
                              // );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: AppColors.error),
                            onPressed: () async {
                              // TODO: Implement delete address functionality
                              // await ref.read(addressRepositoryProvider).deleteAddress(address.id);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Address deleted')),
                              // );
                            },
                          ),
                        ],
                      ),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/account/addresses/add'); // Navigate to AddAddressScreen
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
