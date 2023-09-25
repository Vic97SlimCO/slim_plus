import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:slim_plus/Login/Login.dart';

void main() {
  WidgetsBinding widbin = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widbin);
  runApp(const Main());
}

