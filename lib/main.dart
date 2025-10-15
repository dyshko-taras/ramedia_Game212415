import 'package:code/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const App(),
    ),
  );
}
