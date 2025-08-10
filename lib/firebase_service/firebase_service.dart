import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  //init  firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
