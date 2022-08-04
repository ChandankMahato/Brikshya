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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    child: Image.asset(onBoardingContents[1].image),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    onBoardingContents[1].title,
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
                    onBoardingContents[1].description,
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


// decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0, -4),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           ),
//                           BoxShadow(
//                             color: Color.fromARGB(255, 117, 117, 117),
//                             offset: Offset(0, 4),
//                             blurRadius: 15.0,
//                             spreadRadius: 1.0,
//                           ),
//                         ],
//                         gradient: const LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color.fromARGB(255, 238, 238, 238),
//                               Color.fromARGB(255, 224, 224, 224),
//                               Color.fromARGB(255, 189, 189, 189),
//                               Color.fromARGB(255, 158, 158, 158),
//                             ],
//                             stops: [
//                               0.1,
//                               0.3,
//                               0.8,
//                               0.9
//                             ]),
//                       ),
