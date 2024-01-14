import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/login/domain/usecase/login_usecase.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  MockLoginUseCase usecase = MockLoginUseCase();
  LoginCubit loginCubit = LoginCubit(useCase: usecase);

  String username = "ravijohn";
  String email = "ravi.horo@gmail.com";
  String password = "Ravi@1234";

  User user = User(
    email: email,
    name: username,
    id: "",
    password: "",
  );
  var loginFailure = const LoginFailure();
  var serverFailure = const ServerFailure();
  var failure = const GenericFailure();

  blocTest<LoginCubit, LoginState>(
    "should be a successful login",
    build: () => loginCubit,
    act: (loginCubit) {
      when(() => usecase.login(email: email, password: password))
          .thenAnswer((_) async => Right(user));

      loginCubit.login(email: email, password: password);

      verify(() => usecase.login(email: email, password: password));
    },
    expect: (() => [
          const LoginState(isLoading: true),
          LoginState(user: user, isLoading: false),
        ]),
  );

  blocTest<LoginCubit, LoginState>(
    "should be a failed login",
    build: () => loginCubit,
    act: (loginCubit) {
      when(() => usecase.login(email: email, password: password))
          .thenAnswer((_) async => Left(loginFailure));

      loginCubit.login(email: email, password: password);

      verify(() => usecase.login(email: email, password: password));
    },
    expect: (() => [
          const LoginState(isLoading: true),
          LoginState(
            isLoading: false,
            errorString: loginFailure.error,
          )
        ]),
  );

  blocTest<LoginCubit, LoginState>(
    "should be a server exception",
    build: () => loginCubit,
    act: (loginCubit) {
      when(() => usecase.login(email: email, password: password))
          .thenAnswer((_) async => Left(serverFailure));

      loginCubit.login(email: email, password: password);

      verify(() => usecase.login(email: email, password: password));
    },
    expect: (() => [
          const LoginState(isLoading: true),
          LoginState(
            isLoading: false,
            errorString: serverFailure.error,
          )
        ]),
  );

  blocTest<LoginCubit, LoginState>(
    "should be an exception",
    build: () => loginCubit,
    act: (loginCubit) {
      when(() => usecase.login(email: email, password: password))
          .thenAnswer((_) async => Left(failure));

      loginCubit.login(email: email, password: password);

      verify(() => usecase.login(email: email, password: password));
    },
    expect: (() => [
          const LoginState(isLoading: true),
          LoginState(
            isLoading: false,
            errorString: failure.error,
          )
        ]),
  );
}
