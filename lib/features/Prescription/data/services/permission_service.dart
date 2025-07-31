import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    try {
      // For Android 13+ (API 33+), we need to request different permissions
      if (await Permission.storage.isRestricted) {
        return await Permission.manageExternalStorage.request().isGranted;
      }

      final status = await Permission.storage.request();
      return status.isGranted;
    } catch (e) {
      return false;
    }
  }

  static Future<void> openAppSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      // Handle any errors that might occur
    }
  }
}