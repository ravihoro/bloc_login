import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/login/data/datasource/login_data_source.dart';
import 'package:bloc_login/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  const LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      User user = await dataSource.login(email: email, password: password);
      return Right(user);
    } on LoginException {
      return const Left(LoginFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(GenericFailure());
    }
  }
}
