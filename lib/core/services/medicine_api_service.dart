import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicineApiService {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  // Get all medicines with pagination
  static Future<Map<String, dynamic>> getMedicines({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final url = '$baseUrl/medicines/?page=$page&size=$size';
      print('API Request: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load medicines: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception('Error fetching medicines: $e');
    }
  }
  
  // Get medicine by ID
  static Future<Map<String, dynamic>> getMedicineById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medicines/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load medicine: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching medicine: $e');
    }
  }
  
  // Search medicines with filters
  static Future<Map<String, dynamic>> searchMedicines({
    String? query,
    String? manufacturer,
    String? dosageForm,
    int page = 1,
    int size = 10,
  }) async {
    try {
      String url = '$baseUrl/medicines/search/?page=$page&size=$size';
      
      if (query != null && query.isNotEmpty) {
        url += '&query=${Uri.encodeComponent(query)}';
      }
      if (manufacturer != null && manufacturer.isNotEmpty) {
        url += '&manufacturer=${Uri.encodeComponent(manufacturer)}';
      }
      if (dosageForm != null && dosageForm.isNotEmpty) {
        url += '&dosage_form=${Uri.encodeComponent(dosageForm)}';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search medicines: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching medicines: $e');
    }
  }
  
  // Get medicines by manufacturer
  static Future<List<dynamic>> getMedicinesByManufacturer(String manufacturer) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/medicines/manufacturer/${Uri.encodeComponent(manufacturer)}'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load medicines by manufacturer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching medicines by manufacturer: $e');
    }
  }
  
  // Create a new medicine
  static Future<Map<String, dynamic>> createMedicine(Map<String, dynamic> medicineData) async {
    try {
      print('Creating medicine: $medicineData');
      
      final response = await http.post(
        Uri.parse('$baseUrl/medicines/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(medicineData),
      );
      
      print('Create Response Status: ${response.statusCode}');
      print('Create Response Body: ${response.body}');
      
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create medicine: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Create Error: $e');
      throw Exception('Error creating medicine: $e');
    }
  }
  
  // Update an existing medicine
  static Future<Map<String, dynamic>> updateMedicine(int id, Map<String, dynamic> medicineData) async {
    try {
      print('Updating medicine $id: $medicineData');
      
      final response = await http.put(
        Uri.parse('$baseUrl/medicines/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(medicineData),
      );
      
      print('Update Response Status: ${response.statusCode}');
      print('Update Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update medicine: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Update Error: $e');
      throw Exception('Error updating medicine: $e');
    }
  }
  
  // Delete a medicine
  static Future<void> deleteMedicine(int id) async {
    try {
      print('Deleting medicine $id');
      
      final response = await http.delete(
        Uri.parse('$baseUrl/medicines/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Delete Response Status: ${response.statusCode}');
      
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to delete medicine: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Delete Error: $e');
      throw Exception('Error deleting medicine: $e');
    }
  }
}
