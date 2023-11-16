import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/utils/colors.dart';

class OrderInfoWidget extends StatelessWidget {
  final String name;
  final String value;
  const OrderInfoWidget({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
              child: Text(
            name,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.black,
              fontWeight: FontWeight.w600,
            ),
          )),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
