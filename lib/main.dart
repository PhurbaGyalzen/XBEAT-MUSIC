import 'package:flutter/material.dart';
import 'package:xbeat/pages/root_app.dart';
import 'package:flutter/services.dart';
import './services/service_locator.dart';

void main() async{
  await setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootApp(),
  ));
}
