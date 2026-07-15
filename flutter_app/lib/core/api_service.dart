import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_signin/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';
import '../screens/addItem_Screens/additem_model.dart';
import 'SharedPreferences/SharedPreferencesHelper.dart'; // تأكد من استيراد الفئة الخاصة بك

class ApiService {
  static Future<bool> addItem(Item item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('access_token'); // 🔹 جلب التوكن من التخزين

      final response = await http.post(
        Uri.parse("$baseUrl/items"), // 🔹 تأكد أن هذا هو الـ Endpoint الصحيح
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null)
            "Authorization": "Bearer $token", // 🔹 إضافة التوكن إذا كان موجودًا
        },
        body: jsonEncode(item),
      );

      print("📥 استجابة السيرفر: ${response.statusCode}");
      print("🔹 الرد: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true; // 🔹 تمت العملية بنجاح
      } else {
        return false; // 🔹 فشل الطلب
      }
    } catch (e) {
      print("❌ خطأ أثناء إرسال البيانات: $e");
      return false;
    }
  }

  // دالة تسجيل الدخول
  // static Future<LoginResponse> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   final url = Uri.parse('$baseUrl/login');
  //   final response = await http.post(url, body: {
  //     'email': email,
  //     'password': password,
  //   });

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final loginResponse = LoginResponse.fromJson(data);

  //     // حفظ user_id عند تسجيل الدخول
  //     if (loginResponse.user?.id != null) {
  //       await SharedPrefsHelper().saveUserId(loginResponse.user!.id);
  //     }

  //     return loginResponse;
  //   } else {
  //     throw Exception('فشل في تسجيل الدخول');
  //   }
  // }
  static Future<LoginResponse?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(data);

      // حفظ user_id عند تسجيل الدخول
      if (loginResponse.user?.id != null) {
        await SharedPrefsHelper().saveUserId(loginResponse.user!.id);
      }

      return loginResponse;
    } else if (response.statusCode == 401) {
      // إرجاع null عند فشل تسجيل الدخول بدلًا من إطلاق استثناء
      return null;
    } else {
      throw Exception('حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا');
    }
  }

  // Future<Map<String, dynamic>> resetPassword({
  //   required String email,
  //   required String token,
  //   required String password,
  //   required String passwordConfirmation,
  // }) async {
  //   final url = Uri.parse("$baseUrl/password/reset");

  //   final response = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "email": email,
  //       "token": token,
  //       "password": password,
  //       "password_confirmation": passwordConfirmation,
  //     }),
  //   );

  //   return jsonDecode(response.body);
  // }

  // دالة لاسترجاع بيانات المستخدم باستخدام التوكن
  static Future<User?> fetchUserData(String token) async {
    final url =
        Uri.parse('$baseUrl/user'); // أو endpoint آخر يخص بيانات المستخدم
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // إرسال التوكن في الهيدر
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data); // تحويل البيانات إلى كائن User
      } else {
        throw Exception('فشل في جلب بيانات المستخدم');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
