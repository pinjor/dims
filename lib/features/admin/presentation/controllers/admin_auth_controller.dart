import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/admin_api_service.dart';
import '../../data/models/admin_model.dart';

class AdminAuthController extends GetxController {
  final AdminApiService _apiService = AdminApiService();
  
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<AdminUser?> currentAdmin = Rx<AdminUser?>(null);
  final RxString accessToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Skip auth check on web to prevent initialization issues
    // Auth will be checked when user tries to login
  }

  Future<bool> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.login(username, password);
      
      if (response != null) {
        accessToken.value = response.accessToken;
        currentAdmin.value = response.adminUser;
        
        // Store token in SharedPreferences (web-compatible)
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('admin_access_token', response.accessToken);
        } catch (e) {
          // SharedPreferences might not work in some web environments
          print('Could not save token to SharedPreferences: $e');
        }
        
        return true;
      } else {
        errorMessage.value = 'Login failed. Please check your credentials.';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Login failed: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentAdmin() async {
    try {
      if (accessToken.value.isEmpty) return;
      
      final admin = await _apiService.getCurrentAdmin(accessToken.value);
      if (admin != null) {
        currentAdmin.value = admin;
      }
    } catch (e) {
      // Token is invalid, logout
      await logout();
    }
  }

  Future<void> logout() async {
    try {
      // Clear token from SharedPreferences (web-compatible)
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('admin_access_token');
      } catch (e) {
        print('Could not clear token from SharedPreferences: $e');
      }
      
      // Clear local state
      accessToken.value = '';
      currentAdmin.value = null;
      errorMessage.value = '';
      
      // Navigate to login
      Get.offAllNamed('/admin/login');
    } catch (e) {
      print('Logout error: $e');
    }
  }

  bool get isAuthenticated => accessToken.value.isNotEmpty && currentAdmin.value != null;
  
  String get authHeader => 'Bearer ${accessToken.value}';
}
