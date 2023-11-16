import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/utils/assets.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/order_status.dart';
import 'package:traka/core/widgets/shimmer.dart';

class TimelineWidget extends StatelessWidget {
  final OrderStatusEnum? orderStatus;
  const TimelineWidget({super.key, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadows = [
      BoxShadow(
        blurRadius: 30,
        offset: const Offset(5, 5),
        color: AppColor.shadowColor.withOpacity(.25),
      ),
      BoxShadow(
        blurRadius: 30,
        offset: const Offset(-5, 5),
        color: AppColor.shadowColor.withOpacity(.25),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: OrderStatusEnum.values
              .map(
                (e) => Expanded(
                  child: _TimeLineWidget(
                      color: orderStatus == null
                          ? null
                          : orderStatus!.rank >= e.rank
                              ? AppColor.green
                              : AppColor.grey.withOpacity(.3)),
                ),
              )
              .toList(),
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            boxShadow: shadows,
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: shadows,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                    child: Image.asset(AppAsset.bike,
                        color: AppColor.black.withOpacity(.6))),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderStatus?.title ?? '',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black),
                    ),
                    8.verticalSpace,
                    Text(
                      orderStatus?.description ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeLineWidget extends StatelessWidget {
  final Color? color;
  const _TimeLineWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: ShimmerWidget(width: 20.w, height: 4.h, radius: 20.r),
      );
    }
    return Container(
      height: 4.h,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20.r)),
    );
  }
}
