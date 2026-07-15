import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/userReport_model.dart';

class ReportProvider with ChangeNotifier {
  UserReport? _report;
  bool _isLoading = false;
  String? _errorMessage; // تخزين رسالة الخطأ في حالة الفشل

  UserReport? get report => _report;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchReport(String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('$baseUrl/report');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          _report = UserReport.fromJson(data);
        } else {
          _errorMessage = 'Invalid response format';
        }
      } else {
        _errorMessage = 'Failed to load report: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "خطأ أثناء جلب التقرير: $error";
    }

    _isLoading = false;
    notifyListeners();
  }
}
