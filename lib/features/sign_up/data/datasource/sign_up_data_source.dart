import 'dart:convert';

import 'package:bloc_login/core/error/exception.dart';
import 'package:bloc_login/core/model/response_model.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/core/utils/constant.dart';
import 'package:http/http.dart' as http;

abstract class SignUpDataSource {
  Future<User> signUp({
    required String username,
    required String email,
    required String password,
  });
}

class SignUpDataSourceImpl implements SignUpDataSource {
  final http.Client client;

  const SignUpDataSourceImpl({required this.client});

  @override
  Future<User> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('$baseUrl/signup'),
      body: jsonEncode(
          {"username": username, "email": email, "password": password}),
    );
    if (response.statusCode == 201) {
      var responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      if (responseModel.user == null) {
        throw SignUpException();
      } else {
        return responseModel.user!;
      }
    } else if (response.statusCode == 401) {
      throw SignUpException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else {
      throw Exception();
    }
  }
}
