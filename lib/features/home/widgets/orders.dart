import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/features/home/widgets/order_widget.dart';

class OrdersWidget extends StatelessWidget {
  final Queue<OrderItem> orders;
  const OrdersWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: orders.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => 16.verticalSpace,
      itemBuilder: (_, index) => OrderItemWidget(order: orders.toList()[index]),
    );
  }
}
