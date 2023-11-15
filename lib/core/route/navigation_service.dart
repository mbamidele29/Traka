import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pop() async {
    return navigatorKey.currentState!.pop();
  }

  bool get canPop => navigatorKey.currentState?.canPop() ?? false;

  popWithData(Map data) async {
    navigatorKey.currentState!.pop(data);
  }

  popUntil(String route) =>
      navigatorKey.currentState!.popUntil(ModalRoute.withName(route));

  Future to(String routeName) async {
    return await navigatorKey.currentState!.pushNamed(routeName);
  }

  Future toWithPameter({required String routeName, required Map data}) async {
    return await navigatorKey.currentState!
        .pushNamed(routeName, arguments: data);
  }

  Future replaceWith(String routeName) async {
    return await navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future replaceWithPameter(
      {required String routeName, required Map data}) async {
    return await navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: data);
  }
}
