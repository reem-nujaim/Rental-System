// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/login_screens/signin_page.dart';
import '../componenets/defualtOutlinedButton.dart';
import '../componenets/defualt_button.dart';
import 'ButtomAppBarSreens/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  static String routeNeme = "/welcome_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 220),
            Text(
              'أهلاً بك في كراء',
              style: TextStyle(
                fontSize: 28,
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'منصة تأجير: أجّر واستأجر أي عرض',
              style: TextStyle(
                fontSize: 16,
                color: kTextColor2,
              ),
            ),
            SizedBox(height: 100),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    DefualtBotton(
                        text: "هل لديك حساب؟ سجل دخول",
                        press: () {
                          Navigator.pushNamed(context, SigninPage.routeNeme);
                        }),
                    SizedBox(height: 20),
                    defualtOutlinedButton(
                      press: "/login_page",
                      text: "مستخدم جديد؟ أنشىء حساب",
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HomePage.routeNeme);
                      },
                      child: Text(
                        'اكتشف التطبيق',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
