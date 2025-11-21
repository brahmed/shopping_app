import 'product_model.dart';

enum WishlistType {
  general,
  birthday,
  wedding,
  christmas,
  custom,
}

class Wishlist {
  final String id;
  final String userId;
  final String name;
  final WishlistType type;
  final List<Product> products;
  final DateTime createdAt;
  final bool isPrivate;
  final String? description;

  Wishlist({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.products = const [],
    required this.createdAt,
    this.isPrivate = false,
    this.description,
  });

  int get productCount => products.length;

  double get totalValue {
    return products.fold(0.0, (sum, product) => sum + product.price);
  }

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      type: WishlistType.values[json['type'] as int],
      products: (json['products'] as List?)?.map((p) => Product.fromJson(p)).toList() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPrivate: json['isPrivate'] as bool? ?? false,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type.index,
      'products': products.map((p) => p.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'isPrivate': isPrivate,
      'description': description,
    };
  }

  Wishlist copyWith({
    String? id,
    String? userId,
    String? name,
    WishlistType? type,
    List<Product>? products,
    DateTime? createdAt,
    bool? isPrivate,
    String? description,
  }) {
    return Wishlist(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      isPrivate: isPrivate ?? this.isPrivate,
      description: description ?? this.description,
    );
  }
}
