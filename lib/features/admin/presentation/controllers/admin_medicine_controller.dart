import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/admin_api_service.dart';
import '../../data/models/admin_model.dart';
import '../controllers/admin_auth_controller.dart';

class AdminMedicineController extends GetxController {
  final AdminApiService _apiService = AdminApiService();
  final AdminAuthController _authController = Get.find<AdminAuthController>();

  final RxList<Medicine> medicines = <Medicine>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadMedicines() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.getMedicines(_authController.authHeader);
      
      if (result != null) {
        medicines.value = result;
      } else {
        errorMessage.value = 'Failed to load medicines';
      }
    } catch (e) {
      errorMessage.value = 'Error loading medicines: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createMedicine(Map<String, dynamic> medicineData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.createMedicine(_authController.authHeader, medicineData);
      
      if (result != null) {
        medicines.add(result);
        return true;
      } else {
        errorMessage.value = 'Failed to create medicine';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error creating medicine: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateMedicine(int medicineId, Map<String, dynamic> medicineData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.updateMedicine(_authController.authHeader, medicineId, medicineData);
      
      if (result != null) {
        final index = medicines.indexWhere((m) => m.id == medicineId);
        if (index != -1) {
          medicines[index] = result;
        }
        return true;
      } else {
        errorMessage.value = 'Failed to update medicine';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error updating medicine: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMedicine(int medicineId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final success = await _apiService.deleteMedicine(_authController.authHeader, medicineId);
      
      if (success) {
        medicines.removeWhere((m) => m.id == medicineId);
        Get.snackbar(
          'Success',
          'Medicine deleted successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        errorMessage.value = 'Failed to delete medicine';
        Get.snackbar(
          'Error',
          'Failed to delete medicine',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage.value = 'Error deleting medicine: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Error deleting medicine: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<Medicine?> getMedicine(int medicineId) async {
    try {
      return await _apiService.getMedicine(_authController.authHeader, medicineId);
    } catch (e) {
      errorMessage.value = 'Error getting medicine: ${e.toString()}';
      return null;
    }
  }
}
