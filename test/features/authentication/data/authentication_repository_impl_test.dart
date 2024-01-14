import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:bloc_login/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDataSource {}

void main() {
  var email = "ravi@gmail.com";
  var password = "123456";

  var user = UserModel(id: "1", email: email, password: password, name: "Ravi");

  var dataSource = MockAuthenticationDataSource();

  var repository = AuthenticationRepositoryImpl(dataSource);

  test(
    'should be a successful login',
    () async {
      when(() => dataSource.login(
            email: email,
            password: password,
          )).thenAnswer(
        (_) async => user,
      );

      var response = await repository.login(email: email, password: password);

      verify(() => dataSource.login(email: email, password: password));

      expect(user, response);
    },
  );
}
