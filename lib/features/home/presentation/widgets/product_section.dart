import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/product_model.dart';
import 'package:bazaar/core/utils/constants.dart';
import 'package:bazaar/theme/app_colors.dart';
import 'package:bazaar/features/home/presentation/widgets/home_product_card.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final AsyncValue<List<ProductModel>> productsAsync;
  final VoidCallback? onViewAll;

  const ProductSection({
    super.key,
    required this.title,
    required this.productsAsync,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          productsAsync.when(
            data: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      margin: EdgeInsets.only(right: index < products.length - 1 ? 12 : 0),
                      child: HomeProductCard(product: products[index]),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox(
              height: 280,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SizedBox(
              height: 280,
              child: Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
