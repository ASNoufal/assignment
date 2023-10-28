import 'package:assignment/domain/stateauth/authentication_state.dart';
import 'package:assignment/infrastructure/auth/firebaseauth.dart';
import 'package:assignment/infrastructure/auth/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Authprovider extends ChangeNotifier {
  bool _isloading = false;
  Authentication _auth = Authentication();
  Map<String, dynamic> _data = {};
  UserCredential? _userCredential;
  Firestoredatas _fstore = Firestoredatas();

  bool get isloading => _isloading;
  Authentication get auth => _auth;
  Map<String, dynamic> get data => _data;
  UserCredential? get userCredential => _userCredential;
  Firestoredatas get fstore => _fstore;

  void signout() {
    final response = _auth.logout();
  }

  Future<UserCredential> loginwithemailandpassword(
      String email, String password) async {
    _isloading = true;
    notifyListeners();

    final response =
        await _auth.signinusernameandpassword(email: email, password: password);
    _isloading = false;
    notifyListeners();
    return response;
  }

  Future<UserCredential> signupemailandpassword(
      String email, String password) async {
    _isloading = true;
    var issucess = false;
    notifyListeners();
    try {
      final _userCredential = await _auth.registerusernameandpassword(
          email: email, password: password);

      final data = {
        'email': email,
        'password': password,
        'uuid': _userCredential.user!.uid
      };
      String uuid = _userCredential.user!.uid;

      issucess = await fstore.adddatatofirestore(
        data: data,
        collectionname: "user",
      );

      _isloading = false;
      notifyListeners();
      return _userCredential;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}

final authProvider = ChangeNotifierProvider<Authprovider>((ref) {
  return Authprovider();
});
