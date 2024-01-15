import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:bloc_login/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDataSource {}

void main() {
  var name = "Ravi";
  var email = "ravi@gmail.com";
  var password = "123456";

  var user = UserModel(id: "1", email: email, password: password, name: "Ravi");

  var dataSource = MockAuthenticationDataSource();

  var repository = AuthenticationRepositoryImpl(dataSource);

  group(
    'should test login repository impl',
    () {
      test(
        'should be a successful login',
        () async {
          when(() => dataSource.login(
                email: email,
                password: password,
              )).thenAnswer(
            (_) async => user,
          );

          var response =
              await repository.login(email: email, password: password);

          verify(() => dataSource.login(email: email, password: password));

          expect(Right(user), response);
        },
      );

      test(
        'should be a login failure',
        () async {
          when(() => dataSource.login(email: email, password: password))
              .thenAnswer((_) => throw LoginException());

          var response =
              await repository.login(email: email, password: password);

          expect(Left(LoginFailure()), response);
        },
      );

      test(
        'should be a server failure',
        () async {
          when(() => dataSource.login(email: email, password: password))
              .thenAnswer((invocation) => throw ServerException());

          var response =
              await repository.login(email: email, password: password);

          expect(Left(ServerFailure()), response);
        },
      );

      test(
        'should be a generic failure',
        () async {
          when(() => dataSource.login(email: email, password: password))
              .thenAnswer((invocation) => throw Exception());

          var response =
              await repository.login(email: email, password: password);

          expect(Left(GenericFailure()), response);
        },
      );
    },
  );

  group(
    'should test sign up repository impl',
    () {
      test(
        'should be a successful sign up',
        () async {
          when(() => dataSource.signUp(
              email: email,
              password: password,
              name: name)).thenAnswer((_) async => user);

          var response = await repository.signUp(
              email: email, password: password, name: name);

          expect(Right(user), response);
        },
      );

      test(
        'should be a sign up failure',
        () async {
          when(() => dataSource.signUp(
              email: email,
              password: password,
              name: name)).thenAnswer((invocation) => throw SignUpException());

          var response = await repository.signUp(
              name: name, email: email, password: password);

          expect(Left(SignUpFailure()), response);
        },
      );

      test(
        'should be a server failure',
        () async {
          when(() => dataSource.signUp(
              email: email,
              password: password,
              name: name)).thenAnswer((invocation) => throw ServerException());

          var response = await repository.signUp(
              name: name, email: email, password: password);

          expect(Left(ServerFailure()), response);
        },
      );

      test(
        'should be a generic failure',
        () async {
          when(() => dataSource.signUp(
              email: email,
              password: password,
              name: name)).thenAnswer((invocation) => throw GenericFailure());

          var response = await repository.signUp(
              name: name, email: email, password: password);

          expect(Left(GenericFailure()), response);
        },
      );
    },
  );
}
