// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../componenets/defualt_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String routeNeme = "/reset_password";

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text.trim();
    String apiUrl = "$baseUrl/password/forgot";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _showMessage(
            "تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني", Colors.green);
      } else {
        _showMessage(
            responseData['message'] ?? "حدث خطأ أثناء العملية", Colors.red);
      }
    } catch (e) {
      _showMessage("تحقق من اتصال الإنترنت", Colors.red);
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "هل نسيت كلمة المرور؟",
                      style: headTextStyle(),
                    ),
                    SizedBox(height: 13),
                    Text(
                      textAlign: TextAlign.center,
                      "لا تقلق، أدخل بريدك الإلكتروني المرتبط بحسابك وسنرسل لك رابط إعادة التعيين.",
                    ),
                    SizedBox(height: 100),
                    buildEmailFormField(),
                    SizedBox(height: 40),
                    DefualtBotton(text: "إعادة تعيين", press: resetPassword),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "أدخل البريد الإلكتروني",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.email, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "الرجاء إدخال البريد الإلكتروني";
        }
        if (!RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
            .hasMatch(value)) {
          return "البريد الإلكتروني غير صالح";
        }
        return null;
      },
    );
  }
}
