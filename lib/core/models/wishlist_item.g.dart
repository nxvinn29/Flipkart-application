// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) =>
    _WishlistItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$WishlistItemToJson(_WishlistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };
