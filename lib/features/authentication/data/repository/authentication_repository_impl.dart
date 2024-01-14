import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource dataSource;

  const AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
