import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  //log out
  void logOut() {
    final firebaseService = FirebaseService();

    //logout
    firebaseService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Drawer call
      drawer: MyDrawer(),
      //appBar
      appBar: AppBar(
        title: Text('Chat App'),
        centerTitle: true,
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),
      body: Text('Just For test'),
    );
  }
}
