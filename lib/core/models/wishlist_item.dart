import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'wishlist_item.freezed.dart';
part 'wishlist_item.g.dart';

@freezed
class WishlistItem with _$WishlistItem {
  const factory WishlistItem({
    required String id,
    required String productId,
    required String name,
    required String imageUrl,
    required double price,
    @Default(1) int quantity, // Assuming quantity might be relevant for wishlist, though often 1
  }) = _WishlistItem;

  factory WishlistItem.fromJson(Map<String, Object?> json) => _$WishlistItemFromJson(json);
}
