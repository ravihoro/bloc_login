import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  var name = "Ravi";
  var email = "ravi.horo@gmail.com";
  var password = "123456";

  var invalidName = "";
  var invalidEmail = "ravi.horo@gmail";
  var invalidPassword = "1234";

  blocTest<SignUpCubit, SignUpState>(
    'should set name',
    build: () => SignUpCubit(),
    act: (cubit) {
      cubit.setName(name);
    },
    expect: () => [
      SignUpState(name: name, isValid: false),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'should set email',
    build: () => SignUpCubit(),
    act: (cubit) {
      cubit.setEmail(email);
    },
    expect: () => [
      SignUpState(email: email, isValid: false),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'should set password',
    build: () => SignUpCubit(),
    act: (cubit) {
      cubit.setPassword(password);
    },
    expect: () => [
      SignUpState(password: password, isValid: false),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'should be valid form',
    build: () => SignUpCubit(
      initialState: SignUpState().copyWith(
        name: name,
        email: email,
      ),
    ),
    act: (cubit) {
      cubit.setPassword(password);
    },
    expect: () => [
      SignUpState(
        name: name,
        email: email,
        password: password,
        isValid: true,
      ),
    ],
  );

  blocTest<SignUpCubit, SignUpState>(
    'should be an form due to invalid password',
    build: () => SignUpCubit(
      initialState: SignUpState().copyWith(
        name: name,
        email: email,
      ),
    ),
    act: (cubit) {
      cubit.setPassword(invalidPassword);
    },
    expect: () => [
      SignUpState(
        name: name,
        email: email,
        password: invalidPassword,
        isValid: false,
      ),
    ],
  );
  blocTest<SignUpCubit, SignUpState>(
    'should be an invalid form due to invalid name',
    build: () => SignUpCubit(
      initialState: SignUpState().copyWith(
        name: invalidName,
        email: email,
      ),
    ),
    act: (cubit) {
      cubit.setPassword(password);
    },
    expect: () => [
      SignUpState(
        name: invalidName,
        email: email,
        password: password,
        isValid: false,
      ),
    ],
  );
  blocTest<SignUpCubit, SignUpState>(
    'should be an invalid form due to invalid email',
    build: () => SignUpCubit(
      initialState: SignUpState().copyWith(
        name: name,
        email: invalidEmail,
      ),
    ),
    act: (cubit) {
      cubit.setPassword(password);
    },
    expect: () => [
      SignUpState(
        name: name,
        email: invalidEmail,
        password: password,
        isValid: false,
      ),
    ],
  );
}
