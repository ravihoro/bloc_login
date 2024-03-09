import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  var _repository = MockAuthenticationRepository();

  var usecase = SignUp(_repository);

  const id = "1";
  const name = "Ravi";
  const email = "ravi@gmail.com";
  const password = "123456";

  var user = User(
    id: id,
    name: name,
    email: email,
  );

  group('should test sign usecase', () {
    test(
      'should be a successful signup',
      () async {
        when(() => _repository.signUp(
            name: name,
            email: email,
            password: password)).thenAnswer((_) async => Right(user));

        var response =
            await usecase(email: email, password: password, name: name);

        expect(Right(user), response);
      },
    );

    test(
      'should be a signup failure',
      () async {
        when(() => _repository.signUp(
            name: name,
            email: email,
            password: password)).thenAnswer((_) async => Left(SignUpFailure()));

        var response =
            await usecase(email: email, password: password, name: name);

        expect(Left(SignUpFailure()), response);
      },
    );

    test(
      'should be a server failure',
      () async {
        when(() => _repository.signUp(
            name: name,
            email: email,
            password: password)).thenAnswer((_) async => Left(ServerFailure()));

        var response =
            await usecase(email: email, password: password, name: name);

        expect(Left(ServerFailure()), response);
      },
    );

    test(
      'should be a generic failure',
      () async {
        when(() => _repository.signUp(
                name: name, email: email, password: password))
            .thenAnswer((_) async => Left(GenericFailure()));

        var response =
            await usecase(email: email, password: password, name: name);

        expect(Left(GenericFailure()), response);
      },
    );
  });
}
