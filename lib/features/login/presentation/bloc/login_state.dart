import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;

  const LoginState({
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    bool isLoading = false,
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
