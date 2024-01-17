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

  setEmail(String? value) {
    emit(state.copyWith(
      email: value,
      isValid: isValidEmail(value) == null &&
          isValidPassword(state.password) == null,
    ));
  }

  setPassword(String? value) {
    emit(state.copyWith(
      password: value,
      isValid:
          isValidEmail(state.email) == null && isValidPassword(value) == null,
    ));
  }
}
