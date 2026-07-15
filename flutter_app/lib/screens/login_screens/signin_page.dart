// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_returning_null_for_void, sort_child_properties_last, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';

import '../../componenets/social_card.dart';
import '../signin_screens/login_page.dart';
import 'components/signin_form.dart';

class SigninPage extends StatelessWidget {
  static String routeNeme = "/signin_page";

  @override
  Widget build(BuildContext context) {
    // قراءة البيانات المرسلة عبر arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "تسجيل دخول ",
                    style: headTextStyle(),
                  ),
                  Text(
                    "الرجاء إدخال البيانات",
                    style: TextStyle(fontSize: 10),
                  ),
                  if (args != null && args['message'] != null) ...[
                    SizedBox(height: 20),
                    Text(
                      args['message'],
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SignForm(),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/img/Screenshot (88).png",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/img/Screenshot (89).png",
                        press: () {},
                      ),
                      // SocialCard(
                      //   icon: "assets/img/Login.png",
                      //   press: () {},
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("مستخدم جديد؟ ", style: titleTextStyle()),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginPage.routeNeme);
                        },
                        child: Text(
                          "أنشىء حساب ",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
