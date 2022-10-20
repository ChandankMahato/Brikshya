import 'package:flutter/material.dart';
import 'package:user_app/constants.dart';

showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: kWhiteColor,
        fontSize: 16.0,
      ),
    ),
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20.0),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
