import 'package:equatable/equatable.dart';
import 'package:traka/core/models/base_model.dart';
import 'package:traka/core/utils/order_status.dart';

class OrderStatusModel extends BaseModel implements Equatable {
  final DateTime date;
  final OrderStatusEnum status;

  OrderStatusModel({required this.date, required this.status});

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderStatusModel(
          date: DateTime.parse(json['date']),
          status: OrderStatusEnum.values.firstWhere(
              (element) => element.code == json['status'],
              orElse: () => OrderStatusEnum.orderPlaced));

  @override
  Map<String, dynamic> toJson() => {
        'status': status.code,
        'date': date.toIso8601String(),
      };

  @override
  List<Object?> get props => [status];

  @override
  bool? get stringify => true;
}
