import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/service/auth_service/firebase_service.dart';
import 'package:chat_app/service/chat_service/firestore_chat.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  //log out
  void logOut() {
    final firebaseService = FirebaseService();

    //logout
    firebaseService.logout();
  }

  //firestore  service intense
  final FirestoreChat _firestoreChat = FirestoreChat();
  //firebase seriver intense
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Drawer call
      drawer: MyDrawer(),
      //appBar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Chat App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),
      body: _buildUserList(),
    );
  }

  //build a user list exept cureent log in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _firestoreChat.getUserStream(),
      builder: (context, snapshot) {
        //errore
        if (snapshot.hasError) {
          return const Text('Errore');
        }

        //load
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        //listview
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buiildUserListItem(userData))
              .toList(),
        );
      },
    );
  }

  //build individual list tile for user
  Widget _buiildUserListItem(Map<String, dynamic> userData) {
    if (userData['email'] != _firebaseService.currentUser!.email) {
      return UserTile(email: userData['email'],
       ontap: () {});
    } else {
      return Container();
    }
  }
}
