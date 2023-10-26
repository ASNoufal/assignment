import 'package:assignment/domain/stateauth/User_login_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_login_form_state.freezed.dart';

@freezed
class UserLoginFormState with _$UserLoginFormState {
  const factory UserLoginFormState(UserLoginEntity form) = _UserLoginFormState;
}
