import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/sign_up/data/datasource/sign_up_data_source.dart';
import 'package:bloc_login/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpDataSource extends Mock implements SignUpDataSource {}

void main() {
  MockSignUpDataSource signUpDataSource = MockSignUpDataSource();

  SignUpRepositoryImpl signUpRepository = SignUpRepositoryImpl(
    dataSource: signUpDataSource,
  );

  String username = "ravijohn";
  String email = "ravi.horo@gmail.com";
  String password = "Ravi@1234";

  User successfulSignUp = User(email: email, username: username);
  Either<Failure, User> signUpFailure = Left(SignUpFailure());
  Either<Failure, User> serverFailure = Left(ServerFailure());
  Either<Failure, User> genericFailure = Left(GenericFailure());

  test(
    'should be a successful sign up',
    () async {
      when(() => signUpDataSource.signUp(
            username: username,
            email: email,
            password: password,
          )).thenAnswer((_) async => successfulSignUp);

      Either<Failure, User> either = await signUpRepository.signUp(
          username: username, email: email, password: password);

      verify(() => signUpDataSource.signUp(
          username: username, email: email, password: password));

      expect(either, Right(successfulSignUp));
    },
  );

  test(
    'should be a failed sign up',
    () async {
      when(() => signUpDataSource.signUp(
          username: username,
          email: email,
          password: password)).thenAnswer((_) async => throw SignUpException());

      var either = await signUpRepository.signUp(
          username: username, email: email, password: password);

      verify(() => signUpDataSource.signUp(
          username: username, email: email, password: password));

      expect(either, signUpFailure);
    },
  );

  test(
    'should be a server exception',
    () async {
      when(() => signUpDataSource.signUp(
              username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => throw ServerException());

      var either = await signUpRepository.signUp(
          username: username, email: email, password: password);

      verify(() => signUpDataSource.signUp(
          username: username, email: email, password: password));

      expect(either, serverFailure);
    },
  );

  test(
    'should be a generic exception',
    () async {
      when(() => signUpDataSource.signUp(
              username: username, email: email, password: password))
          .thenAnswer((realInvocation) async => throw Exception());

      var either = await signUpRepository.signUp(
          username: username, email: email, password: password);

      verify(() => signUpDataSource.signUp(
          username: username, email: email, password: password));

      expect(either, genericFailure);
    },
  );
}
