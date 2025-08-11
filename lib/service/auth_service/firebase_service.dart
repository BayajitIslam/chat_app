import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  //intense of auth and firestore
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //get user
  User? get currentUser => firebaseAuth.currentUser;
  //get authStateChanges
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  //Sign in and sign up method here
  //Sign in
  Future<UserCredential> signin({
    required String email,
    required String password,
  }) async {
    try {
      //sign in user
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save user info if doesn't already   exist  - separate doc
      firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      //create a user
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save user info in a separate doc
      firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout
  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
