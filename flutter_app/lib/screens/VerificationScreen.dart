// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/SharedPreferences/SharedPreferencesHelper.dart';
import '../provider/authProvider.dart';

class VerifyAccountScreen extends StatefulWidget {
  static const routeName = "/verify-account";

  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  File? _frontImage;
  File? _backImage;
  final TextEditingController _idNumberController = TextEditingController();

  bool _isIdValid(String id) {
    final regex = RegExp(r'^01\d{9}$'); // يبدأ بـ 01 ويحتوي على 11 رقمًا
    return regex.hasMatch(id);
  }

  Future<void> _pickImage(bool isFront) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _submitVerification() async {
    if (_frontImage == null ||
        _backImage == null ||
        _idNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى تحميل صور الهوية وإدخال رقم الهوية")),
      );
      return;
    }

    if (!_isIdValid(_idNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("رقم الهوية غير صحيح، يجب أن يكون 11 رقمًا ويبدأ بـ 01")),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.verifyAccount(
      _frontImage!,
      _backImage!,
      _idNumberController.text,
    );

    if (success) {
      await SharedPrefsHelper().verifyAccount(); // تحديث حالة التوثيق
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم إرسال طلب التوثيق بنجاح")),
      );
      Navigator.pop(context); // العودة إلى الشاشة السابقة
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل إرسال طلب التوثيق")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSecondaryColor),
          title: Text(
            "توثيق الحساب",
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "لإضافة غرض يجب عليك توثيق حسابك أولا",
                  style: headTextStyle2(),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.account_box_outlined, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "يرجى رفع صور الهوية وإدخال رقم الهوية",
                      style: headTextStyle2(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("الوجه الأمامي"),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () => _pickImage(true),
                          ),
                          if (_frontImage != null)
                            Image.file(_frontImage!, height: 80),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text("الوجه الخلفي"),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () => _pickImage(false),
                          ),
                          if (_backImage != null)
                            Image.file(_backImage!, height: 80),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _idNumberController,
                  decoration: InputDecoration(
                    labelText: "رقم الهوية",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: kTextColor),
                      gapPadding: 10,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                    errorText: _idNumberController.text.isNotEmpty &&
                            !_isIdValid(_idNumberController.text)
                        ? "يجب أن يكون رقم الهوية 11 رقمًا ويبدأ بـ 01"
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                DefualtBotton(
                  text: "إرسال طلب التوثيق",
                  press: _submitVerification,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
