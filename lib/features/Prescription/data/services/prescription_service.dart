import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Add annotation for the entire class
@pragma('vm:entry-point')
class PrescriptionService {
  // Callback must be static and properly annotated
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    debugPrint('Download task ($id) is in status ($status) and progress ($progress)');
  }

  /// Main download method
  @pragma('vm:entry-point')
  static Future<void> downloadPrescription({
    required String prescriptionId,
    required String prescriptionTypeKey,
    required BuildContext context,
  }) async {
    try {
      // Initialize callback first
      await FlutterDownloader.registerCallback(downloadCallback);

      // Handle permissions
      if (!await _handlePermissions(context)) return;

      // Prepare download
      final url = _getDownloadUrl(prescriptionId, prescriptionTypeKey);
      final directory = await _getDownloadDirectory();
      if (directory == null) {
        _showError(context, 'Could not access download directory');
        return;
      }

      // Start download with proper headers
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: directory.path,
        fileName: 'prescription_${DateTime.now().millisecondsSinceEpoch}.pdf',
        showNotification: true,
        openFileFromNotification: true,
        headers: {
          'Accept': '*/*',
          // Remove Content-Type from headers as it's causing 406 error
        },
      );

      if (taskId == null) {
        _showError(context, 'Failed to start download');
      } else {
        _showSuccess(context, 'Download started successfully!');
      }
    } catch (e) {
      _showError(context, 'Download failed: ${e.toString()}');
    }
  }

  // Permission handling
  @pragma('vm:entry-point')
  static Future<bool> _handlePermissions(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        if (await _isAndroid13OrAbove()) {
          return await Permission.manageExternalStorage.request().isGranted;
        } else {
          return await Permission.storage.request().isGranted;
        }
      }
      return true;
    } catch (e) {
      _showError(context, 'Permission error: ${e.toString()}');
      return false;
    }
  }

  // Directory handling
  @pragma('vm:entry-point')
  static Future<Directory?> _getDownloadDirectory() async {
    try {
      return Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
    } catch (e) {
      return null;
    }
  }

  // Android version check
  @pragma('vm:entry-point')
  static Future<bool> _isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 33;
  }

  // URL construction
  @pragma('vm:entry-point')
  static String _getDownloadUrl(String id, String typeKey) {
    const baseUrl = 'http://192.168.10.106:9015/api/v1/opd/prescription-report';
    final encodedId = Uri.encodeComponent(id);
    switch (typeKey) {
      case 'OPD_GENERAL':
        return '$baseUrl/print-general-prescription-for-mobile-app?id=$encodedId&headerVisibility=true';
      case 'OPD_EYE':
        return '$baseUrl/print-eye-prescription-for-mobile-app?id=$encodedId&headerVisibility=true';
      case 'OPD_DENTAL':
        return '$baseUrl/print-dental-prescription-for-mobile-app?id=$encodedId&headerVisibility=true';
      case 'THERAPY':
        return '$baseUrl/print-therapy-prescription-for-mobile-app?id=$encodedId&headerVisibility=true';
      default:
        throw Exception('Unknown prescription type');
    }
  }

  // UI helpers
  @pragma('vm:entry-point')
  static void _showProgress(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @pragma('vm:entry-point')
  static void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}