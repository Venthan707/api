import 'dart:io';
import 'package:flutter/material.dart';
import 'Registration/registration.dart';
import 'cert.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: registration(),
    );
  }
}
