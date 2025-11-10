import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/cart_item_model.dart';
import 'package:bazaar/features/cart/data/cart_repository.dart';

final cartRepositoryProvider = Provider<ICartRepository>((ref) => LocalCartRepository());

final cartProvider = StreamProvider<List<CartItemModel>>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return repository.watchCart();
});

final cartCountProvider = Provider<int>((ref) {
  final cartAsync = ref.watch(cartProvider);
  return cartAsync.whenData((items) => items.length).value ?? 0;
});

final cartTotalProvider = Provider<Map<String, double>>((ref) {
  final cartAsync = ref.watch(cartProvider);
  return cartAsync.whenData((items) {
    double price = 0.0;
    double originalPrice = 0.0;
    for (final item in items) {
      price += item.totalPrice;
      originalPrice += item.totalOriginalPrice;
    }
    return <String, double>{
      'price': price,
      'originalPrice': originalPrice,
      'discount': originalPrice - price,
      'platformFee': 3.0,
      'total': price + 3.0,
      'savings': originalPrice - price,
    };
  }).value ?? <String, double>{
    'price': 0.0,
    'originalPrice': 0.0,
    'discount': 0.0,
    'platformFee': 0.0,
    'total': 0.0,
    'savings': 0.0,
  };
});
