// import 'package:flutter/material.dart';

// class ItemProvider with ChangeNotifier {
//   String? selectedCategory;
//   String? selectedStatus;
//   String? selectedDeliveryMethod;
//   String? itemName;
//   String? itemDescription;
//   String? location;
//   double? priceAssurance;
//   double? pricePerHour;
//   double? pricePerDay;
//   int? quantity;
//   int? minRentalDuration;
//   int? maxRentalDuration;
//   int? availabilityHours;
//   List<String> imagePaths = [];

//   void setCategory(String category) {
//     selectedCategory = category;
//     notifyListeners();
//   }

//   void setStatus(String status) {
//     selectedStatus = status;
//     notifyListeners();
//   }

//   void setDeliveryMethod(String method) {
//     selectedDeliveryMethod = method;
//     notifyListeners();
//   }

//   void setItemName(String name) {
//     itemName = name;
//     notifyListeners();
//   }

//   void setItemDescription(String description) {
//     itemDescription = description;
//     notifyListeners();
//   }

//   void setLocation(String loc) {
//     location = loc;
//     notifyListeners();
//   }

//   void setPriceAssurance(double price) {
//     priceAssurance = price;
//     notifyListeners();
//   }

//   void setPricePerHour(double price) {
//     pricePerHour = price;
//     notifyListeners();
//   }

//   void setPricePerDay(double price) {
//     pricePerDay = price;
//     notifyListeners();
//   }

//   void setQuantity(int qty) {
//     quantity = qty;
//     notifyListeners();
//   }

//   void setMinRentalDuration(int duration) {
//     minRentalDuration = duration;
//     notifyListeners();
//   }

//   void setMaxRentalDuration(int duration) {
//     maxRentalDuration = duration;
//     notifyListeners();
//   }

//   void setAvailabilityHours(int hours) {
//     availabilityHours = hours;
//     notifyListeners();
//   }

//   void addImagePath(String path) {
//     imagePaths.add(path);
//     notifyListeners();
//   }

//   void clearImages() {
//     imagePaths.clear();
//     notifyListeners();
//   }

//   void resetData() {
//   selectedCategory = null;
//   selectedStatus = null;
//   selectedDeliveryMethod = null;
//   itemName = null;
//   itemDescription = null;
//   location = null;
//   priceAssurance = null;
//   pricePerHour = null;
//   pricePerDay = null;
//   quantity = null;
//   minRentalDuration = null;
//   maxRentalDuration = null;
//   availabilityHours = null;
//   imagePaths.clear();
//   notifyListeners();
// }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['ar_name'] ?? 'Unnamed Category',
    );
  }
}

class ItemProvider with ChangeNotifier {
  List<Category> categories = [];
  String? selectedCategory;
  String? selectedStatus;
  String? selectedDeliveryMethod;
  String? itemName;
  String? itemDescription;
  String? location;
  double? priceAssurance;
  double? pricePerHour;
  double? pricePerDay;
  int? quantity;
  int? minRentalDuration;
  int? maxRentalDuration;
  int? availabilityHours;
  List<String> imagePaths = [];

  final String baseUrl =
      'http://192.168.47.1:8000/api'; // تأكد من تحديث الـ baseUrl

  ItemProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        categories = data.map((json) => Category.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  void setCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  void addImagePath(String path) {
    imagePaths.add(path);
    notifyListeners();
  }

  void setDeliveryMethod(String method) {
    selectedDeliveryMethod = method;
    notifyListeners();
  }

  void setItemName(String name) {
    itemName = name;
    notifyListeners();
  }

  void setItemDescription(String description) {
    itemDescription = description;
    notifyListeners();
  }

  void setLocation(String loc) {
    location = loc;
    notifyListeners();
  }

  void setPriceAssurance(double price) {
    priceAssurance = price;
    notifyListeners();
  }

  void setPricePerHour(double price) {
    pricePerHour = price;
    notifyListeners();
  }

  void setPricePerDay(double price) {
    pricePerDay = price;
    notifyListeners();
  }

  void setQuantity(int qty) {
    quantity = qty;
    notifyListeners();
  }

  void setMinRentalDuration(int duration) {
    minRentalDuration = duration;
    notifyListeners();
  }

  void setMaxRentalDuration(int duration) {
    maxRentalDuration = duration;
    notifyListeners();
  }

  void setAvailabilityHours(int hours) {
    availabilityHours = hours;
    notifyListeners();
  }

  // void addImagePath(String path) {
  //   imagePaths.add(path);
  //   notifyListeners();
  // }

  void clearImages() {
    imagePaths.clear();
    notifyListeners();
  }

  void resetData() {
    selectedCategory = null;
    selectedStatus = null;
    selectedDeliveryMethod = null;
    itemName = null;
    itemDescription = null;
    location = null;
    priceAssurance = null;
    pricePerHour = null;
    pricePerDay = null;
    quantity = null;
    minRentalDuration = null;
    maxRentalDuration = null;
    availabilityHours = null;
    imagePaths.clear();
    notifyListeners();
  }
}
