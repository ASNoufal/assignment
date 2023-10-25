// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment/infrastructure/core/provider/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/src/framework.dart';

import 'package:assignment/domain/auth/auth.dart';
import 'package:assignment/domain/authfailures/authfailures.dart';

class Authentication implements Iauthservice {
  FirebaseAuth firebaseAuth;
  Ref ref;
  Authentication({
    required this.firebaseAuth,
    required this.ref,
  });

  @override
  Future<Either<Authfailures, User>> registerusernameandpassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(Authfailures.emailalreadyinuse(e.toString()));
      } else if (e.code == "invalid-email" || e.code == "weak-password") {
        return left(Authfailures.emailalreadyinuse(e.toString()));
      } else {
        return left(Authfailures.clienterror(e.toString()));
      }
    }
  }

  @override
  Future<Either<Authfailures, User?>> signinusernameandpassword(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(response.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" ||
          e.code == "wrong-password" ||
          e.code == "user-not-found") {
        return left(Authfailures.emailandpasswordwrong(e.toString()));
      } else {
        return left(Authfailures.clienterror(e.toString()));
      }
    }
  }
}
