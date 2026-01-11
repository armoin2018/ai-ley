// services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}

class ApiService {
  static const String baseUrl = 'https://api.example.com';
  static const Duration timeout = Duration(seconds: 30);

  Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/users'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw ApiException(
          'Failed to fetch users',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } on http.ClientException {
      throw ApiException('Network error occurred');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<User> createUser(User user) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/users'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw ApiException(
          'Failed to create user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/users/${user.id}'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw ApiException(
          'Failed to update user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl/users/$userId'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      if (response.statusCode != 204) {
        throw ApiException(
          'Failed to delete user',
          response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }
}