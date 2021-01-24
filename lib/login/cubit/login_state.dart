part of 'login_cubit.dart';

class LoginState {
  final Email email;
  final Password password;
  final bool userPresent;
  final FormzStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.userPresent = true,
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({
    Email email,
    Password password,
    bool userPresent,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      userPresent: userPresent ?? this.userPresent,
      status: status ?? this.status,
    );
  }
}
