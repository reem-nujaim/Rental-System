import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_model.dart';

class CategoryApi {
  final String baseUrl;

  CategoryApi({required this.baseUrl});

  // جلب قائمة الفئات وتحويلها إلى قائمة من الكائنات
  Future<List<Category>> getCategories() async {
    // final url = Uri.parse('$baseUrl/categories');
    final url = Uri.parse('$baseUrl/categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
