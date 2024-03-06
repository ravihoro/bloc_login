import 'dart:convert';

import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/model/response_model.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockClient extends Mock implements Client {}

void main() {
  var http = MockClient();

  var dataSource = AuthenticationDataSourceImpl(http);

  var loginUri = Uri.parse("http://localhost:3000/login");

  var signUpUri = Uri.parse("http://localhost:3000/signUp");

  var userModel = UserModel(
    id: "1",
    name: "ravi",
    email: "ravi@gmail.com",
    password: "123456",
  );

  var loginBody = jsonEncode({
    "email": userModel.email,
    "password": userModel.password,
  });

  var signUpBody = jsonEncode({
    "email": userModel.email,
    "password": userModel.password,
    "name": "ravi"
  });

  var successResponseModel =
      ResponseModel<UserModel>(data: userModel, isSuccess: true);

  var successResponse =
      jsonEncode(successResponseModel.toJson((data) => data?.toJson()));

  var successLoginResponse = Response(successResponse, 200);

  var successSignUpResponse = Response(successResponse, 201);

  // var failedResponse = Response("Error", 400);

  // var emailPasswordMissingResponse =
  //     Response("Email and password missing", 400);
  // var emailMissingResponse = Response("Email missing", 400);
  // var passwordMissingResponse = Response("Password missing", 400);
  // var internalServerErrorResponse = Response("Internal server error", 500);
  // var userNotFoundResponse = Response("User not found", 404);

  group(
    'should test login',
    () {
      test(
        'should be a successful login',
        () async {
          when(() => http.post(
                loginUri,
                body: loginBody,
              )).thenAnswer(
            (_) async => successLoginResponse,
          );

          var response = await dataSource.login(
            email: userModel.email,
            password: userModel.password,
          );

          verify(() => http.post(loginUri, body: loginBody)).called(1);

          expect(response, successResponseModel);
        },
      );

      test(
        'should be a login exception',
        () async {
          when(() => http.post(loginUri, body: loginBody))
              .thenThrow(LoginException());

          expect(
            dataSource.login(
              email: userModel.email,
              password: userModel.password,
            ),
            throwsA(
              isA<LoginException>(),
            ),
          );
        },
      );
    },
  );

  group(
    'should test sign up',
    () {
      test(
        'should be a successful sign up',
        () async {
          when(() => http.post(
                signUpUri,
                body: signUpBody,
              )).thenAnswer(
            (_) async => successSignUpResponse,
          );

          var response = await dataSource.signUp(
            email: userModel.email,
            password: userModel.password,
            name: userModel.name,
          );

          verify(() => http.post(signUpUri, body: signUpBody)).called(1);

          expect(response, successResponseModel);
        },
      );

      test(
        'should be a sign up exception',
        () async {
          when(() => http.post(signUpUri, body: signUpBody))
              .thenAnswer((_) => throw SignUpException());

          expect(
            dataSource.signUp(
                email: userModel.email,
                password: userModel.password,
                name: userModel.name),
            throwsA(
              isA<SignUpException>(),
            ),
          );
        },
      );
    },
  );
}
