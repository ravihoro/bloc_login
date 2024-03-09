import 'dart:developer';

import 'package:bloc_login/core/utils/validators.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginState? initialState;

  LoginCubit({
    this.initialState,
  }) : super(
          initialState ?? LoginState(),
        );

  bool isValid({String? email, String? password}) {
    email = email ?? state.email;
    password = password ?? state.password;
    return isValidEmail(email) == null && isValidPassword(password) == null;
  }

  setEmail(String? value) {
    emit(state.copyWith(
      email: value,
      isValid: isValid(email: value),
    ));
  }

  setPassword(String? value) {
    log("set password: $value");
    emit(state.copyWith(
      password: value,
      isValid: isValid(password: value),
    ));
  }
}
