import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice => product.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] as int,
      selectedSize: json['selectedSize'] as String?,
      selectedColor: json['selectedColor'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }
}
