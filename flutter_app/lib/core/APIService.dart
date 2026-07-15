import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category_Model/category_model.dart';
import '../models/item_Model/item_model.dart';
import '../constants.dart';

class APIService {
  final String baseURl;

  APIService({this.baseURl = baseUrl});

  // Fetch categories
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse("$baseUrl/password/reset");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "token": token,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }),
    );

    return jsonDecode(response.body);
  }

  // Fetch items by category ID
  Future<List<Item>> fetchCategoryItems(int categoryId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/items?category_id=$categoryId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<Item>> getItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/items'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          return data.map((json) => Item.fromJson(json)).toList();
        } else {
          print("البيانات غير متوقعة: $data");
          return [];
        }
      } else {
        print("خطأ عند جلب العناصر: ${response.body}");
        return [];
      }
    } catch (e) {
      print("استثناء أثناء جلب العناصر: $e");
      return [];
    }
  }

  Future<List<Item>> getItemsByCategoryId(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items/category/$categoryId'),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData is Map<String, dynamic> &&
            decodedData.containsKey('data')) {
          return (decodedData['data'] as List)
              .map((json) => Item.fromJson(json))
              .toList();
        }
      } else if (response.statusCode == 404) {
        print("Category $categoryId not found.");
        return [];
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }

      return [];
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  // Fetch new offers
  Future<List<Item>> fetchNewOffers() async {
    final response = await http.get(Uri.parse('$baseUrl/items/new_offers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load new offers');
    }
  }

  Future<List<Item>> searchItems(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search-items?query=$query'),
        headers: {'Content-Type': 'application/json'},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // ✅ التأكد من أن الاستجابة ليست فارغة
      if (response.body.isEmpty) {
        print("⚠️ Empty response body.");
        return []; // إرجاع قائمة فارغة بدلاً من حدوث خطأ
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // ✅ التأكد من أن المفتاح 'data' موجود وليس فارغًا
      if (!responseData.containsKey('data') || responseData['data'] == null) {
        print("⚠️ Key 'data' is missing or null.");
        return []; // تجنب حدوث خطأ إذا لم تكن هناك نتائج
      }

      final List<dynamic> data = responseData['data'];

      // ✅ التأكد من أن `data` قائمة
      if (data is! List) {
        throw Exception("❌ Invalid format: 'data' is not a list.");
      }

      return data.map((item) => Item.fromJson(item)).toList();
    } catch (e) {
      print("❌ Error: $e");
      throw Exception('Failed to load search results: $e');
    }
  }
}
