import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/features/home/presentation/home_screen.dart';
import 'package:bazaar/features/auth/presentation/login_screen.dart';
import 'package:bazaar/features/auth/presentation/auth_provider.dart';
import 'package:bazaar/features/product/presentation/product_detail_screen.dart';
import 'package:bazaar/features/auth/presentation/account_screen.dart';
import 'package:bazaar/features/cart/presentation/cart_screen.dart';
import 'package:bazaar/features/checkout/presentation/checkout_screen.dart';
import 'package:bazaar/features/checkout/presentation/order_placed_screen.dart';
import 'package:bazaar/features/wishlist/presentation/wishlist_screen.dart';
import 'package:bazaar/features/order_history/presentation/order_history_screen.dart';
import 'package:bazaar/features/address/presentation/address_screen.dart';
import 'package:bazaar/features/address/presentation/add_address_screen.dart'; // Import AddAddressScreen

class AppRouter {
  static const String homePath = '/';
  static const String loginPath = '/login';
  static const String productDetailPath = '/product/:productId';
  static const String accountPath = '/account';
  static const String cartPath = '/cart';
  static const String checkoutPath = '/checkout';

  static const String orderPlacedPath = '/order_placed';
  static const String wishlistPath = '/wishlist';
  static const String orderHistoryPath = '/order_history';
  static const String addressesPath = '/account/addresses';
  static const String addAddressPath = '/account/addresses/add'; // New path for AddAddressScreen
}

final goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRouter.homePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: AppRouter.wishlistPath,
      builder: (BuildContext context, GoRouterState state) {
        return const WishlistScreen();
      },
    ),
    GoRoute(
      path: AppRouter.loginPath,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: AppRouter.productDetailPath,
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['productId']!;
        return ProductDetailScreen(productId: productId);
      },
    ),
    GoRoute(
      path: AppRouter.accountPath,
      builder: (BuildContext context, GoRouterState state) {
        return const AccountScreen();
      },
    ),
    GoRoute(
      path: AppRouter.cartPath,
      builder: (BuildContext context, GoRouterState state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      path: AppRouter.checkoutPath,
      builder: (BuildContext context, GoRouterState state) {
        return const CheckoutScreen();
      },
    ),

    GoRoute(
      path: AppRouter.orderPlacedPath,
      builder: (BuildContext context, GoRouterState state) {
        return const OrderPlacedScreen();
      },
    ),
    GoRoute(
      path: AppRouter.orderHistoryPath,
      builder: (BuildContext context, GoRouterState state) {
        return const OrderHistoryScreen();
      },
    ),
    GoRoute(
      path: AppRouter.addressesPath,
      builder: (BuildContext context, GoRouterState state) {
        return const AddressScreen();
      },
    ),
    GoRoute(
      path: AppRouter.addAddressPath, // New route definition
      builder: (BuildContext context, GoRouterState state) {
        return const AddAddressScreen();
      },
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn =
        ProviderScope.containerOf(context).read(currentUserProvider) != null;
    final bool loggingIn = state.matchedLocation == '/login';

    if (!loggedIn && !loggingIn) {
      return '/login';
    }
    if (loggedIn && loggingIn) {
      return '/';
    }
    return null;
  },
);