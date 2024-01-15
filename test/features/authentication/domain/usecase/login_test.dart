import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  var _repository = MockAuthenticationRepository();

  var usecase = Login(_repository);

  const id = "1";
  const name = "Ravi";
  const email = "ravi@gmail.com";
  const password = "123456";

  var user = User(id: id, name: name, email: email, password: password);

  group('should test login usecase', () {
    test(
      'should test a successful login',
      () async {
        when(() => _repository.login(email: email, password: password))
            .thenAnswer((_) async => Right(user));

        var response = await usecase(email: email, password: password);

        expect(Right(user), response);
      },
    );

    test(
      'should be a login failure',
      () async {
        when(() => _repository.login(email: email, password: password))
            .thenAnswer((_) async => Left(LoginFailure()));

        var response = await usecase(email: email, password: password);

        expect(Left(LoginFailure()), response);
      },
    );

    test(
      'should be a server failure',
      () async {
        when(() => _repository.login(email: email, password: password))
            .thenAnswer((_) async => Left(ServerFailure()));

        var response = await usecase(email: email, password: password);

        expect(Left(ServerFailure()), response);
      },
    );

    test(
      'should be a generic failure',
      () async {
        when(() => _repository.login(email: email, password: password))
            .thenAnswer((_) async => Left(GenericFailure()));

        var response = await usecase(email: email, password: password);

        expect(Left(GenericFailure()), response);
      },
    );
  });
}
