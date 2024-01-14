import 'dart:convert';

import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockClient extends Mock implements Client {}

void main() {
  var http = MockClient();

  var dataSource = AuthenticationDataSourceImpl(http);

  var uri = Uri.parse("http://localhost:3000/login");

  var userModel = UserModel(
    id: "1",
    name: "ravi",
    email: "ravi@gmail.com",
    password: "123456",
  );

  var body =
      jsonEncode({"email": userModel.email, "password": userModel.password});

  var successResponse = Response(jsonEncode(userModel.toJson()), 200);

  var failedResponse = Response("Error", 400);

  test(
    'should be a successful login',
    () async {
      when(() => http.post(
            uri,
            body: body,
          )).thenAnswer(
        (_) async => successResponse,
      );

      var response = await dataSource.login(
        email: userModel.email,
        password: userModel.password,
      );

      expect(response, userModel);
    },
  );

  test(
    'should be a login exception',
    () async {
      when(() => http.post(uri, body: body))
          .thenAnswer((_) async => failedResponse);

      expect(
        () async => await dataSource.login(
          email: userModel.email,
          password: userModel.password,
        ),
        throwsA(
          isA<LoginException>(),
        ),
      );
    },
  );
}
