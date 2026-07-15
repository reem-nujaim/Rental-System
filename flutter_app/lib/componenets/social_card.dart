// ignore_for_file: use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String icon;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(icon), //svgpicture
        padding: EdgeInsets.all(12),
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
      ),
    );
  }
}
