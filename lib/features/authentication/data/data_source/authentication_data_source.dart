import 'dart:convert';
import 'dart:developer';
import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationDataSource {
  Future<UserModel?> login({required String email, required String password});
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
    log("here");
    final response = await client.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    log("after");

    if (response.statusCode == 200) {
      log("200");
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      log("exception");
      return throw LoginException();
    }
  }
}
