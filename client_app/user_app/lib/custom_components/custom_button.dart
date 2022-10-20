import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final Widget buttonContent;
  final Color buttonColor;
  final bool border;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.buttonContent,
    this.buttonColor = kLightGreenColor,
    this.border = false,
    this.borderRadius = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ? Border.all(color: Colors.blue[400]!) : null,
          boxShadow: [
            BoxShadow(
              color: kGreyDarkColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        child: Center(
          child: buttonContent,
        ),
      ),
    );
  }
}
