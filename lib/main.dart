import 'package:two_min/app_initializer.dart';
import 'package:two_min/di/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:two_min/app.dart';

void main() async {
  // NOTE: This is required for accessing the method channel before runApp().
  WidgetsFlutterBinding.ensureInitialized();
  await setupAppInit();
  await setupServiceLocator();
  runApp(const MyApp());
}
