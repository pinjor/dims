import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_auth_controller.dart';
import '../controllers/admin_medicine_controller.dart';
import 'admin_login_screen.dart';
import 'admin_dashboard_screen.dart';

class AdminWebApp extends StatelessWidget {
  const AdminWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DIMS Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
      home: const AdminAuthWrapper(),
      getPages: [
        GetPage(name: '/admin/login', page: () => const AdminLoginScreen()),
        GetPage(name: '/admin/dashboard', page: () => const AdminDashboardScreen()),
      ],
    );
  }
}

class AdminAuthWrapper extends StatelessWidget {
  const AdminAuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminAuthController authController = Get.find<AdminAuthController>();
    
    return Obx(() {
      if (authController.isAuthenticated) {
        return const AdminDashboardScreen();
      } else {
        return const AdminLoginScreen();
      }
    });
  }
}
