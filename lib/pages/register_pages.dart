import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPages extends StatelessWidget {
  //email and pw text Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? ontap;

  RegisterPages({super.key,required this.ontap});

  //firebase auth log in method
  void register() {}

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
              'Let\'s Create an account for you',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            //Email TextField
            const SizedBox(height: 25),
            MyTextfield(hintext: 'Email', controller: _emailController),

            //Password TextField
            const SizedBox(height: 15),
            MyTextfield(hintext: 'Password', controller: _pwController),

            //Confitm Password TextField
            const SizedBox(height: 15),
            MyTextfield(
              hintext: 'Confirm Password',
              controller: _confirmPwController,
            ),

            //Login Button
            const SizedBox(height: 15),
            MyButton(buttonName: 'Register', ontap: register),

            //Allready Have Account ? Register Now
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have account ? '),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    'Login Now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
