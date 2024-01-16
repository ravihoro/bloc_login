import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpState({this.name = "", this.password = "", this.email = ""});

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
      ];
}
