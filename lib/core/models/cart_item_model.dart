class CartItemModel {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final int quantity;
  final String? size;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    this.size,
  });

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? title,
    String? imageUrl,
    double? price,
    double? originalPrice,
    int? quantity,
    String? size,
  }) => CartItemModel(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    title: title ?? this.title,
    imageUrl: imageUrl ?? this.imageUrl,
    price: price ?? this.price,
    originalPrice: originalPrice ?? this.originalPrice,
    quantity: quantity ?? this.quantity,
    size: size ?? this.size,
  );

  double get totalPrice => price * quantity;
  double get totalOriginalPrice => originalPrice * quantity;
  double get savedAmount => totalOriginalPrice - totalPrice;
}
