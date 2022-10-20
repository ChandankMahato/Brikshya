import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';
import 'package:user_app/custom_components/customText.dart';

Padding futureLoader() {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: CircularProgressIndicator(
      valueColor: const AlwaysStoppedAnimation(kDarkGreenColor),
      backgroundColor: kDarkGreenColor.withOpacity(0.5),
    ),
  );
}

Image brikshyaLoader() {
  return Image.asset(
    'images/loader.gif',
    height: 100,
    width: 100,
  );
}

Image brikshyaLoaderSmall() {
  return Image.asset(
    'images/loader.gif',
    height: 60,
    width: 60,
  );
}

Column networkError() {
  return Column(
    children: const [
      Icon(
        Icons.error_outline,
        size: 164,
        color: Colors.black45,
      ),
      CustomTextStyleOne(
        text: 'Network Error!',
        fontSize: 24,
        weight: FontWeight.w600,
        myColor: kDarkGreenColor,
        fontFamily: redhat,
      ),
    ],
  );
}

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height - 132,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/noproduct.png',
            width: 180,
            height: 164,
          ),
        ],
      ),
    );
  }
}

Icon loginIconWidget() {
  return Icon(
    Icons.login,
    size: 164,
    color: Colors.black45.withOpacity(0.5),
  );
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.title,
    required this.icondata,
  }) : super(key: key);

  final String title;
  final IconData icondata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icondata,
          size: 164,
          color: Colors.black45.withOpacity(0.5),
        ),
        CustomTextStyleOne(
          text: title,
          fontSize: 24,
          weight: FontWeight.w600,
          myColor: kDarkGreenColor,
          fontFamily: redhat,
        ),
      ],
    );
  }
}
