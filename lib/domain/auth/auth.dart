// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment/application/model/datamodel.dart';
import 'package:assignment/domain/authfailures/authfailures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

abstract class Iauthservice {
  Future<UserCredential> registerusernameandpassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signinusernameandpassword(
      {required String email, required String password});

  void logout();
  bool isuserlogin();
}

abstract class Istoreservice {
  Future adddatatofirestore({
    required Map<String, dynamic> data,
    required String collectionname,
  });

  Future updatedatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname});

  Future getdatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname});
}
