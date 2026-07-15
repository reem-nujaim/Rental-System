// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/Setting_screens/notifications_Screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DefualtTopContainer extends StatefulWidget {
  const DefualtTopContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  _DefualtTopContainerState createState() => _DefualtTopContainerState();
}

class _DefualtTopContainerState extends State<DefualtTopContainer> {
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchNotificationsCount();
  }

  Future<void> _fetchNotificationsCount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      final response = await http.get(
        Uri.parse('$baseUrl/notifications/unread-count'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          notificationCount = data['count'];
          print(
              "عدد الإشعارات غير المقروءة: $notificationCount"); // تحديث عدد الإشعارات
        });
      } else {
        print("فشل جلب عدد الإشعارات: ${response.body}");
      }
    } catch (e) {
      print("خطأ في جلب عدد الإشعارات: $e");
    }
  }

  Future<void> _markAllNotificationsAsRead() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      final response = await http.post(
        Uri.parse('$baseUrl/notifications/mark-all-as-read'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          notificationCount = 0; // تصفير عدد الإشعارات
        });
        print("تم تصفير الإشعارات بنجاح");
      } else {
        print("فشل تصفير الإشعارات: ${response.body}");
      }
    } catch (e) {
      print("خطأ في تصفير الإشعارات: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 200),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.amber,
                    size: 33,
                  ),
                  onPressed: () {
                    // التنقل إلى شاشة الإشعارات أولًا
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()),
                    ).then((_) {
                      // عند العودة من الشاشة، تأكد من تحديث عدد الإشعارات
                      _markAllNotificationsAsRead();
                      _fetchNotificationsCount();
                    });
                  },
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
