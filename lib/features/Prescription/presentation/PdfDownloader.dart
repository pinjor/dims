import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PdfDownloader {
  static Future<bool> _checkAndRequestPermission(BuildContext context) async {
    // Check current permission status
    var status = await Permission.storage.status;

    // If permanently denied, show settings dialog
    if (status.isPermanentlyDenied) {
      await _showPermissionSettingsDialog(context);
      return false;
    }

    // If denied, request permission
    if (status.isDenied) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        await _showPermissionDeniedSnackbar(context);
        return false;
      }
    }

    // Handle Android 13+ specific permission
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        final manageStatus = await Permission.manageExternalStorage.status;
        if (manageStatus.isDenied) {
          await Permission.manageExternalStorage.request();
        }
      }
    }

    return true;
  }

  static Future<void> downloadPdf({
    required BuildContext context,
    required String sourcePath,
    required String fileName,
  }) async {
    try {
      // 1. Check and request permissions
      final hasPermission = await _checkAndRequestPermission(context);
      if (!hasPermission) return;

      // 2. Get destination directory
      final Directory? targetDir = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getDownloadsDirectory();

      if (targetDir == null || !await targetDir.exists()) {
        throw Exception("Couldn't access download directory");
      }

      // 3. Prepare destination file
      final String destPath = '${targetDir.path}/$fileName';
      final File sourceFile = File(sourcePath);
      final File destFile = File(destPath);

      // 4. Check if file exists and handle naming conflicts
      if (await destFile.exists()) {
        final newName = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
        return await downloadPdf(
          context: context,
          sourcePath: sourcePath,
          fileName: newName,
        );
      }

      // 5. Show download started
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Downloading file...'),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // 6. Copy the file
      await sourceFile.copy(destPath);

      // 7. Open the file and show success
      final openResult = await OpenFilex.open(destPath);
      if (context.mounted) {
        if (openResult.type == ResultType.done) {
          _showSuccessSnackbar(context, 'File downloaded successfully!');
        } else {
          _showErrorSnackbar(context,
              'Downloaded but failed to open: ${openResult.message}');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Download failed: ${e.toString()}');
      }
    }
  }

  static Future<void> _showPermissionSettingsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Please enable storage permission in app settings to download files.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  static Future<void> _showPermissionDeniedSnackbar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Storage permission is required to download files'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'SETTINGS',
            textColor: Colors.white,
            onPressed: () => openAppSettings(),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // margin: EdgeInsets.only(
            //   bottom: MediaQuery.of(context).size.height - 100,
            //   left: 20,
            //   right: 20,
            // ),
          ),
        ));
    }

  static void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}