import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/models/user.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/extensions.dart';
import 'package:traka/core/utils/order_status.dart';
import 'package:traka/core/utils/response_message.dart';
import 'package:traka/core/widgets/appbar.dart';
import 'package:traka/core/widgets/button.dart';
import 'package:traka/core/widgets/cached_image.dart';
import 'package:traka/features/details/cubit/details_cubit.dart';
import 'package:traka/features/details/models/order_status.dart';
import 'package:traka/features/details/widgets/order_info.dart';
import 'package:traka/features/details/widgets/rider_widget.dart';
import 'package:traka/features/details/widgets/timeline.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderItem order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool incomingStatus = false;
  late final String channelName;
  final UserModel user = locator<UserModel>();
  Queue<OrderStatusModel> statuses = Queue<OrderStatusModel>();

  @override
  void initState() {
    channelName = '${user.email}:order-tracking${widget.order.id}';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      locator<DetailsCubit>().subscribeToDetailsChannel(
          channelName: channelName, orderId: widget.order.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: locator<DetailsCubit>(),
      listener: (_, state) {
        if (state is OrderStatusSuccess && state.channelName == channelName) {
          statuses = state.statuses;
        }
        if (state is OrderStatusError) {
          ResponseMessage.showErrorSnack(
              context: context, message: state.message);
        }
        if (state is UpdateOrderStatusLoading) {
          incomingStatus = true;
        }
        if (state is UpdateOrderStatusError) {
          incomingStatus = false;
          ResponseMessage.showErrorSnack(
              context: context, message: state.message);
        }
        if (state is UpdateOrderStatusSuccess &&
            state.channelName == channelName) {
          incomingStatus = false;
          statuses.addFirst(state.status);
        }
      },
      builder: (_, state) {
        return Scaffold(
          appBar: const TrakaAppBar(titleText: 'Order Detail'),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimelineWidget(
                    orderStatus:
                        statuses.isEmpty ? null : statuses.first.status),
                20.verticalSpace,
                RiderWidget(order: widget.order, statuses: statuses.toList()),
                Divider(height: 40.h, color: AppColor.black.withOpacity(.2)),
                OrderInfoWidget(name: 'Order ID', value: '#${widget.order.id}'),
                OrderInfoWidget(
                    name: 'Order Date',
                    value:
                        DateFormat('E, MMM dd, y').format(widget.order.date)),
                const OrderInfoWidget(name: 'Order Type', value: 'Instant'),
                Divider(height: 40.h, color: AppColor.black.withOpacity(.2)),
                Text(
                  'Your order',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    AppCacheImage(
                      width: 82.w,
                      height: 82.w,
                      borderRadius: 20.r,
                      imgUrl: widget.order.product.image,
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.order.product.name}\t\tx${widget.order.quantity}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          8.verticalSpace,
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => Text(
                              '${widget.order.product.addOns[index]}\t\tx${widget.order.quantity}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            itemCount: widget.order.product.addOns.length,
                            separatorBuilder: (_, index) => 1.verticalSpace,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '₦ ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                              text: widget.order.totalPrice.formatToCurrency)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: statuses.isNotEmpty &&
                !statuses
                    .map((e) => e.status)
                    .contains(OrderStatusEnum.delivered),
            child: SizedBox(
              width: 210.w,
              height: 53.h,
              child: AppButton(
                width: 167.w,
                color: AppColor.black,
                buttonText: 'Increase Order Status',
                onPressed: incomingStatus
                    ? null
                    : () {
                        OrderStatusEnum? status;
                        if (statuses.isEmpty) {
                          status = OrderStatusEnum.orderPlaced;
                        } else {
                          int index = OrderStatusEnum.values.indexWhere(
                              (element) =>
                                  element.rank ==
                                  statuses.first.status.rank + 1);
                          if (index == -1) return;
                          status = OrderStatusEnum.values[index];
                        }
                        locator<DetailsCubit>()
                            .updateStatus(channelName, status);
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}
