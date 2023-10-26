// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment/infrastructure/core/provider/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/src/framework.dart';

import 'package:assignment/domain/auth/auth.dart';
import 'package:assignment/domain/authfailures/authfailures.dart';

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
