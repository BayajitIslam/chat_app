import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  //email and pw text Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  LoginPages({super.key});

  //firebase auth log in method
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //App logo Here
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            //Wellcome Message
            const SizedBox(height: 50),
            Text(
              'Wellcome back, you\'ve  been missed!',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            //Email TextField
            const SizedBox(height: 25),
            MyTextfield(hintext: 'Email', controller: _emailController),

            //Password TextField
            const SizedBox(height: 15),
            MyTextfield(hintext: 'Password', controller: _pwController),

            //Login Button
            const SizedBox(height: 15),
            MyButton(buttonName: 'Login', ontap: login),
            //Allready Have Account ? Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have account ? '),
                Text(
                  'Regiser Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
