import 'dart:async';
import 'package:bazaar/core/models/cart_item_model.dart';

abstract class ICartRepository {
  Stream<List<CartItemModel>> watchCart();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(String itemId);
  Future<void> updateQuantity(String itemId, int quantity);
  Future<void> clearCart();
}

class LocalCartRepository implements ICartRepository {
  final List<CartItemModel> _cartItems = [];
  final _controller = StreamController<List<CartItemModel>>.broadcast();

  LocalCartRepository() {
    _emit();
  }

  @override
  Stream<List<CartItemModel>> watchCart() => _controller.stream;

  @override
  Future<void> addToCart(CartItemModel item) async {
    final existingIndex = _cartItems.indexWhere((i) => i.productId == item.productId);
    if (existingIndex >= 0) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      _cartItems.add(item);
    }
    _emit();
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    _cartItems.removeWhere((item) => item.id == itemId);
    _emit();
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      }
      _emit();
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    _emit();
  }

  void _emit() => _controller.add(List.from(_cartItems));

  void dispose() {
    _controller.close();
  }
}
