// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assignment/infrastructure/auth/firebaseauth.dart';
import 'package:assignment/infrastructure/core/provider/providers.dart';
import 'package:assignment/presentation/Login/const.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:assignment/domain/auth/auth.dart';
import 'package:assignment/domain/stateauth/authentication_state.dart';

final authNotifierprovider =
    StateNotifierProvider<AuthNotifer, AuthenticationState>(
        (ref) => AuthNotifer(ref.read(authDataSourceProvider)));

class AuthNotifer extends StateNotifier<AuthenticationState> {
  final Iauthservice iauthservice;
  AuthNotifer(
    this.iauthservice,
  ) : super(const AuthenticationState.initial());

  Future<void> login({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await iauthservice.signinusernameandpassword(
        email: email, password: password);

    state = response.fold(
        (l) => AuthenticationState.unauthenticated(l.toString()),
        (r) => AuthenticationState.authenticated(user: r!));
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await iauthservice.registerusernameandpassword(
      email: email,
      password: password,
    );
    state = response.fold(
        (l) => AuthenticationState.unauthenticated(l.toString()),
        (r) => AuthenticationState.authenticated(user: r));
  }
}
