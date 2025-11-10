import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/category_model.dart';
import 'package:bazaar/core/models/banner_model.dart';
import 'package:bazaar/theme/app_colors.dart';
import 'package:bazaar/features/home/presentation/providers/product_provider.dart';
import 'package:bazaar/features/home/presentation/widgets/category_bar.dart';
import 'package:bazaar/features/home/presentation/widgets/banner_carousel.dart';
import 'package:bazaar/features/home/presentation/widgets/product_section.dart';
import 'package:bazaar/features/cart/presentation/cart_provider.dart';
import 'package:bazaar/features/auth/presentation/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/widgets/app_footer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Mobiles', icon: 'phone'),
    CategoryModel(id: '2', name: 'Fashion', icon: 'fashion'),
    CategoryModel(id: '3', name: 'Electronics', icon: 'electronics'),
    CategoryModel(id: '4', name: 'Home', icon: 'home'),
    CategoryModel(id: '5', name: 'Appliances', icon: 'appliances'),
    CategoryModel(id: '6', name: 'Flight', icon: 'flight'),
    CategoryModel(id: '7', name: 'Beauty', icon: 'beauty'),
    CategoryModel(id: '8', name: 'Grocery', icon: 'grocery'),
    CategoryModel(id: '9', name: 'Toys', icon: 'toys'),
    CategoryModel(id: '10', name: 'Sports', icon: 'sports'),
  ];

  final List<BannerModel> _banners = [
    BannerModel(
      id: '1',
      title: 'Smartphones',
      subtitle: 'Latest models at best prices',
      imageUrl: 'assets/images/smartphone_mobile_phone_null_1762613253036.jpg',
      discount: 'Up to 50% OFF',
    ),
    BannerModel(
      id: '2',
      title: 'Laptops & PCs',
      subtitle: 'Work from home essentials',
      imageUrl: 'assets/images/laptop_computer_null_1762613253972.jpg',
      discount: 'Up to 40% OFF',
    ),
    BannerModel(
      id: '3',
      title: 'Audio Collection',
      subtitle: 'Premium sound quality',
      imageUrl: 'assets/images/wireless_headphones_null_1762613254786.jpg',
      discount: 'Up to 60% OFF',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategoryTap(CategoryModel category) {
    // Handle category tap, e.g., navigate to a category-specific product list
    print('Category tapped: ${category.name}');
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Bazaar - Products and Categories',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.push('/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/account');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(productsProvider);
        },
        child: ListView(
          children: [
            CategoryBar(
              categories: _categories,
              onCategoryTap: _onCategoryTap,
            ),
            BannerCarousel(banners: _banners),
            ProductSection(
              title: 'Featured Products',
              productsAsync: productsAsync,
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
