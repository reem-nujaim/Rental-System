// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class searchbox extends StatelessWidget {
  const searchbox({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged, // جعل onChanged اختيارياً
    this.onSubmitted, // إضافة onSubmitted لبدء البحث مباشرة عند الضغط على "إدخال"
  });

  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: TextField(
        controller: controller,
        //autofocus: true, // لجعل المؤشر يظهر تلقائيًا
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: onChanged, // سيتم استدعاء onChanged إذا تم تمريره
        onSubmitted: onSubmitted, // تنفيذ البحث عند الضغط على "إدخال"
      ),
    );
  }
}
