import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/notificationModel.dart';
// ضع عنوان الـ API الصحيح هنا

// استرجاع التوكن من SharedPreferences
Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') ??
      ''; // يرجع التوكن أو قيمة فارغة إذا لم يكن موجودًا
}

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  // Getter للحصول على قائمة الإشعارات
  List<NotificationModel> get notifications => _notifications;

  // دالة لجلب الإشعارات من الـ API
  Future<void> fetchNotifications() async {
    final String apiUrl = '$baseUrl/notifications';
    final token = await getToken(); // استرجاع التوكن

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token', // إرسال التوكن في الهيدر
        'Content-Type': 'application/json',
      },
    );

    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse); // طباعة الاستجابة للتحقق منها

    // التحقق من الاستجابة
    if (response.statusCode == 200) {
      if (decodedResponse["data"] != null && decodedResponse["data"] is List) {
        List<dynamic> notifications = decodedResponse["data"];
        print("عدد الإشعارات: ${notifications.length}");

        // تحويل البيانات إلى كائنات NotificationModel
        _notifications = notifications
            .map((item) => NotificationModel.fromJson(item))
            .toList();
        notifyListeners(); // إعلام المستمعين بوجود تحديث
      } else {
        print("لم يتم العثور على إشعارات.");
      }
    } else {
      print("خطأ في جلب الإشعارات: ${response.statusCode}");
    }
  }
}
