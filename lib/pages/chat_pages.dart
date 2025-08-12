import 'package:chat_app/service/auth_service/firebase_service.dart';
import 'package:chat_app/service/chat_service/firestore_chat.dart';
import 'package:flutter/material.dart';

class ChatPages extends StatelessWidget {
  final String reciverMail;
  final String reciverId;
  ChatPages({super.key, required this.reciverMail, required this.reciverId});

  //text Controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth service
  final FirestoreChat firestoreChat = FirestoreChat();
  final FirebaseService firebaseService = FirebaseService();

  //send  message
  void sendMessage() async {
    //if there is smothing  inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send the message
      await firestoreChat.sendMessage(reciverId, _messageController.text);

      //cleat the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(reciverMail),
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: Text('All  Message')
          ),
          //user input
        ],
      ),
    );
  }
}
