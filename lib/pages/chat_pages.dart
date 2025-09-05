import 'package:chat_app/service/auth_service/firebase_service.dart';
import 'package:chat_app/service/chat_service/firestore_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          Expanded(child: _buildMessage()),
          //user input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type Message",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(width: 8),

                //sms send fuction
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    width: 90,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessage() {
    String senderId = firebaseService.currentUser!.uid;
    return StreamBuilder(
      stream: firestoreChat.getMessage(reciverId, senderId),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  //BUILD MESSAGE ITEM

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //current user
    bool isCurrentUser = data["senderId"] == firebaseService.currentUser!.uid;

    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Color bgcolor = isCurrentUser ? Colors.blue : Colors.white;

    Color textcolor = isCurrentUser ? Colors.white : Colors.black;

    return Container(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          data["message"],
          style: TextStyle(color: textcolor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
