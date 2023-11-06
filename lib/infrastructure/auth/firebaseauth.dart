import 'package:firebase_auth/firebase_auth.dart';

import 'package:assignment/domain/auth/auth.dart';

class Authentication extends Iauthservice {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> registerusernameandpassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Future.error(e);
    }
  }

  @override
  Future<UserCredential> signinusernameandpassword(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Future.error(e);
    }
  }

  @override
  void logout() {
    firebaseAuth.signOut();
  }

  @override
  bool isuserlogin() {
    if (firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
