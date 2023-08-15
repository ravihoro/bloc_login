import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/login/domain/repository/login_repository.dart';
import 'package:bloc_login/features/login/domain/usecase/login_usecase.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginState? initialState;
  final LoginUseCase useCase;

  LoginCubit({required this.useCase, this.initialState})
      : super(initialState ?? LoginState());

  void login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true));
    var either = await useCase.login(email: email, password: password);
    either.fold(
      (l) => emit(state.copyWith(
        isLoading: false,
        errorString: l.error,
      )),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          user: User(
            email: r.email,
            username: r.username,
          ),
        ),
      ),
    );
  }
}
