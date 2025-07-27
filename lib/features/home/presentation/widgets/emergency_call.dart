// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Updated emergency call function with better error handling
// Future<void> callEmergencyNumber() async {
//   const phoneNumber = '01776830347';
//   final Uri launchUri = Uri(
//     scheme: 'tel',
//     path: phoneNumber,
//   );
//
//   try {
//     await launchUrl(launchUri, mode: LaunchMode.externalApplication);
//   } on PlatformException catch (e) {
//     debugPrint('PlatformException: ${e.message}');
//     // Show error to user if needed
//   } catch (e) {
//     debugPrint('Error launching phone: $e');
//   }
// }
