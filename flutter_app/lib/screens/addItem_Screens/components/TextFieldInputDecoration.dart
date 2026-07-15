// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';

InputDecoration TextFieldInputDecoration(final String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: kTextColor,
        width: 1.0,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
