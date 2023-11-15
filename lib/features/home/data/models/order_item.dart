import 'package:traka/features/home/data/models/product.dart';

class OrderItem {
  final int quantity;
  final Product product;

  OrderItem({required this.quantity, required this.product});

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      quantity: json['quantity'], product: Product.fromJson(json['product']));

  Map<String, dynamic> toJson() =>
      {'quantity': quantity, 'product': product.toJson()};
}
