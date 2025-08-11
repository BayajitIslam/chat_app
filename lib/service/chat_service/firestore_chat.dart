import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreChat {
  //firestorei intense
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  //get message
}
