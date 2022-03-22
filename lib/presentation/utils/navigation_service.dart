import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void back() {
    return navigatorKey.currentState!.pop();
  }
  // bool? goBack() {
  //   return navigatorKey.currentState.pop();
  // }
}