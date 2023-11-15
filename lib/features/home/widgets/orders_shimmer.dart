import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/features/home/widgets/order_shimmer_widget.dart';

class OrdersShimmerWidget extends StatelessWidget {
  const OrdersShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => 16.verticalSpace,
      itemBuilder: (_, index) => const OrderItemShimmerWidget(),
    );
  }
}
