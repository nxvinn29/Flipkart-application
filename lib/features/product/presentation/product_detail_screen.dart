import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/core/utils/constants.dart';
import 'package:bazaar/core/utils/extensions.dart';
import 'package:bazaar/core/models/cart_item_model.dart';
import 'package:bazaar/theme/app_colors.dart';
import 'package:bazaar/features/home/presentation/providers/product_provider.dart';
import 'package:bazaar/features/wishlist/presentation/wishlist_provider.dart';
import 'package:bazaar/features/cart/presentation/cart_provider.dart';
import 'package:bazaar/widgets/app_footer.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productByIdProvider(widget.productId));
    final isInWishlist = ref.watch(isInWishlistProvider(widget.productId));
    final wishlistRepository = ref.read(wishlistRepositoryProvider);
    final cartRepository = ref.read(cartRepositoryProvider);

    return Scaffold(
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 80, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text('Product not found', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product_${product.id}',
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() => _currentImageIndex = index);
                        },
                      ),
                      items: product.imageUrls.map((url) {
                        return Image.asset(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.divider,
                            child: const Icon(Icons.image, size: 80, color: AppColors.textSecondary),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isInWishlist) {
                        wishlistRepository.removeFromWishlist(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from wishlist')),
                        );
                      } else {
                        wishlistRepository.addToWishlist(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to wishlist')),
                        );
                      }
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.imageUrls.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: product.imageUrls.asMap().entries.map((entry) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == entry.key
                                    ? AppColors.primary
                                    : AppColors.divider,
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 20),
                      Text(product.title, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating,
                            itemBuilder: (context, index) => const Icon(Icons.star, color: AppColors.rating),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${product.rating} (${product.reviewCount} reviews)',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(AppConstants.defaultPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.price.toPrice(),
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (product.discount > 0) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.originalPrice.toPrice(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.discount,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${product.discount}% OFF',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Inclusive of all taxes',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Product Details', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(AppConstants.defaultPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow(context, Icons.local_shipping, 'Free Delivery', 'On orders above ₹500'),
                            const SizedBox(height: 12),
                            _buildInfoRow(context, Icons.replay, '7 Days Return', 'Easy return & refund'),
                            const SizedBox(height: 12),
                            _buildInfoRow(context, Icons.verified_user, 'Warranty', '1 Year brand warranty'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppFooter(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Failed to load product', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
      bottomNavigationBar: productAsync.maybeWhen(
        data: (product) => product != null
            ? Container(
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
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            cartRepository.addToCart(
                              CartItemModel(
                                id: 'cart_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
                                productId: product.id,
                                title: product.title,
                                imageUrl: product.imageUrls.first,
                                price: product.price,
                                originalPrice: product.originalPrice,
                                quantity: 1,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart')),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            cartRepository.addToCart(
                              CartItemModel(
                                id: 'cart_${product.id}_${DateTime.now().millisecondsSinceEpoch}',
                                productId: product.id,
                                title: product.title,
                                imageUrl: product.imageUrls.first,
                                price: product.price,
                                originalPrice: product.originalPrice,
                                quantity: 1,
                              ),
                            );
                            context.push('/cart');
                          },
                          icon: const Icon(Icons.bolt),
                          label: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        orElse: () => null,
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
