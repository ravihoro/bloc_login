import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginState? initialState;

  LoginCubit({
    this.initialState,
  }) : super(
          initialState ?? LoginState(),
        );

  setLoader(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  setEmail(String? value) {
    emit(state.copyWith(email: value));
  }

  setPassword(String? value) {
    emit(state.copyWith(password: value));
  }
}
