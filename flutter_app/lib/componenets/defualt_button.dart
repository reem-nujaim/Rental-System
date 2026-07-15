// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';

class DefualtBotton extends StatelessWidget {
  const DefualtBotton({
    super.key,
    required this.text,
    required this.press,
  });
  final String text;
  final VoidCallback? press;
  //function
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(kPrimaryColor),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(66),
          )),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 18,
          ),
        ));
  }
}
