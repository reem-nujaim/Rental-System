// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

import '../../../constants.dart';

class showDefualtBotton extends StatelessWidget {
  const showDefualtBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      ),
      child: Text(
        "عرض الغرض",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
