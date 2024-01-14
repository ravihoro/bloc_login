import 'dart:convert';
import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> signUp(
      {required String email, required String password, required String name});
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final http.Client client;

  const AuthenticationDataSourceImpl(this.client);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final apiUrl = "http://localhost:3000/login";
    final response = await client.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      return throw LoginException();
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final apiUrl = "http://localhost:3000/signUp";
    final response = await client.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "name": name,
        },
      ),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw SignUpException();
    }
  }
}
