import 'dart:async';
import 'package:bazaar/core/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel?> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
}

class LocalProductRepository implements IProductRepository {
  final List<ProductModel> _mockProducts = [
    ProductModel(
      id: '1',
      title: 'iPhone 15 Pro Max',
      description: 'Latest iPhone with A17 Pro chip, titanium design, and advanced camera system. Experience unparalleled performance and stunning photography capabilities.',
      price: 134900,
      originalPrice: 159900,
      discount: 15,
      rating: 4.8,
      reviewCount: 1245,
      imageUrls: ['assets/images/smartphone_mobile_phone_null_1762613253036.jpg'],
      category: 'Smartphones',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '2',
      title: 'MacBook Pro 16"',
      description: 'Powerful laptop with M3 Max chip, stunning Liquid Retina XDR display, and all-day battery life. Perfect for professionals and creatives.',
      price: 249900,
      originalPrice: 289900,
      discount: 13,
      rating: 4.9,
      reviewCount: 856,
      imageUrls: ['assets/images/laptop_computer_null_1762613253972.jpg'],
      category: 'Laptops',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '3',
      title: 'Sony WH-1000XM5',
      description: 'Industry-leading noise canceling wireless headphones with exceptional sound quality, 30-hour battery life, and premium comfort.',
      price: 24990,
      originalPrice: 29990,
      discount: 16,
      rating: 4.7,
      reviewCount: 2134,
      imageUrls: ['assets/images/wireless_headphones_null_1762613254786.jpg'],
      category: 'Audio',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '4',
      title: 'Apple Watch Series 9',
      description: 'Advanced health and fitness smartwatch with bright always-on display, faster processor, and new double tap gesture.',
      price: 41900,
      originalPrice: 45900,
      discount: 8,
      rating: 4.6,
      reviewCount: 987,
      imageUrls: ['assets/images/smartwatch_wearable_null_1762613255750.jpg'],
      category: 'Wearables',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '5',
      title: 'iPad Pro 12.9"',
      description: 'Ultimate iPad experience with M2 chip, stunning Liquid Retina XDR display, and support for Apple Pencil and Magic Keyboard.',
      price: 99900,
      originalPrice: 112900,
      discount: 11,
      rating: 4.8,
      reviewCount: 634,
      imageUrls: ['assets/images/tablet_device_null_1762613256558.jpg'],
      category: 'Tablets',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '6',
      title: 'Canon EOS R5',
      description: 'Professional mirrorless camera with 45MP sensor, 8K video recording, and advanced autofocus system for stunning imagery.',
      price: 289900,
      originalPrice: 339900,
      discount: 14,
      rating: 4.9,
      reviewCount: 445,
      imageUrls: ['assets/images/camera_photography_null_1762613257344.jpg'],
      category: 'Cameras',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '7',
      title: 'JBL Flip 6',
      description: 'Portable Bluetooth speaker with powerful sound, deep bass, IP67 waterproof rating, and 12-hour playtime.',
      price: 9999,
      originalPrice: 12999,
      discount: 23,
      rating: 4.5,
      reviewCount: 3421,
      imageUrls: ['assets/images/bluetooth_speaker_null_1762613258221.jpg'],
      category: 'Audio',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '8',
      title: 'PlayStation 5',
      description: 'Next-gen gaming console with lightning-fast loading, haptic feedback, adaptive triggers, and stunning 4K graphics.',
      price: 49990,
      originalPrice: 54990,
      discount: 9,
      rating: 4.8,
      reviewCount: 5678,
      imageUrls: ['assets/images/gaming_console_null_1762613259124.jpg'],
      category: 'Gaming',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '9',
      title: 'Samsung 65" QLED 4K TV',
      description: 'Brilliant 4K QLED TV with Quantum HDR, Object Tracking Sound, and smart features powered by Tizen OS.',
      price: 84990,
      originalPrice: 99990,
      discount: 15,
      rating: 4.7,
      reviewCount: 1234,
      imageUrls: ['assets/images/television_TV_null_1762613260148.jpg'],
      category: 'TVs',
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '10',
      title: 'LG French Door Refrigerator',
      description: 'Spacious smart refrigerator with InstaView door, linear cooling, and energy-efficient inverter compressor.',
      price: 89990,
      originalPrice: 109990,
      discount: 18,
      rating: 4.6,
      reviewCount: 567,
      imageUrls: ['assets/images/home_appliance_refrigerator_null_1762613260909.jpg'],
      category: 'Appliances',
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '11',
      title: 'Bosch Front Load Washing Machine',
      description: 'Advanced washing machine with AI-powered wash programs, steam refresh, and energy-saving technology.',
      price: 45990,
      originalPrice: 54990,
      discount: 16,
      rating: 4.5,
      reviewCount: 892,
      imageUrls: ['assets/images/washing_machine_null_1762613261736.jpg'],
      category: 'Appliances',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '12',
      title: 'Samsung Convection Microwave',
      description: 'Versatile microwave oven with convection cooking, smart sensor technology, and ceramic enamel interior.',
      price: 12990,
      originalPrice: 15990,
      discount: 18,
      rating: 4.4,
      reviewCount: 1456,
      imageUrls: ['assets/images/microwave_oven_null_1762613262737.jpg'],
      category: 'Appliances',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '13',
      title: 'Dell XPS 15',
      description: 'High-performance laptop with a stunning InfinityEdge display, powerful Intel processor, and NVIDIA graphics. Ideal for creative professionals.',
      price: 189900,
      originalPrice: 210000,
      discount: 10,
      rating: 4.7,
      reviewCount: 720,
      imageUrls: ['assets/images/laptop_computer_null_1762613253972.jpg'], // Reusing image for now
      category: 'Laptops',
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '14',
      title: 'Bose QuietComfort Earbuds II',
      description: 'World-class noise cancellation, custom-tuned sound, and comfortable fit for an immersive listening experience.',
      price: 26900,
      originalPrice: 30000,
      discount: 10,
      rating: 4.6,
      reviewCount: 1800,
      imageUrls: ['assets/images/wireless_headphones_null_1762613254786.jpg'], // Reusing image for now
      category: 'Audio',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '15',
      title: 'Google Pixel 8 Pro',
      description: 'The latest Pixel phone with Google AI, advanced camera features, and a stunning Actua display. Experience Android at its best.',
      price: 95999,
      originalPrice: 105999,
      discount: 9,
      rating: 4.5,
      reviewCount: 1100,
      imageUrls: ['assets/images/smartphone_mobile_phone_null_1762613253036.jpg'], // Reusing image for now
      category: 'Smartphones',
      createdAt: DateTime.now().subtract(const Duration(days: 11)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '16',
      title: 'Dyson V15 Detect Absolute',
      description: 'Powerful cordless vacuum cleaner with laser detection, de-tangling technology, and intelligent suction optimization.',
      price: 62900,
      originalPrice: 70000,
      discount: 10,
      rating: 4.9,
      reviewCount: 950,
      imageUrls: ['assets/images/home_appliance_refrigerator_null_1762613260909.jpg'], // Placeholder image
      category: 'Home Appliances',
      createdAt: DateTime.now().subtract(const Duration(days: 13)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '17',
      title: 'Nintendo Switch OLED',
      description: 'Vibrant 7-inch OLED screen, a wide adjustable stand, a dock with a wired LAN port, and 64 GB of internal storage.',
      price: 34999,
      originalPrice: 37999,
      discount: 8,
      rating: 4.8,
      reviewCount: 2500,
      imageUrls: ['assets/images/gaming_console_null_1762613259124.jpg'], // Reusing image for now
      category: 'Gaming',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '18',
      title: 'Samsung Galaxy Tab S9 Ultra',
      description: 'Ultra-large AMOLED display, powerful Snapdragon processor, and S Pen included. Perfect for productivity and entertainment.',
      price: 109999,
      originalPrice: 120000,
      discount: 8,
      rating: 4.7,
      reviewCount: 600,
      imageUrls: ['assets/images/tablet_device_null_1762613256558.jpg'], // Reusing image for now
      category: 'Tablets',
      createdAt: DateTime.now().subtract(const Duration(days: 16)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '19',
      title: 'GoPro HERO12 Black',
      description: 'Unbelievable image quality, even better HyperSmooth video stabilization and a massive boost in battery life.',
      price: 44999,
      originalPrice: 49999,
      discount: 10,
      rating: 4.6,
      reviewCount: 1300,
      imageUrls: ['assets/images/camera_photography_null_1762613257344.jpg'], // Reusing image for now
      category: 'Cameras',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now(),
    ),
    ProductModel(
      id: '20',
      title: 'Amazon Echo Dot (5th Gen)',
      description: 'Our best-sounding Echo Dot yet with Alexa. Enjoy an improved audio experience compared to any previous Echo Dot with Alexa for clearer vocals, deeper bass and vibrant sound in any room.',
      price: 4999,
      originalPrice: 5499,
      discount: 9,
      rating: 4.5,
      reviewCount: 3000,
      imageUrls: ['assets/images/bluetooth_speaker_null_1762613258221.jpg'], // Reusing image for now
      category: 'Smart Home',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProducts;
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowerQuery = query.toLowerCase();
    return _mockProducts.where((p) =>
      p.title.toLowerCase().contains(lowerQuery) ||
      p.category.toLowerCase().contains(lowerQuery) ||
      p.description.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}
