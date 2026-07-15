import 'dart:io';
import 'package:flutter/material.dart'; // أضف هذا للاستفادة من ChangeNotifier
import 'package:flutter_signin/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // اجعلها تمتد من ChangeNotifier
  Future<bool> verifyAccount(
      File frontImage, File backImage, String idNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      int? userId = prefs.getInt('user_id');

      if (token == null || userId == null) {
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/verify-account/$userId'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath(
          'identity_card_image_front', frontImage.path));
      request.files.add(await http.MultipartFile.fromPath(
          'identity_card_image_back', backImage.path));
      request.fields['identity_card_number'] = idNumber;

      var response = await request.send();

      if (response.statusCode == 200) {
        notifyListeners(); // أضف هذه لتحديث الواجهة عند النجاح
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
