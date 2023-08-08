import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpState? initialState;
  final SignUpUsecase usecase;

  SignUpCubit({
    this.initialState,
    required this.usecase,
  }) : super(initialState ?? SignUpState());

  void signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true));
    Either<Failure, User> either = await usecase.signUp(
      username: username,
      email: email,
      password: password,
    );
    either.fold(
      (l) => emit(state.copyWith(
        isLoading: false,
        isSignUpSuccessful: false,
        error: l.error,
      )),
      (r) => emit(state.copyWith(
        isLoading: false,
        isSignUpSuccessful: true,
      )),
    );
  }
}
