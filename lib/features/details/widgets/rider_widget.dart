import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/constants.dart';
import 'package:traka/core/widgets/button.dart';
import 'package:traka/core/widgets/cached_image.dart';
import 'package:traka/features/details/models/order_status.dart';

class RiderWidget extends StatelessWidget {
  final OrderItem order;
  final List<OrderStatusModel> statuses;
  const RiderWidget({super.key, required this.order, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCacheImage(
          width: 60.w,
          height: 60.w,
          borderRadius: 14.r,
          imgUrl: AppConstants.courierImage,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Delivery By ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                    ),
                    children: const [
                      TextSpan(
                          text: 'John Doe',
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ]),
              ),
              8.verticalSpace,
              Visibility(
                visible: statuses.isNotEmpty,
                child: SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: AppButton(
                    radius: 4.r,
                    textStyle: TextStyle(
                      height: 1,
                      fontSize: 16.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                    borderColor: AppColor.black,
                    buttonText: 'Track your Order',
                    color: Theme.of(context).scaffoldBackgroundColor,
                    onPressed: () => locator<NavigationService>().toWithPameter(
                        routeName: RouteKeys.orderTimeline,
                        data: {'order': order, 'statuses': statuses}),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
