import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login {}

class MockSignUp extends Mock implements SignUp {}

void main() {
  var user = User(
    id: "1",
    name: "ravi",
    email: "ravi@gmail.com",
    password: "123456",
  );

  var login = MockLogin();
  var signUp = MockSignUp();

  late AuthenticationCubit authenticationCubit;
  var loginFailure = LoginFailure();
  var signUpFailure = SignUpFailure();
  var serverFailure = ServerFailure();
  var failure = GenericFailure();

  setUp(() {
    authenticationCubit = AuthenticationCubit(login: login, signUp: signUp);
  });

  group(
    'should test authentication cubit login usecase',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a successful user login',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => login(email: user.email, password: user.password))
              .thenAnswer((_) async => Right(user));

          cubit.login(
            email: user.email,
            password: user.password,
          );
        },
        expect: () => [
          AuthenticationState(user: user),
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a login failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => login(email: user.email, password: user.password))
              .thenAnswer((_) async => Left(loginFailure));

          cubit.login(email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: loginFailure.error,
          ),
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a server failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => login(email: user.email, password: user.password))
              .thenAnswer((_) async => Left(serverFailure));

          cubit.login(email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: serverFailure.error,
          )
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a generic failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => login(email: user.email, password: user.password))
              .thenAnswer((_) async => Left(failure));

          cubit.login(email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: failure.error,
          )
        ],
      );
    },
  );

  group(
    'should test authentication cubit sign up usecase',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a successful sign up',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => signUp(
              name: user.name,
              email: user.email,
              password: user.password)).thenAnswer(
            (_) async => Right(user),
          );

          cubit.signUp(
              name: user.name, email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(user: user),
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a sign up failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => signUp(
                  name: user.name, email: user.email, password: user.password))
              .thenAnswer((_) async => Left(signUpFailure));

          cubit.signUp(
              name: user.name, email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: signUpFailure.error,
          ),
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a server failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => signUp(
                  name: user.name, email: user.email, password: user.password))
              .thenAnswer((_) async => Left(serverFailure));

          cubit.signUp(
              name: user.name, email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: serverFailure.error,
          ),
        ],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should be a sign up failure',
        build: () => authenticationCubit,
        act: (cubit) {
          when(() => signUp(
              name: user.name,
              email: user.email,
              password: user.password)).thenAnswer((_) async => Left(failure));

          cubit.signUp(
              name: user.name, email: user.email, password: user.password);
        },
        expect: () => [
          AuthenticationState(
            error: failure.error,
          ),
        ],
      );
    },
  );
}
