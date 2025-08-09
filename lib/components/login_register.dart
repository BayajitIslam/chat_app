import 'package:chat_app/pages/login_pages.dart';
import 'package:chat_app/pages/register_pages.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //iinitaly show log in  pages
  bool showLoginPages = true;

  //toggle pages
  void togglePages() {
    setState(() {
      showLoginPages = !showLoginPages;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPages) {
      return LoginPages(
        ontap: togglePages,
      );
    } else {
      return RegisterPages(
        ontap: togglePages,
      );
    }
  }
}
