import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String error;

  const Failure(this.error);

  @override
  List<Object> get props => [error];
}

class GenericFailure extends Failure {
  const GenericFailure({String error = 'Some error occured'}) : super(error);
}

class ServerFailure extends Failure {
  const ServerFailure({String error = "Server failure"}) : super(error);
}

class LoginFailure extends Failure {
  const LoginFailure({String error = "Login failed"}) : super(error);
}

class SignUpFailure extends Failure {
  const SignUpFailure({String error = "Sign up failed"}) : super(error);
}
