import 'package:flutter/material.dart';
import 'package:rgc_admin/gest_app_detail.dart';
import 'package:rgc_admin/gest_approval.dart';
import 'package:rgc_admin/login.dart';
import 'package:rgc_admin/splash.dart';
import 'package:rgc_admin/webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ('/splash'),
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/login": (context) => const Login(),
          "/webview": (context) => const AdminOfRgc(),
          "/gest_approval": (context) => const GuestApprovel(),
          "/gest_app_detail": (context) => const GestAppDetail(),
        });
  }
}
