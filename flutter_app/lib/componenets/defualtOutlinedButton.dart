// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';

class defualtOutlinedButton extends StatelessWidget {
  const defualtOutlinedButton({
    super.key,
    required this.press,
    required this.text,
  });
  final String press;
  final String text;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, press);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: BorderSide(color: kPrimaryColor, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
