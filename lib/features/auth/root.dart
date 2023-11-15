import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/utils/assets.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/core/widgets/button.dart';
import 'package:traka/features/auth/cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAsset.welcome,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.lightBlack,
                  AppColor.black,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                160.verticalSpace,
                RichText(
                  text: TextSpan(
                    text: 'Welcome to\n',
                    style: TextStyle(
                      height: 1.28,
                      fontSize: 53.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Traka',
                        style: TextStyle(color: AppColor.primary),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Text(
                  'Your favourite foods delivered\nfast at your door.',
                  style: TextStyle(
                    height: 1.28,
                    fontSize: 18.sp,
                    color: AppColor.x30384F,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                            height: 0, thickness: 1, color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        ' sign in with',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                            height: 0, thickness: 1, color: Colors.white)),
                  ],
                ),
                18.verticalSpace,
                Row(
                  children: [
                    SizedBox(
                      width: 139.w,
                      child: AppButton(
                        color: Colors.white,
                        onPressed: () {
                          locator<AuthCubit>().authWithGoogle();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppAsset.google,
                                width: 28.w, height: 28.w),
                            12.horizontalSpace,
                            Text(
                              'GOOGLE',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    35.horizontalSpace,
                    SizedBox(
                      width: 139.w,
                      child: AppButton(
                        color: Colors.white,
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppAsset.github,
                                width: 28.w, height: 28.w),
                            12.horizontalSpace,
                            Text(
                              'GITHUB',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                60.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
