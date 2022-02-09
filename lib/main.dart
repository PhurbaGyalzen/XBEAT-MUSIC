import 'package:flutter/material.dart';
import 'package:xbeat/pages/login.dart';
import 'package:flutter/services.dart';
import './services/service_locator.dart';
import 'package:get/get.dart';

void main() async {
  await setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
