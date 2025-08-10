import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

class RegisterPages extends StatefulWidget {
  final void Function()? ontap;

  const RegisterPages({super.key, required this.ontap});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  //email and pw text Controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  final TextEditingController _confirmPwController = TextEditingController();

  //firebase auth log in method
  void register() async {
    //firebase init
    final firebaseService = FirebaseService();

    //Show loading circle
    loadingCircle();

    //check password same or note
    if (_pwController.text == _confirmPwController.text) {
      //if password match try log in
      try {
        await firebaseService.signUp(
          email: _emailController.text,
          password: _pwController.text,
        );
        //pop  loading
        if (!mounted) return;
        popPages();
        //try catch erore
      } catch (e) {
        //pop loading
        popPages();
        //Show erore
        snackbar(e.toString());
      }
    } else {
      //pop  loadin
      popPages();
      //show erore
      snackbar('Password doesn\'t match');
    }
  }

  //loading  circle
  void loadingCircle() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }

  //pop pages
  void popPages() {
    Navigator.pop(context);
  }

  //snackbar show erore
  void snackbar(String eroreMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(eroreMessage)));
  }

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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have account ? '),
                GestureDetector(
                  onTap: widget.ontap,
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
