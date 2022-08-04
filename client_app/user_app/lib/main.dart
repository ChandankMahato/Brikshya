import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/screens/onboarding_screen.dart';
import 'package:user_app/screens/splash_screen.dart';

void main() {
  runApp(const Brikshya());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Brikshya extends StatelessWidget {
  const Brikshya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Brikshya',
        theme: ThemeData(
          fontFamily: 'Ubuntu',
        ),
        initialRoute: SplashScreen.id,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          OnBoarding.id: (context) => const OnBoarding(),
          Home.id: (context) => const Home(),
        });
  }
}
