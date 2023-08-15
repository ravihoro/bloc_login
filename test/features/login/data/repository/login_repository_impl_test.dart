import 'dart:math';

import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/login/data/datasource/login_data_source.dart';
import 'package:bloc_login/features/login/data/repository/login_repository_impl.dart';
import 'package:bloc_login/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginDataSource])
void main() {
  MockLoginDataSource dataSource = MockLoginDataSource();

  LoginRepository repository = LoginRepositoryImpl(dataSource: dataSource);

  String username = "ravijohn";
  String email = "ravi.horo@gmail.com";
  String password = "Ravi@1234";

  User user = User(email: email, username: username);
  Either<Failure, User> loginFailure = Left(LoginFailure());
  Either<Failure, User> serverFailure = Left(ServerFailure());
  Either<Failure, User> genericFailure = Left(GenericFailure());

  test(
    'should be a successful login',
    () async {
      when(dataSource.login(email: email, password: password))
          .thenAnswer((_) async => user);

      var either = await repository.login(email: email, password: password);

      verify(dataSource.login(email: email, password: password));

      expect(either, Right(user));
    },
  );

  test(
    'should be a login failure',
    () async {
      when(dataSource.login(email: email, password: password))
          .thenAnswer((_) async => throw LoginException());

      var either = await repository.login(email: email, password: password);

      verify(dataSource.login(email: email, password: password));

      expect(either, loginFailure);
    },
  );

  test(
    'should be a server failure',
    () async {
      when(dataSource.login(email: email, password: password))
          .thenAnswer((_) async => throw ServerException());

      var either = await repository.login(email: email, password: password);

      verify(dataSource.login(email: email, password: password));

      expect(either, serverFailure);
    },
  );

  test(
    'should be a  failure',
    () async {
      when(dataSource.login(email: email, password: password))
          .thenAnswer((_) async => throw Exception());

      var either = await repository.login(email: email, password: password);

      verify(dataSource.login(email: email, password: password));

      expect(either, genericFailure);
    },
  );
}
