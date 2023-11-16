import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/models/order_item.dart';
import 'package:traka/core/models/user.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/assets.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/utils/constants.dart';
import 'package:traka/core/utils/response_message.dart';
import 'package:traka/core/widgets/appbar.dart';
import 'package:traka/core/widgets/button.dart';
import 'package:traka/core/widgets/cached_image.dart';
import 'package:traka/features/auth/cubit/auth_cubit.dart';
import 'package:traka/features/home/cubit/home_cubit.dart';
import 'package:traka/features/home/widgets/order_shimmer_widget.dart';
import 'package:traka/features/home/widgets/orders.dart';
import 'package:traka/features/home/widgets/orders_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String channelName;
  final UserModel user = locator<UserModel>();

  bool incomingOrder = false;
  Queue<OrderItem> orders = Queue<OrderItem>();

  @override
  void initState() {
    channelName = '${user.email}:orders';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // delay to simulate loading
      _loadData();
    });
    super.initState();
  }

  Future<void> _loadData() async {
    orders.clear();
    Future.delayed(const Duration(seconds: 1), () {
      locator<HomeCubit>().subscribeToOrdersChannel(channelName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: locator<HomeCubit>(),
      listener: (_, state) {
        if (state is CreateOrderLoading) {
          incomingOrder = true;
        }
        if (state is CreateOrderSuccess) {
          incomingOrder = false;
          orders.addFirst(state.order);
        }
        if (state is CreateOrderError) {
          incomingOrder = false;
          ResponseMessage.showErrorSnack(
              context: context, message: state.message);
        }

        if (state is GetOrdersSuccess) {
          orders = state.orders;
        }
      },
      builder: (_, state) {
        return Scaffold(
          appBar: TrakaAppBar(
            leadingWidth: 250.w,
            action: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: TextButton(
                onPressed: () {
                  locator<AuthCubit>().signout();
                  locator<NavigationService>().replaceWith(RouteKeys.auth);
                },
                child: Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            lead: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 10.w),
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                          color: AppColor.shadowColor.withOpacity(.2),
                        )
                      ],
                    ),
                    child: AppCacheImage(
                      width: 10.w,
                      height: 10.w,
                      borderRadius: 12.r,
                      imgUrl: user.image ?? AppConstants.defaultProfileImage,
                    ),
                  ),
                ),
                Text(
                  'Welcome, ${user.firstName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your orders',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  20.verticalSpace,
                  Visibility(
                    visible: incomingOrder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OrderItemShimmerWidget(),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                  Visibility(
                    visible: orders.isEmpty,
                    replacement: OrdersWidget(orders: orders),
                    child: const OrdersShimmerWidget(),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 210.w,
            height: 53.h,
            child: AppButton(
              width: 167.w,
              onPressed: incomingOrder
                  ? null
                  : () => locator<HomeCubit>().createOrder(channelName),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(AppAsset.cart),
                  ),
                  10.horizontalSpace,
                  Text(
                    'CREATE NEW ORDER',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
