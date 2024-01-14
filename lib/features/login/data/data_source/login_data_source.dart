import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:http/http.dart' as http;

abstract class LoginDataSource {
  Future<User> login({required String email, required String password});
}

class LoginDataSourceImpl implements LoginDataSource {
  final http.Client client;

  LoginDataSourceImpl({required this.client});

  @override
  Future<User> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
