// ignore_for_file: unused_element, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: kPrimaryColor.withOpacity(0.1),
          child: Icon(icon, color: kPrimaryColor, size: 30),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
