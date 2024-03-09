import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  var email = "ravi.horo@gmail.com";
  var invalidEmail = "ravi.horo";
  var invalidPassword = "1234";
  var password = "Ravi@1234";

  blocTest<LoginCubit, LoginState>(
    'should test setting email',
    build: () {
      return LoginCubit();
    },
    act: (cubit) {
      cubit.setEmail(email);
    },
    expect: () => [
      LoginState(
        email: email,
        isValid: false,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'should test setting password',
    build: () {
      return LoginCubit();
    },
    act: (cubit) {
      cubit.setPassword(password);
    },
    expect: () => [
      LoginState(
        password: password,
        isValid: false,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'should be a valid',
    build: () {
      return LoginCubit();
    },
    act: (cubit) {
      cubit.setEmail(email);
      cubit.setPassword(password);
    },
    expect: () => [
      LoginState(
        email: email,
        isValid: false,
      ),
      LoginState(
        email: email,
        password: password,
        isValid: true,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'should be an invalid form due to invalid email',
    build: () {
      return LoginCubit();
    },
    act: (cubit) {
      cubit.setEmail(invalidEmail);
      cubit.setPassword(password);
    },
    expect: () => [
      LoginState(
        email: invalidEmail,
        isValid: false,
      ),
      LoginState(
        email: invalidEmail,
        password: password,
        isValid: false,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'should be an invalid form due to invalid password',
    build: () {
      return LoginCubit();
    },
    act: (cubit) {
      cubit.setEmail(email);
      cubit.setPassword(invalidPassword);
    },
    expect: () => [
      LoginState(
        email: email,
        isValid: false,
      ),
      LoginState(
        email: email,
        password: invalidPassword,
        isValid: false,
      ),
    ],
  );
}
