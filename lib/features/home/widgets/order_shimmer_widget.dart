import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/widgets/shimmer.dart';

class OrderItemShimmerWidget extends StatelessWidget {
  const OrderItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.none,
      borderRadius: BorderRadius.circular(18.2.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.2.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 36,
              offset: const Offset(18, 18),
              color: AppColor.shadowColor.withOpacity(.25),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget(width: 343.w, height: 165.h, radius: 18.2.r),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: ShimmerWidget(width: 200.w, height: 18.h, radius: 4.r),
            ),
            9.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                children: [
                  Icon(Icons.circle, color: Colors.green, size: 12.w),
                  8.horizontalSpace,
                  ShimmerWidget(width: 100.w, height: 14.h, radius: 4.r),
                ],
              ),
            ),
            13.verticalSpace,
          ],
        ),
      ),
    );
  }
}
