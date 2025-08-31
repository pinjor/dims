import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin_model.dart';

class AdminApiService {
  static const String baseUrl = 'http://192.168.80.158:8000/api/v1/admin';

  // Admin Authentication
  Future<AdminLoginResponse?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AdminLoginResponse.fromJson(data);
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<AdminUser?> getCurrentAdmin(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AdminUser.fromJson(data);
      } else {
        print('Get current admin failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Get current admin error: $e');
      return null;
    }
  }

  // Medicine Management
  Future<List<Medicine>?> getMedicines(String token, {int skip = 0, int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medicines?skip=$skip&limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Medicine.fromJson(json)).toList();
      } else {
        print('Get medicines failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Get medicines error: $e');
      return null;
    }
  }

  Future<Medicine?> getMedicine(String token, int medicineId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medicines/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Medicine.fromJson(data);
      } else {
        print('Get medicine failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Get medicine error: $e');
      return null;
    }
  }

  Future<Medicine?> createMedicine(String token, Map<String, dynamic> medicineData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/medicines'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(medicineData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Medicine.fromJson(data);
      } else {
        print('Create medicine failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Create medicine error: $e');
      return null;
    }
  }

  Future<Medicine?> updateMedicine(String token, int medicineId, Map<String, dynamic> medicineData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/medicines/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(medicineData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Medicine.fromJson(data);
      } else {
        print('Update medicine failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Update medicine error: $e');
      return null;
    }
  }

  Future<bool> deleteMedicine(String token, int medicineId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/medicines/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Delete medicine failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Delete medicine error: $e');
      return false;
    }
  }
}
