// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:provider/provider.dart';

import '../../models/notificationModel.dart';
import '../../provider/NotificationsProvider.dart';

class NotificationsScreen extends StatefulWidget {
  static String routeName = "/notifications_Screen";

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب الإشعارات عند بدء الشاشة
    Provider.of<NotificationsProvider>(context, listen: false)
        .fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: kSecondaryColor),
            backgroundColor: kPrimaryColor,
            title: Text(
              'إشعاراتي',
              style: TextStyle(color: kSecondaryColor),
            )),
        body: Consumer<NotificationsProvider>(
          // استخدام Consumer للتحديث التلقائي
          builder: (context, provider, _) {
            // في حالة عدم وجود إشعارات
            if (provider.notifications.isEmpty) {
              return Center(child: Text('لا توجد إشعارات حالياً'));
            }
            // عرض قائمة الإشعارات
            return ListView.builder(
              itemCount: provider.notifications.length,
              itemBuilder: (ctx, index) {
                NotificationModel notification = provider.notifications[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(notification.title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)),
                      subtitle: Text(notification.body),
                      trailing: Text(
                          notification.createdAt.split('T')[0]), // عرض التاريخ
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
