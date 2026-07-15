// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (Index) => formErrorText(error: errors[Index])),
    );
  }

  Directionality formErrorText({required String error}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Icon(
            Icons.error,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text(error),
        ],
      ),
    );
  }
}
