import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traka/core/config/startup.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/core/utils/assets.dart';
import 'package:traka/core/utils/colors.dart';
import 'package:traka/features/auth/cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          locator<AuthCubit>().checkUserLogin();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: locator<AuthCubit>(),
      listener: (_, state) {
        if (state is AuthSuccess) {
          locator<NavigationService>().replaceWith(RouteKeys.home);
        }
        if (state is AuthError) {
          locator<NavigationService>().replaceWith(RouteKeys.auth);
        }
      },
      builder: (_, state) {
        return Scaffold(
            backgroundColor: AppColor.primary,
            body: Center(
                child: Image.asset(AppAsset.logo, width: 93.w, height: 93.w)));
      },
    );
  }
}
