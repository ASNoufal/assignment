import 'package:assignment/domain/stateauth/User_login_entity.dart';
import 'package:assignment/domain/stateauth/field.dart';
import 'package:assignment/domain/stateauth/user_login_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Userloginformstate extends StateNotifier<UserLoginFormState> {
  Userloginformstate() : super(UserLoginFormState(UserLoginEntity.initial()));

  void setemail(String email) {
    final isemail = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+").hasMatch(email);
    UserLoginEntity _form = state.form.copyWith(email: field(value: email));

    late field emailfield;
    if (isemail) {
      emailfield = _form.email.copyWith(isValid: true, errormessage: "");
    } else {
      emailfield = _form.email
          .copyWith(isValid: true, errormessage: "ops,email is not valid");
    }
    state = state.copyWith(form: _form.copyWith(email: emailfield));
  }
}

final userloginformstate =
    StateNotifierProvider<Userloginformstate, UserLoginFormState>(
        (ref) => Userloginformstate());
