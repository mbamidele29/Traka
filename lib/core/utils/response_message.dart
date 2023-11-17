import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponseMessage {
  static void showErrorSnack(
      {required BuildContext context, required String message}) {
    if (message.isNotEmpty) {
      _showMessage(context, color: Colors.red, message: message);
    }
  }

  static void showSuccessSnack(
      {required BuildContext context, required String message}) {
    _showMessage(context, color: const Color(0xFF4ECB71), message: message);
  }

  static Future _showMessage(BuildContext context,
      {required String message, required Color color}) async {
    OverlayEntry? overlayEntry;
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: 65.h,
          left: 20.w,
          right: 20.w,
          child: _Messenger(color, message)),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));
    if (overlayEntry.mounted == true) {
      overlayEntry.remove();
    }
  }
}

class _Messenger extends StatelessWidget {
  final Color color;
  final String message;
  const _Messenger(this.color, this.message);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 335.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 2),
              color: const Color(0xFF909090).withOpacity(.2),
            ),
          ],
        ),
        child: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
