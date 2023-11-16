import 'package:flutter/material.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/features/404/root.dart';
import 'package:traka/features/auth/root.dart';
import 'package:traka/features/details/root.dart';
import 'package:traka/features/details/views/order_timeline.dart';
import 'package:traka/features/home/root.dart';
import 'package:traka/features/splash_screen/root.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  String? name = settings.name;

  switch (name) {
    case RouteKeys.auth:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case RouteKeys.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RouteKeys.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case RouteKeys.orderDetails:
      Map args = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(order: args['order']));
    case RouteKeys.orderTimeline:
      Map args = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (_) => OrderTimelineScreen(
              order: args['order'], statuses: args['statuses']));
    default:
      return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
