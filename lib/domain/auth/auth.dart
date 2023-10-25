// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment/domain/authfailures/authfailures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

abstract class Iauthservice {
  Future<Either<Authfailures, User>> registerusernameandpassword({
    required String email,
    required String password,
  });
  Future<Either<Authfailures, User?>> signinusernameandpassword(
      {required String email, required String password});
}
