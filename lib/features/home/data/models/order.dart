import 'package:traka/features/home/data/models/order_item.dart';

class OrderModel {
  final DateTime date;
  final String orderId;
  final List<OrderItem> items;

  OrderModel({required this.date, required this.orderId, required this.items});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'],
      date: DateTime.parse(json['date']),
      items:
          (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList());

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'date': date.toIso8601String(),
        'items': items.map((e) => e.toJson()).toList()
      };
}
