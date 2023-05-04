import 'dart:io';

import 'package:ecommerc_app/models/home_content.dart';
import 'package:ecommerc_app/view/screen/login_screen.dart';
import 'package:ecommerc_app/view/screen/register_screen.dart';
import 'package:ecommerc_app/view/splash_screen/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopCart',
      home: HomeContent.isLoggedIn ? const SplashScreen() : const LoginScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
