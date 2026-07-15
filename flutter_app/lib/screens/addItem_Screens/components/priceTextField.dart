// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

TextField priceTextField({required Null Function(dynamic value) onChanged}) {
  return TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: 'ر.س',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}
