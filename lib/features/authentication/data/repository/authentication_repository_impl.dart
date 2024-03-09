import 'dart:developer';

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
      final responseModel = await _dataSource.login(
        email: email,
        password: password,
      );
      return Right(responseModel.data!);
    } on LoginException catch (e) {
      return Left(
        LoginFailure(error: e.message),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(error: e.message),
      );
    } catch (e) {
      log("login error: ${e.toString()}");
      return Left(
        GenericFailure(),
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
      var responseModel = await _dataSource.signUp(
        email: email,
        password: password,
        name: name,
      );
      return Right(responseModel.data!);
    } on SignUpException catch (e) {
      return Left(
        SignUpFailure(
          error: e.message,
        ),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          error: e.message,
        ),
      );
    } catch (e) {
      log("sign up error: ${e.toString()}");
      return Left(GenericFailure());
    }
  }
}
