import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';

import 'package:bloc_login/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepository repository;

  const LoginUseCase({required this.repository});

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
