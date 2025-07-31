import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class StorageService {
  static Future<bool> hasStoragePermission() async {
    if (!Platform.isAndroid) return true;

    if (await _isAndroid13OrAbove()) {
      return await Permission.manageExternalStorage.isGranted;
    } else {
      return await Permission.storage.isGranted;
    }
  }

  static Future<bool> requestStoragePermission(BuildContext context) async {
    try {
      if (!Platform.isAndroid) return true;

      if (await _isAndroid13OrAbove()) {
        if (await Permission.manageExternalStorage.isGranted) return true;

        final status = await Permission.manageExternalStorage.request();
        if (status.isGranted) return true;

        await _showPermissionDialog(
          context,
          'For Android 13+, you need to grant "All files access" permission '
              'manually in app settings to download files.',
        );
        return false;
      } else {
        if (await Permission.storage.isGranted) return true;

        final status = await Permission.storage.request();
        if (status.isGranted) return true;

        await _showPermissionDialog(
          context,
          'Storage permission is required to download files. '
              'Please grant storage permission in settings.',
        );
        return false;
      }
    } catch (e) {
      debugPrint('Permission error: $e');
      return false;
    }
  }

  static Future<bool> _isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;
    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    } catch (e) {
      return false;
    }
  }

  static Future<void> _showPermissionDialog(
      BuildContext context, String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () async {
              Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 300));
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}