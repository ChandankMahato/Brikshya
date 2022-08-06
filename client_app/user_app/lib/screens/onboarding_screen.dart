import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/main.dart';
import 'package:user_app/models/onboarding_content.dart';
import 'package:user_app/screens/home.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  static const String id = '/onboarding';

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Map<String, dynamic> boardingContent = {
    'image': 'images/onboarding/splash1.png',
    'title': 'Welcome to Brikshya',
    'description':
        'One-stop platform to buy and sell nursery items, Join events and training, and employment services',
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final board = OnBoardingContent.fromData(data: boardingContent);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          const SizedBox(
            height: 96,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 3,
                    width: size.width * 0.75,
                    child: Image.asset(board.image),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    board.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    board.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 56,
                        margin: const EdgeInsets.all(40),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          label: const Icon(
                            Icons.home,
                            size: 40,
                          ),
                          onPressed: () {
                            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                Home.id, (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kLightGreenColor,
                            onPrimary: kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
