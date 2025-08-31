import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'features/admin/presentation/screens/admin_web_app.dart';
import 'features/admin/presentation/controllers/admin_auth_controller.dart';
import 'features/admin/presentation/controllers/admin_medicine_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize FlutterDownloader
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  
  // Initialize controllers
  Get.put(AdminAuthController());
  Get.put(AdminMedicineController());
  
  runApp(const AdminWebApp());
}
