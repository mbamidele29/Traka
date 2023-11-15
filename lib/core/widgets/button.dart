import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/utils/colors.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final double? width;
  final double? radius;
  final Color? borderColor;
  final String? buttonText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  const AppButton({
    Key? key,
    this.child,
    this.radius,
    this.width,
    this.borderColor,
    this.buttonText,
    this.onPressed,
    this.textStyle,
    this.color,
  })  : assert(buttonText != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key ?? (buttonText == null ? UniqueKey() : ValueKey(buttonText!)),
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
          (states) => EdgeInsets.symmetric(vertical: 12.h),
        ),
        fixedSize: MaterialStateProperty.resolveWith<Size>(
          (states) => Size(width ?? 335.w, 48.h),
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) => RoundedRectangleBorder(
            side: BorderSide(
              color: onPressed == null
                  ? Colors.transparent
                  : borderColor ?? color ?? AppColor.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius ?? 27.r),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return (color ?? AppColor.primary).withOpacity(
                states.contains(MaterialState.disabled) || onPressed == null
                    ? .5
                    : 1);
          },
        ),
      ),
      child: child ??
          Text(
            buttonText!,
            style: textStyle ??
                TextStyle(
                  height: 1,
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
    );
  }
}
