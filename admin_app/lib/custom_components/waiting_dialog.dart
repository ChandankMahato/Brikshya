import '../constants/constants.dart';
import 'package:flutter/material.dart';

class WaitingDialog extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color progressIndicatorColor;
  final Color textColor;
  const WaitingDialog({
    required this.title,
    this.borderColor = kDarkGreenColor,
    this.progressIndicatorColor = kDarkGreenColor,
    this.textColor = kBlackColor,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: borderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 10.0,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressIndicatorColor,
                ),
                backgroundColor: progressIndicatorColor.withOpacity(0.5),
              ),
              // SizedBox(
              //   width: 80,
              //   height: 80,
              //   child: Image.asset(
              //     'images/onboarding/logo.png',
              //   ),
              // ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                title + '...Please Wait...',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
