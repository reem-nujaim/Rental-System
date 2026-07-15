// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/home_page.dart';
import '../../../componenets/defualt_button.dart';
import '../../../componenets/form_errors.dart';
import '../../../constants.dart';
import '../../../core/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد المكتبة
import '../reset_password.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool remember = false;
  bool obscurePassword = true; // لإدارة إخفاء/إظهار كلمة المرور
  final List<String> errors = [];
  bool isLoading = false;

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  // دالة لحفظ التوكن في SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  // دالة للحصول على التوكن من SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  void handleLogin() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // استدعاء API لتسجيل الدخول
      final response = await ApiService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (response != null && response.token.isNotEmpty) {
        // حفظ التوكن
        await saveToken(response.token);

        // استرجاع بيانات المستخدم باستخدام التوكن
        final user = await ApiService.fetchUserData(response.token);
        if (user != null) {
          // حفظ معرف المستخدم بعد استرجاع البيانات
          await saveUserId(user.id);
        }

        // تسجيل الدخول ناجح
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('نجاح'),
            content: Text('تم تسجيل الدخول بنجاح'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق الـ Dialog
                  Navigator.pushNamed(
                      context, HomePage.routeNeme); // الانتقال للصفحة الرئيسية
                },
                child: Text('حسنًا'),
              ),
            ],
          ),
        );
      } else {
        // تسجيل الدخول فشل
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('خطأ'),
            content: Text('البريد الإلكتروني أو كلمة المرور غير صحيحة'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق الـ Dialog
                },
                child: Text('حسنًا'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: 30),
            buildPasswordFormField(),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  },
                ),
                Text("حفظ معلومات تسجيل الدخول"),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ResetPassword.routeNeme);
                  },
                  child: Text(
                    "هل نسيت كلمة المرور",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            FormError(errors: errors),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : DefualtBotton(
                    text: "تسجيل دخول",
                    press: handleLogin,
                  ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obscurePassword,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNull);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kPassNull);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "أدخل كلمة المرور",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.lock, color: kTextColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: kTextColor,
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword; // تبديل حالة الإخفاء
            });
          },
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullErroe);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kEmailNullErroe);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
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
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }
}
