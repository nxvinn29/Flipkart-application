class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final int discount;
  final double rating;
  final int reviewCount;
  final List<String> imageUrls;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviewCount,
    required this.imageUrls,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    originalPrice: (json['originalPrice'] as num).toDouble(),
    discount: json['discount'] as int,
    rating: (json['rating'] as num).toDouble(),
    reviewCount: json['reviewCount'] as int,
    imageUrls: List<String>.from(json['imageUrls'] as List),
    category: json['category'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'originalPrice': originalPrice,
    'discount': discount,
    'rating': rating,
    'reviewCount': reviewCount,
    'imageUrls': imageUrls,
    'category': category,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? originalPrice,
    int? discount,
    double? rating,
    int? reviewCount,
    List<String>? imageUrls,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    price: price ?? this.price,
    originalPrice: originalPrice ?? this.originalPrice,
    discount: discount ?? this.discount,
    rating: rating ?? this.rating,
    reviewCount: reviewCount ?? this.reviewCount,
    imageUrls: imageUrls ?? this.imageUrls,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
