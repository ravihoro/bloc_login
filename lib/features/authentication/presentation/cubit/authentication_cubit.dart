import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationState? initialState;

  final Login _login;
  final SignUp _signUp;

  AuthenticationCubit({
    this.initialState,
    required Login login,
    required SignUp signUp,
  })  : _login = login,
        _signUp = signUp,
        super(initialState ?? AuthenticationState(user: User.empty));

  emitUser(User? user) {
    emit(state.copyWith(user: user));
  }

  setIsLoginPage(bool value) {
    emit(state.copyWith(isLoginPage: value));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    log("auth cubit: $password");
    var either = await _login(email: email, password: password);
    either.fold(
      (l) => emit(
        state.copyWith(
          user: User.empty,
          error: l.error,
        ),
      ),
      (r) => emit(
        state.copyWith(user: r),
      ),
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    var either = await _signUp(name: name, email: email, password: password);
    either.fold(
      (l) => emit(
        state.copyWith(
          error: l.error,
        ),
      ),
      (r) => emit(
        state.copyWith(user: r),
      ),
    );
  }

  void logout() {
    emit(state.copyWith(user: User.empty));
  }
}
