import 'dart:convert';
import 'dart:developer';
import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/model/response_model.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationDataSource {
  Future<ResponseModel<UserModel>> login({
    required String email,
    required String password,
  });

  Future<ResponseModel<UserModel>> signUp({
    required String email,
    required String password,
    required String name,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final http.Client _client;

  const AuthenticationDataSourceImpl(this._client);

  @override
  Future<ResponseModel<UserModel>> login({
    required String email,
    required String password,
  }) async {
    final apiUrl = "http://192.168.29.163:3000/login";
    log("email: $email password: $password");
    var body = jsonEncode(
      {
        "email": email,
        "password": password,
      },
    );
    log("body is: $body");
    final response = await _client.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    log("login response: ${response.body}");

    var responseModel = ResponseModel<UserModel>.fromJson(
        jsonDecode(response.body), UserModel.fromJson);
    if (response.statusCode == 200) {
      return responseModel;
    } else {
      return throw LoginException(message: responseModel.message ?? "");
    }
  }

  @override
  Future<ResponseModel<UserModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final apiUrl = "http://localhost:3000/signUp";
    final response = await _client.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "name": name,
        },
      ),
    );

    var responseModel = ResponseModel<UserModel>.fromJson(
        jsonDecode(response.body), UserModel.fromJson);
    if (response.statusCode == 201) {
      return responseModel;
    } else {
      throw SignUpException(message: responseModel.message ?? "");
    }
  }
}
