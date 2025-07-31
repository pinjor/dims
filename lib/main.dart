import 'package:ecommerce/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true, ignoreSsl: true// optional: set to false to disable printing logs to console
  );
  runApp(craftybay());
}
