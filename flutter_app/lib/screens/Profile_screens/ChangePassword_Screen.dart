// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/login_screens/reset_password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
import 'account_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeNeme = '/ChangePassword_Screen';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _prefsHelper = SharedPrefsHelper();
  bool obscurePassword = true; // لإدارة إخفاء/إظهار كلمة المرور
  bool obscureConfirmPassword = true;

  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    await _prefsHelper.init();
    setState(() {
      _token = _prefsHelper.getString('access_token');
    });
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate() && _token != null) {
      final url = Uri.parse("$baseUrl/change-password");

      try {
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'current_password': _currentPasswordController.text,
            'new_password': _newPasswordController.text,
            'new_password_confirmation': _confirmPasswordController.text,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("تم تغيير كلمة المرور بنجاح")),
          );
          Navigator.pop(context); // العودة إلى الشاشة السابقة
        } else {
          final error = jsonDecode(response.body)['message'] ?? 'خطأ غير معروف';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل: $error")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطأ: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("التوكن غير متوفر. قم بتسجيل الدخول مجددًا.")),
      );
    }
  }

  // دالة عرض رسالة تأكيد
  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // لا يمكن إغلاق الحوار بالنقر خارجه
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد تغيير كلمة المرور"),
          content: Text("هل أنت متأكد أنك تريد تغيير كلمة المرور؟"),
          actions: <Widget>[
            TextButton(
              child: Text("إلغاء"),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
            ),
            TextButton(
              child: Text("تأكيد"),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
                _changePassword(); // تنفيذ تغيير كلمة المرور
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AccountScreen.routeName);
                }),
          ],
          title: Text(
            "تغيير كلمة المرور",
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: _token == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          TextFormField(
                            controller: _currentPasswordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword =
                                        !obscurePassword; // تبديل حالة الإخفاء
                                  });
                                },
                              ),
                              labelText: "كلمة المرور الحالية",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: kTextColor),
                                gapPadding: 10,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال كلمة المرور الحالية";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword =
                                        !obscurePassword; // تبديل حالة الإخفاء
                                  });
                                },
                              ),
                              labelText: "كلمة المرور الجديدة",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: kTextColor),
                                gapPadding: 10,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return "يجب أن تكون كلمة المرور 8 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: obscureConfirmPassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword; // تبديل حالة الإخفاء
                                  });
                                },
                              ),
                              labelText: "تأكيد كلمة المرور الجديدة",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(color: kTextColor),
                                gapPadding: 10,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
                            ),
                            validator: (value) {
                              if (value != _newPasswordController.text) {
                                return "كلمتا المرور غير متطابقتين";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DefualtBotton(
                              text: "تغيير كلمة المرور",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  showConfirmationDialog(); // عرض مربع التأكيد
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Center(
                                child: Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ResetPassword.routeNeme);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
