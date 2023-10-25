import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = Inital;
  const factory AuthenticationState.loading() = Loading;
  const factory AuthenticationState.unauthenticated(String message) =
      Unauthenticated;
  const factory AuthenticationState.authenticated({required User user}) =
      Authenticated;
}
