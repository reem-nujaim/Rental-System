// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';

class CategoryItemScreen extends StatelessWidget {
  final String title;
  final String items;

  const CategoryItemScreen(
      {super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: headTextStyle2(),
                ),
                SizedBox(height: 4),
                Text(
                  items,
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
            // السهم
            Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: kSecondaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
