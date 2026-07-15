// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, annotate_overrides
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/otp_Form.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});
  static String routeNeme = "/otp_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("تأكيد رقم الهاتف", style: headTextStyle()),
                  Text(
                    "تم إرسال كلمة مرور واحدة\n (OTP) إلى رقم هاتفك",
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  OtpForm(),
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "إعادة الإرسال",
                      style: TextStyle(
                        fontSize: 16,
                        color: kTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
