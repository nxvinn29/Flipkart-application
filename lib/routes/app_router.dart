import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bazaar/features/address/presentation/add_address_screen.dart';
import 'package:bazaar/features/address/presentation/address_screen.dart';
import 'package:bazaar/features/auth/presentation/auth_provider.dart';
import 'package:bazaar/features/auth/presentation/account_screen.dart';
import 'package:bazaar/features/auth/presentation/login_screen.dart';
import 'package:bazaar/features/cart/presentation/cart_screen.dart';
import 'package:bazaar/features/checkout/presentation/checkout_screen.dart';
import 'package:bazaar/features/checkout/presentation/order_placed_screen.dart';
import 'package:bazaar/features/home/presentation/home_screen.dart';
import 'package:bazaar/features/order_history/presentation/order_history_screen.dart';
import 'package:bazaar/features/product/presentation/product_detail_screen.dart';
import 'package:bazaar/features/wishlist/presentation/wishlist_screen.dart';

// App path constants
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
  static const String addAddressPath = '/account/addresses/add';
}

// Notifier to listen for auth changes and notify the router to refresh.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  late final ProviderSubscription<AsyncValue> _authSubscription;

  RouterNotifier(this._ref) {
    // Listen to the auth provider and notify listeners on change.
    _authSubscription = _ref.listen<AsyncValue>(authProvider, (_, __) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authSubscription.close();
    super.dispose();
  }
}

// Provider for the router notifier.
final routerNotifierProvider = ChangeNotifierProvider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

// The main router provider.
final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    refreshListenable: notifier,
    debugLogDiagnostics: true, // Helpful for debugging
    initialLocation: AppRouter.homePath,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouter.homePath,
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRouter.wishlistPath,
        builder: (BuildContext context, GoRouterState state) => const WishlistScreen(),
      ),
      GoRoute(
        path: AppRouter.loginPath,
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
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
        builder: (BuildContext context, GoRouterState state) => const AccountScreen(),
      ),
      GoRoute(
        path: AppRouter.cartPath,
        builder: (BuildContext context, GoRouterState state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRouter.checkoutPath,
        builder: (BuildContext context, GoRouterState state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRouter.orderPlacedPath,
        builder: (BuildContext context, GoRouterState state) => const OrderPlacedScreen(),
      ),
      GoRoute(
        path: AppRouter.orderHistoryPath,
        builder: (BuildContext context, GoRouterState state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: AppRouter.addressesPath,
        builder: (BuildContext context, GoRouterState state) => const AddressScreen(),
      ),
      GoRoute(
        path: AppRouter.addAddressPath,
        builder: (BuildContext context, GoRouterState state) => const AddAddressScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Use `ref.read` to get the latest auth state without listening.
      // The `refreshListenable` is responsible for triggering the redirect.
      final authState = ref.read(authProvider);

      // If the state is loading, don't redirect. A loading screen should be shown.
      if (authState.isLoading || authState.hasError) {
        return null;
      }

      final loggedIn = authState.valueOrNull != null;
      final isAtLoginPage = state.matchedLocation == AppRouter.loginPath;

      // If not logged in and not on the login page, redirect to login.
      if (!loggedIn && !isAtLoginPage) {
        return AppRouter.loginPath;
      }
      // If logged in and on the login page, redirect to home.
      if (loggedIn && isAtLoginPage) {
        return AppRouter.homePath;
      }

      return null; // No redirect needed.
    },
  );
});