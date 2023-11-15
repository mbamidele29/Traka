import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/extensions.dart';
import 'package:traka/core/widgets/cached_image.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<NavigationService>().toWithPameter(
          routeName: RouteKeys.orderDetails, data: {'order': order}),
      child: ClipRRect(
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
              Stack(
                children: [
                  Hero(
                    tag: order.id,
                    child: AppCacheImage(
                      width: 343.w,
                      height: 165.h,
                      borderRadius: 18.2.r,
                      imgUrl: order.product.image,
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    left: 13.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: const Offset(5, 10),
                              color: AppColor.shadowColor.withOpacity(.3),
                            )
                          ]),
                      child: RichText(
                        text: TextSpan(
                          text: '₦ ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                                text: order.totalPrice.formatToCurrency,
                                style: const TextStyle(color: AppColor.black))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Text(
                  order.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              9.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 12.w),
                    8.horizontalSpace,
                    Text(
                      'Status',
                      maxLines: 1,
                      style: TextStyle(
                        height: 1,
                        fontSize: 14.sp,
                        color: AppColor.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              13.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
