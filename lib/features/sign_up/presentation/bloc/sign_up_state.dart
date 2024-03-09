import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String password;
  final bool isValid;

  const SignUpState({
    this.name = "",
    this.password = "",
    this.email = "",
    this.isValid = false,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isValid,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        isValid,
      ];
}
