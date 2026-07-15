// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/completeProfile_form.dart';

class CompleteprofilePage extends StatelessWidget {
  CompleteprofilePage({super.key});
  static String routeNeme = "/completeProfile_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "إنشاء حساب",
                style: headTextStyle(),
              ),
              Text(
                // textAlign: ,
                "الرجاء إتمام إنشاء الحساب",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CompleteProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
