import 'dart:convert';
import 'package:http/http.dart' as http;
import 'item_model.dart';

class ItemAPI {
  final String baseUrl;

  ItemAPI({required this.baseUrl});

  /// إضافة عنصر جديد
  Future<bool> addItem(Item item) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/items'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(item.toJson()),
          )
          .timeout(const Duration(seconds: 10)); // تحديد مهلة للطلب

      if (response.statusCode == 201) {
        print("✅ تم إضافة العنصر بنجاح!");
        return true;
      } else {
        print("❌ فشل الإضافة: ${response.statusCode}");
        print("⚠️ استجابة السيرفر: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ استثناء أثناء الإرسال: $e");
      return false;
    }
  }

  // Future<bool> addItem(Item item) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/items'),
  //       //  headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(item.toJson()),
  //     );

  //     if (response.statusCode == 201) {
  //       return true;
  //     } else {
  //       print("خطأ عند إضافة العنصر: ${response.body}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("استثناء أثناء الإضافة: $e");
  //     return false;
  //   }
  // }

  /// جلب جميع العناصر
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

  /// حذف عنصر
  Future<bool> deleteItem(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/items/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        print("خطأ عند حذف العنصر: ${response.body}");
        return false;
      }
    } catch (e) {
      print("استثناء أثناء الحذف: $e");
      return false;
    }
  }
}
