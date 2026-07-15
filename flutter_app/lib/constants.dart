// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_signin/screens/VerificationScreen.dart";
import "package:shared_preferences/shared_preferences.dart";
import "screens/addItem_Screens/fullAdd_screen.dart";
import "screens/login_screens/signin_page.dart";
import 'package:http/http.dart' as http;

const kPrimaryColor = Color(0xFF567C8D);
//const kPrimaryColor = Color.fromARGB(255, 234, 113, 32);
//const kPrimaryColor = Color.fromARGB(255, 163, 142, 162);
const kPrimaryColor2 = Color.fromARGB(255, 117, 165, 187);
const kSecondaryColor = Colors.white;
const kTextColor = Color(0xFF757575);
const kTextColor2 = Colors.white70;
const kTextColor3 = Colors.black12;

//Form Errors
final RegExp emailValidatorRegExp = //RegExp(r"^[a-zA-Z0-9.]+@gmail+\.com+");
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullErroe = "أدخل البريد من فضلك";
const String kInvalidEmailError = "أدخل بريد صحيح من فضلك";
const String kPassNull = "أدخل كلمة المرور من فضلك";
const String kShortPassError = "كلمة المرور قصيرة جدا";
const String kMatchPassError = "كلمة المرور غير مطابقة";
const String kNameNullError = "أدخل الاسم من فضلك";
const String kPhoneNullError = "أدخل رقم الهاتف من فضلك";

//TextStyle
TextStyle headTextStyle() {
  return TextStyle(
    color: kPrimaryColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}

TextStyle titleTextStyle() =>
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

TextStyle headTextStyle2() {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  enabledBorder: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(),
  border: OutlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}

//DefualtTopAppBar
AppBar DefualtTopAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: kSecondaryColor),
    backgroundColor: kPrimaryColor,
  );
}

Future<bool> getLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') !=
      null; // التحقق إذا كان التوكن موجودًا
}

FloatingActionButton defaultFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () async {
      bool isLoggedIn = await getLoggedIn(); // تحقق من حالة تسجيل الدخول
      if (!isLoggedIn) {
        // إذا لم يكن مسجل الدخول، انتقل إلى صفحة تسجيل الدخول
        Navigator.pushNamed(
          context,
          SigninPage.routeNeme,
          arguments: {
            'message': "لا يمكنك إضافة غرض ما ! يجب عليك تسجيل الدخول أولا",
          },
        );
        return; // إنهاء التنفيذ هنا حتى لا يستمر الكود
      }

      // جلب حالة توثيق الحساب من API أو SharedPreferences
      bool isVerified = await fetchVerificationStatusFromAPI();

      if (isVerified) {
        // إذا كان الحساب موثقًا، انتقل إلى شاشة إضافة الغرض
        Navigator.pushNamed(context, FulladdScreen.routeName);
      } else {
        // إذا لم يكن الحساب موثقًا، انتقل إلى شاشة التوثيق
        Navigator.pushNamed(context, VerifyAccountScreen.routeName);
      }
    },
    backgroundColor: kPrimaryColor,
    child: Icon(Icons.add),
  );
}

// وظيفة لجلب حالة التوثيق من API
Future<bool> fetchVerificationStatusFromAPI() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await http.get(
      Uri.parse('$baseUrl/user/verification-status'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['is_verified'] ?? false;
    } else {
      print("فشل جلب حالة التوثيق: ${response.body}");
      return false;
    }
  } catch (e) {
    print("خطأ في جلب حالة التوثيق: $e");
    return false;
  }
}

//baseUrl
const String baseUrl = 'http://192.168.47.1:8000/api';
