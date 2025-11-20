class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final List<String> sizes;
  final List<String> colors;
  final String brand;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.images,
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inStock = true,
    this.sizes = const [],
    this.colors = const [],
    required this.brand,
  });

  double get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  bool get hasDiscount => discountPercentage > 0;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] as String,
      images: List<String>.from(json['images'] ?? [json['imageUrl']]),
      category: json['category'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      inStock: json['inStock'] as bool? ?? true,
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      brand: json['brand'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'images': images,
      'category': category,
      'rating': rating,
      'reviewCount': reviewCount,
      'inStock': inStock,
      'sizes': sizes,
      'colors': colors,
      'brand': brand,
    };
  }
}
