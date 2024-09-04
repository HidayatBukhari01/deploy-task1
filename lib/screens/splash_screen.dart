import 'dart:async';
import 'dart:developer';
import 'package:diploy_task/routes/routes_name.dart';
import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final useViewModel = useMemoized(() => Provider.of<CartViewModel>(context, listen: false));
    //This function is to check whether user is already signed in or not and redirects accorodingly.
    Future<bool> isAuthenticated() async {
      useViewModel.getCartItems();
      return true;
    }

    useEffect(() {
      const duration = Duration(milliseconds: 2000);
      final timmer = Timer(duration, () {
        isAuthenticated().then((isAuth) {
          if (isAuth) {
            //Move to Home Screen
            Navigator.of(context).pushNamedAndRemoveUntil(RouteName.homeRoute, (route) => false);
          } else {
            //Here should've moved to login screen, since no such support so moves to Home Screen
            Navigator.of(context).pushNamedAndRemoveUntil(RouteName.homeRoute, (route) => false);
            log("Invalid Login");
          }
        });
      });
      return () => timmer.cancel();
    }, []);

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 160,
                  width: 160,
                ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Diploy Task',
                  textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
              onTap: null,
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Simple Store',
                  speed: const Duration(milliseconds: 100),
                  textStyle: const TextStyle(
                      fontSize: 34, color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ],
              onTap: null,
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
            )
          ]),
    );
  }
}
