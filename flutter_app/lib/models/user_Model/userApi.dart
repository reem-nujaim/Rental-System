import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'user_model.dart';

class ApiService {
  Future<bool> registerUser(UserModel user) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['message'] == "User registered successfully") {
          return true; // تم التسجيل بنجاح
        } else {
          throw Exception(data['message'] ?? "حدث خطأ غير معروف");
        }
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? "فشل التسجيل");
      }
    } catch (e) {
      throw Exception("خطأ: $e");
    }
  }
}
