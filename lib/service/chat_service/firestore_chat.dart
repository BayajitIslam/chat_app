import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreChat {
  //firestore and firebaseauth intense
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //get stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each individual user
        final user = doc.data();

        //retur user
        return user;
      }).toList();
    });
  }

  //send message

  Future<void> sendMessage(String reciverId, String message) async {
    //get current user info
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      timestamp: timestamp,
    );

    //construct  chat room Id fro ther two user( sorted to ensure uniqueness)
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add new message to database
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessage(String userID, otherUserId) {
    //contstruct a chatroom id for ther two user
    List<String> ids = [userID, otherUserId];
    ids.sort();
    String chatRoomId = ids.join();

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('message')
        .orderBy("timestamp",descending: false)
        .snapshots();
  }
}
