// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../constants.dart';
import '../models/UserProfile_Model/UserProfileModel.dart';

class PublicProfileScreen extends StatelessWidget {
  static const routeName = "/UserProfileScreen";
  const PublicProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserData(), // هنا نستخدم Future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final user = UserProfile.fromJson(
                snapshot.data!); // تحويل البيانات إلى UserProfile
            return _buildPublicProfileContent(user);
          } else {
            return const Center(child: Text("لا توجد بيانات لعرضها"));
          }
        },
      ),
    );
  }

  Widget _buildPublicProfileContent(UserProfile user) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: AssetImage("assets/img/hints.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  // **كونتينر حالة التوثيق**
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: user.isVerified ? Colors.green : Colors.red,
                  //       borderRadius: BorderRadius.all(Radius.circular(20))),
                  //   width: 200,
                  //   padding: EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         user.isVerified ? Icons.verified : Icons.error,
                  //         color: Colors.white,
                  //       ),
                  //       SizedBox(width: 8),
                  //       Text(
                  //         user.isVerified ? "الحساب موثق ✅" : "الحساب غير موثق ❌",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    String? userId = prefs.getString('user_id');

    if (token == null || userId == null) {
      throw Exception("لم يتم العثور على التوكن أو معرف المستخدم");
    }

    final url = Uri.parse("$baseUrl/user/$userId");
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(
            response.body); // إرجاع البيانات كـ Map<String, dynamic>
      } else {
        throw Exception("فشل في جلب البيانات: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("حدث خطأ: $e");
    }
  }
}
