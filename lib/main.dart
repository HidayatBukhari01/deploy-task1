import 'package:diploy_task/routes/routes.dart';
import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_view_model.dart';
import 'package:diploy_task/screens/tab.screens/hometab.screen/home_tab_view_model.dart';
import 'package:diploy_task/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //To ensure Device is in portrait mode.
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TabViewModel>(
          create: (context) => TabViewModel(),
        ),
        ChangeNotifierProvider<HomeTabViewModel>(
          create: (context) => HomeTabViewModel(),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (context) => CartViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Deploy Demo App',
        debugShowCheckedModeBanner: false,
        routes: Routes().routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
