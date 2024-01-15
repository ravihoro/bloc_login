import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthenticationRepository _repository;

  const Login(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
