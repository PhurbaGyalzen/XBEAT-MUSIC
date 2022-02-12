import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xbeat/pages/login.dart';
import 'package:flutter/services.dart';
import './services/service_locator.dart';
import 'package:get/get.dart';

void main() async {
  // Initializing hive
  await Hive.initFlutter();
  await Hive.openBox('auth');
  await setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
