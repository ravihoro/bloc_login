import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_cubit_test.mocks.dart';

@GenerateMocks([SignUpUsecase])
void main() {
  MockSignUpUsecase usecase = MockSignUpUsecase();

  String username = "ravijohn";
  String email = "ravi.horo@gmail.com";
  String password = "Ravi@1234";

  Either<Failure, User> successfulSignUp = Right(
    User(
      username: username,
      email: email,
    ),
  );

  var signUpFailure = const SignUpFailure();
  var serverFailure = const ServerFailure();
  var failure = const GenericFailure();

  blocTest<SignUpCubit, SignUpState>(
    'Should be a successful login',
    build: () => SignUpCubit(usecase: usecase),
    act: (signUpCubit) {
      when(usecase.signUp(username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => successfulSignUp);

      signUpCubit.signUp(username: username, email: email, password: password);

      verify(
          usecase.signUp(username: username, email: email, password: password));
    },
    expect: () => [
      const SignUpState(isLoading: true),
      const SignUpState(
        isLoading: false,
        isSignUpSuccessful: true,
      ),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'Should be a failed login',
    build: () => SignUpCubit(usecase: usecase),
    act: (signUpCubit) {
      when(usecase.signUp(username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => Left(signUpFailure));

      signUpCubit.signUp(username: username, email: email, password: password);

      verify(
          usecase.signUp(username: username, email: email, password: password));
    },
    expect: () => [
      const SignUpState(isLoading: true),
      SignUpState(isLoading: false, error: signUpFailure.error),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'Should be a server exception',
    build: () => SignUpCubit(usecase: usecase),
    act: (signUpCubit) {
      when(usecase.signUp(username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => Left(serverFailure));

      signUpCubit.signUp(username: username, email: email, password: password);

      verify(
          usecase.signUp(username: username, email: email, password: password));
    },
    expect: () => [
      const SignUpState(isLoading: true),
      SignUpState(isLoading: false, error: serverFailure.error),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'Should be an exception',
    build: () => SignUpCubit(usecase: usecase),
    act: (signUpCubit) {
      when(usecase.signUp(username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => Left(failure));

      signUpCubit.signUp(username: username, email: email, password: password);

      verify(
          usecase.signUp(username: username, email: email, password: password));
    },
    expect: () => [
      const SignUpState(isLoading: true),
      SignUpState(isLoading: false, error: failure.error),
    ],
  );
}
