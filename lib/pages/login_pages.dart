import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/service/auth_service/firebase_service.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatefulWidget {
  final void Function()? ontap;
  const LoginPages({super.key, required this.ontap});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  //email and pw text Controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  //firebase auth log in method
  void login() async {
    //firebase init
    final FirebaseService firebaseService = FirebaseService();
    //show  loading
    loadingCircle();
    //try login
    try {
      await firebaseService.signin(
        email: _emailController.text,
        password: _pwController.text,
      );
      //pop loading
      if (!mounted) return;
      popPages();
      //catch any erore
    } catch (e) {
      //pop  loading
      if (!mounted) return;
      popPages();
      //show erore
      snackbar(e.toString());
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have account ? '),
                GestureDetector(
                  onTap: widget.ontap,
                  child: Text(
                    'Regiser Now',
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
