import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_model.dart';
import 'package:user_app/provider/location_state.dart';
import 'package:user_app/provider/logged_in_state.dart';
import 'package:user_app/screens/onboarding_screen.dart';
import 'package:user_app/services/location.dart';
import 'package:user_app/services/storage.dart';

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
    bool? isLoggedIn = await Storage.isLoggedIn();
    Provider.of<LoggedInState>(context, listen: false).changeState(isLoggedIn!);
    Provider.of<LocationState>(context, listen: false)
        .changeState(await Location.locationServiceEnabled());
    await Future.delayed(const Duration(milliseconds: 3000), () {});
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
              splashContents[0].title,
              style: kAppName.copyWith(
                color: kDarkGreenColor,
                fontWeight: FontWeight.w900,
                fontFamily: redhat,
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
            child: Image.asset(splashContents[0].image),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: kLightGreenColor,
                height: 50,
                child: Center(
                  child: Text(
                    splashContents[0].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontFamily: ubuntu,
                      fontSize: 24,
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
