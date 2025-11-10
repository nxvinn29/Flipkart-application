import 'dart:async';

abstract class IWishlistRepository {
  Stream<List<String>> watchWishlist();
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String productId);
  bool isInWishlist(String productId);
}

class LocalWishlistRepository implements IWishlistRepository {
  final Set<String> _wishlist = {};
  final _controller = StreamController<List<String>>.broadcast();

  LocalWishlistRepository() {
    _emit();
  }

  @override
  Stream<List<String>> watchWishlist() => _controller.stream;

  @override
  Future<void> addToWishlist(String productId) async {
    _wishlist.add(productId);
    _emit();
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    _wishlist.remove(productId);
    _emit();
  }

  @override
  bool isInWishlist(String productId) => _wishlist.contains(productId);

  void _emit() => _controller.add(_wishlist.toList());

  void dispose() {
    _controller.close();
  }
}
