import 'package:flutter/material.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/features/404/root.dart';
import 'package:traka/features/auth/root.dart';
import 'package:traka/features/home/root.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  String? name = settings.name;

  switch (name) {
    case RouteKeys.auth:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case RouteKeys.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
