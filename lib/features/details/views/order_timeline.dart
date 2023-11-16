import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/widgets/appbar.dart';
import 'package:traka/features/details/models/order_status.dart';
import 'package:traka/features/details/widgets/timeline_widget.dart';

class OrderTimelineScreen extends StatelessWidget {
  final OrderItem order;
  final List<OrderStatusModel> statuses;

  const OrderTimelineScreen(
      {super.key, required this.order, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrakaAppBar(titleText: 'Order #${order.id}'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: TimelineWidget(statuses: statuses),
      ),
    );
  }
}
