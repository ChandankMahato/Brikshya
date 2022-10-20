import 'package:flutter/cupertino.dart';
import 'package:admin_app/constants/constants.dart';

class CustomTextStyleOne extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color myColor;
  final String fontFamily;
  final FontWeight weight;
  const CustomTextStyleOne({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.myColor = kMediumGreenColor,
    this.fontFamily = 'Ubuntu',
    this.weight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: myColor,
        fontWeight: weight,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
    );
  }
}
