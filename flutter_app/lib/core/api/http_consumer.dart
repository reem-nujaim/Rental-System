import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_signin/core/api/api_consumer.dart';

class HttpApiConsumer implements ApiConsumer {
  final String baseUrl;

  HttpApiConsumer({required this.baseUrl});

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: _buildHeaders());
    return _handleResponse(response);
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final response = await http.post(
      uri,
      headers: _buildHeaders(),
      body: data != null ? json.encode(data) : null,
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final response = await http.patch(
      uri,
      headers: _buildHeaders(),
      body: data != null ? json.encode(data) : null,
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final response = await http.delete(
      uri,
      headers: _buildHeaders(),
      body: data != null ? json.encode(data) : null,
    );
    return _handleResponse(response);
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception('HTTP Error: ${response.statusCode}, ${response.body}');
    }
  }
}
