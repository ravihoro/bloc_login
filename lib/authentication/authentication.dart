import '../model/model.dart';
import 'package:meta/meta.dart';

class Authentication {
  UserList userList = UserList();

  void signUp({
    @required String name,
    @required String email,
    @required String password,
  }) {
    userList.addUser(User(name: name, email: email, password: password));
  }
}
