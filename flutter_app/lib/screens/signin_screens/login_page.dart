// // ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_field, avoid_returning_null_for_void

// import 'package:flutter/material.dart';
// import 'package:flutter_signin/componenets/social_card.dart';
// import '../../constants.dart';
// import '../login_screens/signin_page.dart';
// import 'components/login_form.dart';

// ignore_for_file: prefer_const_constructors

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//   static String routeNeme = "/login_page";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SizedBox(
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "إنشاء حساب",
//                   style: headTextStyle(),
//                 ),
//                 Text(
//                   "الرجاء إدخال البيانات",
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 LoginForm(),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SocialCard(
//                       icon: "assets/img/Screenshot (88).png",
//                       press: () {},
//                     ),
//                     SocialCard(
//                       icon: "assets/img/Screenshot (89).png",
//                       press: () {},
//                     ),
//                     // SocialCard(
//                     //   icon: "assets/img/Login.png",
//                     //   press: () {},
//                     // ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, SigninPage.routeNeme);
//                       },
//                       child: Text(
//                         " سجل دخول",
//                         style: TextStyle(
//                             color: kPrimaryColor,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Text(
//                       " هل تملك حساب بالفعل؟ ",
//                       style: TextStyle(
//                         color: kTextColor,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// lib/screens/signin_screens/login_page.dart
import 'package:flutter/material.dart';
import '../../componenets/social_card.dart';
import 'components/login_form.dart';
import '../../constants.dart';
import '../login_screens/signin_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String routeNeme = "/login_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "إنشاء حساب",
                    style: headTextStyle(),
                  ),
                  Text(
                    "الرجاء إدخال البيانات",
                    style: TextStyle(fontSize: 10),
                  ),
                  LoginForm(),
                  SizedBox(
                    height: 30,
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" هل تملك حساب بالفعل؟ ", style: titleTextStyle()),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SigninPage.routeNeme);
                        },
                        child: Text(
                          " سجل دخول",
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
