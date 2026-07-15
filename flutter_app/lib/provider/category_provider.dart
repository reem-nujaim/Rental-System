import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProvider extends ChangeNotifier {
  List<String> _categories = [];

  Future<List<String>> fetchCategories() async {
    if (_categories.isNotEmpty) return _categories; // استخدام الكاش

    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _categories =
            data.map((category) => category['ar_name'].toString()).toList();
        notifyListeners();
        return _categories;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }
}
