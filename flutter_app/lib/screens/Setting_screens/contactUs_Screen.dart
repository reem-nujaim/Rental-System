// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  static String routeName = "/contactUs_Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تواصل معنا"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "للتواصل معنا",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "إذا كان لديك أي استفسار أو شكوى، يمكنك التواصل معنا عبر الوسائل التالية:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // نموذج الاتصال
              TextFormField(
                decoration: InputDecoration(
                  labelText: "الاسم",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "البريد الإلكتروني",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "الرسالة",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // يمكنك إضافة وظيفة إرسال الرسالة هنا
                },
                child: Text("إرسال"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
