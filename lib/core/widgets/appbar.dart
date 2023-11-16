import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/colors.dart';

class TrakaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? lead;
  final Widget? action;
  final Color? leadColor;
  final bool centerTitle;
  final double elevation;
  final String? titleText;
  final double? leadingWidth;
  final Function()? onBackPressed;
  const TrakaAppBar({
    Key? key,
    this.lead,
    this.action,
    this.titleText,
    this.leadColor,
    this.leadingWidth,
    this.elevation = 2,
    this.onBackPressed,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      shadowColor: Colors.black.withOpacity(.2),
      elevation: elevation,
      leading: lead ??
          IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back_outlined,
              color: leadColor ?? AppColor.primaryTextColor,
            ),
            onPressed:
                onBackPressed ?? () => locator<NavigationService>().pop(),
          ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actions: [action ?? const SizedBox()],
      centerTitle: centerTitle,
      title: titleText == null
          ? null
          : Text(
              titleText!,
              style: TextStyle(
                height: 1,
                fontSize: 18.sp,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
