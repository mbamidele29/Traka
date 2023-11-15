import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponseMessage {
  static void showErrorSnack({
    required BuildContext context,
    required String message,
  }) {
    if (message.isNotEmpty) {
      _showSnack(context, message, Colors.red);
    }
  }

  static void showSuccessSnack({
    required BuildContext context,
    required String message,
  }) {
    _showSnack(context, message, const Color(0xFF4ECB71));
  }

  static void _showSnack(BuildContext context, String message, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      backgroundColor: color,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 22.w),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
