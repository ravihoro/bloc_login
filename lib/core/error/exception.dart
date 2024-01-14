import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {
  final String message;

  const CustomException({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerException extends CustomException {
  const ServerException({super.message = ""});
}

class LoginException extends CustomException {
  const LoginException({super.message = ""});
}

class SignUpException extends CustomException {
  const SignUpException({super.message = ""});
}
