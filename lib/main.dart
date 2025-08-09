import 'package:chat_app/pages/login_pages.dart';
import 'package:chat_app/theme/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPages(),
      theme: lightMode,
    );
  }
}
