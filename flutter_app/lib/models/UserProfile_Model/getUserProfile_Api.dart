// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../constants.dart';

// class ApiService {
//   final String token;

//   ApiService({required this.token});

//   Future<Map<String, dynamic>> getUserProfile() async {
//     final url = Uri.parse('$baseUrl/user');
//     final headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     try {
//       final response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data;
//       } else {
//         final errorData = json.decode(response.body);
//         throw Exception(errorData['message'] ?? "فشل جلب البيانات");
//       }
//     } catch (e) {
//       throw Exception("خطأ: $e");
//     }
//   }
// }
import 'dart:convert';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String token;

  ApiService({required this.token});

  Future<Map<String, dynamic>> getUserProfile() async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        // 'Authorization':
        //     'Bearer 32|8oJT95yU3HE47qWNB6R4RXET7IRZd8IIxniWCSgN0d060174',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
