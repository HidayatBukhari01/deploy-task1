import 'package:diploy_task/routes/routes_name.dart';
import 'package:diploy_task/screens/splash_screen.dart';
import 'package:diploy_task/screens/tab_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Map<String, Widget Function(BuildContext)> routes = {
    RouteName.splashRoute: (context) => const SplashScreen(),
    RouteName.homeRoute: (context) => const TabScreen(),
  };
}
