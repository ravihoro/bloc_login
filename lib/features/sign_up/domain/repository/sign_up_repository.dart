import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<Failure, User>> signUp({
    required String email,
    required String username,
    required String password,
  });
}
