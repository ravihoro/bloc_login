import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
