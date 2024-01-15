import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _dataSource;

  const AuthenticationRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.login(
        email: email,
        password: password,
      );
      return Right(userModel);
    } on LoginException {
      return Left(
        const LoginFailure(),
      );
    } on ServerException {
      return Left(
        const ServerFailure(),
      );
    } catch (e) {
      return Left(
        const GenericFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var user = await _dataSource.signUp(
        email: email,
        password: password,
        name: name,
      );
      return Right(user);
    } on SignUpException {
      return Left(SignUpFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
