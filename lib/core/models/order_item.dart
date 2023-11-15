import 'package:traka/core/models/base_model.dart';

import 'product.dart';

class OrderItem extends BaseModel {
  final String id;
  final int quantity;
  final Product product;

  OrderItem({required this.id, required this.quantity, required this.product});

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']));

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'quantity': quantity, 'product': product.toJson()};

  num get totalPrice => quantity * product.price;
}
