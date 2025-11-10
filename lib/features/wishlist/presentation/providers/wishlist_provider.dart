import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/wishlist_item.dart';
import 'package:bazaar/core/repositories/wishlist_repository.dart';

final wishlistProvider = StreamProvider.autoDispose<List<WishlistItem>>((ref) {
  final wishlistRepository = ref.watch(wishlistRepositoryProvider);
  return wishlistRepository.getWishlistStream();
});
