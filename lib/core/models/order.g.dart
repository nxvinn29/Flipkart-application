// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => _OrderItem(
      productId: json['productId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemToJson(_OrderItem instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'totalAmount': instance.totalAmount,
      'orderDate': instance.orderDate.toIso8601String(),
      'status': instance.status,
    };
