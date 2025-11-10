import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/features/wishlist/data/wishlist_repository.dart';

final wishlistRepositoryProvider = Provider<IWishlistRepository>((ref) => LocalWishlistRepository());

final wishlistProvider = StreamProvider<List<String>>((ref) {
  final repository = ref.watch(wishlistRepositoryProvider);
  return repository.watchWishlist();
});

final isInWishlistProvider = Provider.family<bool, String>((ref, productId) {
  final wishlistAsync = ref.watch(wishlistProvider);
  return wishlistAsync.whenData((ids) => ids.contains(productId)).value ?? false;
});
