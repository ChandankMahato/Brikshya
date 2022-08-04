import 'package:flutter/material.dart';

import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_content.dart';
import 'package:user_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String id = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(OnBoarding.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 96,
          ),
          Center(
            child: Text(
              onBoardingContents[0].title,
              style: kAppName.copyWith(
                color: kMediumGreenColor,
                fontWeight: FontWeight.w900,
                fontFamily: 'RedHatDisplay',
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 96,
          ),
          SizedBox(
            height: size.height / 3,
            width: size.width * 0.75,
            child: Image.asset(onBoardingContents[0].image),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: kLightGreenColor,
                height: 50,
                child: Center(
                  child: Text(
                    onBoardingContents[0].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontFamily: 'Ubuntu',
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
