import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:bloc_login/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpDataSource dataSource;

  const SignUpRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      User user = await dataSource.signUp(
        username: username,
        email: email,
        password: password,
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
