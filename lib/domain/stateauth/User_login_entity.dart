import 'package:assignment/domain/stateauth/field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'User_login_entity.freezed.dart';

@freezed
class UserLoginEntity with _$UserLoginEntity {
  const factory UserLoginEntity({
    required field email,
    required field password,
  }) = _UserLoginEntity;

  factory UserLoginEntity.initial() => const UserLoginEntity(
        email: field(value: ''),
        password: field(value: ''),
      );

  // bool get isValid => email.isValid & password.isValid;
}
