import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class SignUp {
  final AuthenticationRepository _repository;

  const SignUp(this._repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _repository.signUp(
        name: name, email: email, password: password);
  }
}
