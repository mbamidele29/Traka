import 'package:traka/core/models/base_model.dart';

import 'product.dart';

class OrderItem extends BaseModel {
  final String id;
  final int quantity;
  final DateTime date;
  final Product product;

  OrderItem({
    required this.id,
    required this.date,
    required this.product,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      date: DateTime.parse(json['date']),
      product: Product.fromJson(json['product']));

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'product': product.toJson(),
        'date': date.toIso8601String(),
      };

  num get totalPrice => quantity * product.price;
}
